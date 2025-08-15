# Guide Complet : Workflow "Database as Code" avec SQLcl Projects

Ce document détaille le workflow "Database as Code" implémenté dans ce projet, en utilisant SQLcl Projects et Liquibase. Il vise à fournir une compréhension claire du processus et des solutions aux problèmes courants rencontrés.

---

## Introduction

Le concept de "Database as Code" (DbC) consiste à gérer le schéma de votre base de données de la même manière que le code de votre application : versionné, scripté et déployé de manière automatisée et reproductible. SQLcl Projects, avec son intégration de Liquibase, est un outil puissant pour atteindre cet objectif avec les bases de données Oracle.

---

## Prérequis

Avant de commencer, assurez-vous d'avoir les outils suivants installés et configurés :

*   **SQLcl (SQL Developer Command Line) :** Version récente supportant les commandes `project`. Assurez-vous qu'il est accessible depuis votre ligne de commande (ajouté à votre `PATH`).
*   **Git :** Pour le contrôle de version de tous les scripts de base de données et les fichiers de configuration.
*   **Base de Données Oracle :** Une instance Oracle Database avec au moins deux schémas (utilisateurs) :
    *   `APP_USER` (ou similaire) : Votre schéma de développement, où vous effectuez les modifications et exportez le schéma.
    *   `PROD_USER` (ou similaire) : Votre schéma de production, où vous déployez les changements. Cet utilisateur doit avoir les privilèges nécessaires pour créer des objets dans son propre schéma.

---

## Concepts Clés

### Schémas de Développement vs Production (`APP_USER` vs `PROD_USER`)

Pour simuler un environnement de développement et de production, nous utilisons des schémas (utilisateurs) distincts au sein de la même instance de base de données Oracle.

*   **`APP_USER` (Développement) :** Votre espace de travail. C'est ici que vous testez vos scripts de migration et que vous effectuez les modifications de schéma.
*   **`PROD_USER` (Production) :** L'environnement "propre" et stable. Les changements y sont appliqués uniquement via des scripts testés et validés.

### L'Importance de `export.setTransform.emitSchema`

Cette propriété de configuration SQLcl est **CRUCIALE** pour un déploiement multi-schémas réussi.

*   **`emitSchema : true` (par défaut) :** SQLcl inclut le nom du schéma dans les instructions DDL générées (par exemple, `CREATE TABLE APP_USER.EMPLOYEES ...`). Si vous tentez de déployer cela sur `PROD_USER`, cela échouera avec une erreur de privilèges (`ORA-01031`) car `PROD_USER` n'a pas le droit de créer des objets dans le schéma `APP_USER`.
*   **`emitSchema : false` :** SQLcl génère le DDL sans le préfixe du schéma (par exemple, `CREATE TABLE EMPLOYEES ...`). C'est le comportement souhaité pour un déploiement flexible.

### Le Rôle de Git dans le Workflow

Git est le pilier du "Database as Code". Chaque modification de schéma, chaque configuration SQLcl, et chaque changelog Liquibase doit être versionné. Cela assure la traçabilité, la collaboration et la reproductibilité.

---

## Le Workflow "Database as Code" Complet (Étape par Étape)

Ce workflow décrit la séquence des commandes SQLcl et Git pour gérer les évolutions de votre schéma de base de données.

**Assurez-vous d'être connecté au schéma approprié dans SQLcl pour chaque étape.**

### Phase 1 : Initialisation du Projet et Configuration Essentielle

Cette phase est exécutée une seule fois au début du projet.

1.  **Initialiser le projet SQLcl :**
    *   **Dans SQLcl (connecté à `APP_USER`) :**
        ```sql
        project init -name hr_project
        ```
    *   **Explication :** Crée le répertoire `.dbtools/` et les fichiers de configuration de base.

2.  **Configurer les schémas à gérer :**
    *   **Dans SQLcl (connecté à `APP_USER`) :**
        ```sql
        project config set -name schemas -value APP_USER
        ```
    *   **Explication :** Indique à SQLcl quel(s) schéma(s) il doit exporter et gérer.

3.  **Désactiver l'émission du nom de schéma dans le DDL exporté :**
    *   **Dans SQLcl (connecté à `APP_USER`) :**
        ```sql
        project config set -name export.setTransform.emitSchema -value false
        ```
    *   **Explication :** C'est la solution au problème `ORA-01031` lors du déploiement sur un schéma différent. **Cette étape est cruciale et doit être faite avant le premier `project export`.**

4.  **Committer la configuration initiale du projet :**
    *   **Dans votre terminal (dans le répertoire racine du projet) :**
        ```bash
        git add .dbtools/
        git commit -m "feat: Initial SQLcl project setup and essential configuration"
        ```
    *   **Explication :** Versionne les fichiers de configuration de SQLcl.

### Phase 2 : Export du Schéma et Versionnement du DDL

Cette phase est exécutée chaque fois que vous modifiez manuellement votre schéma de développement (`APP_USER`) ou que vous souhaitez capturer son état actuel.

1.  **Exporter le schéma de la base de données :**
    *   **Dans SQLcl (connecté à `APP_USER`) :**
        ```sql
        project export
        ```
    *   **Explication :** Lit le schéma de `APP_USER` et génère des fichiers `.sql` pour chaque objet (tables, vues, séquences, contraintes) dans `src/database/app_user/`. Ces fichiers ne contiendront pas le préfixe du schéma grâce à la configuration précédente.

2.  **Committer les fichiers DDL exportés :**
    *   **Dans votre terminal :**
        ```bash
        git add src/database/app_user/
        git commit -m "feat: Exported current schema DDL without schema prefix"
        ```
    *   **Explication :** Versionne l'état actuel de votre schéma de base de données.

### Phase 3 : Génération des Changelogs Liquibase et Staging

Cette phase prépare les modifications de schéma pour le déploiement.

1.  **Générer les changelogs Liquibase :**
    *   **Dans SQLcl (connecté à `APP_USER`) :**
        ```sql
        project stage
        ```
    *   **Explication :** Compare l'état actuel des fichiers DDL dans `src/database/app_user/` avec le dernier état committé et génère les scripts de migration Liquibase nécessaires dans `dist/releases/next/changes/`.

2.  **Committer les changelogs générés :**
    *   **Dans votre terminal :**
        ```bash
        git add dist/releases/next/changes/
        git add dist/releases/next/release.changelog.xml
        git commit -m "chore: Staged Liquibase changelogs for next release"
        ```
    *   **Explication :** Versionne les scripts de migration qui seront utilisés pour mettre à jour les autres environnements.

### Phase 4 : Création de la Release et Génération de l'Artefact

Cette phase prépare un package déployable de votre schéma.

1.  **Créer une release du projet :**
    *   **Dans SQLcl (connecté à `APP_USER`) :**
        ```sql
        project release -version 1.0 # Utilisez le numéro de version approprié
        ```
    *   **Explication :** Marque un ensemble de changements comme une version officielle.

2.  **Générer l'artefact de déploiement :**
    *   **Dans SQLcl (connecté à `APP_USER`) :**
        ```sql
        project gen-artifact -version 1.0 # Utilisez le même numéro de version que la release
        ```
    *   **Explication :** Crée un fichier `.zip` (par exemple, `hr_project-1.0.zip`) dans le répertoire `artifact/` contenant tous les scripts nécessaires au déploiement.

3.  **Committer l'artefact généré :**
    *   **Dans votre terminal :**
        ```bash
        git add artifact/
        git add dist/releases/1.0/ # Le répertoire de la release est également créé ici
        git commit -m "chore: Generated deployment artifact for version 1.0"
        ```
    *   **Explication :** Versionne le package déployable.

### Phase 5 : Déploiement vers l'Environnement de Production

Cette phase applique les changements de schéma à votre base de données de production.

1.  **Déployer l'artefact :**
    *   **Dans SQLcl (connecté à `PROD_USER`) :**
        ```sql
        project deploy -file artifact/hr_project-1.0.zip # Assurez-vous que le chemin et le nom du fichier sont corrects
        ```
    *   **Explication :** Exécute les scripts de migration contenus dans l'artefact pour mettre à jour le schéma `PROD_USER`.

---

## Dépannage des Problèmes Courants

### 1. Erreur `ORA-01031: privilèges insuffisants` lors du déploiement

*   **Cause :** Le DDL en cours de déploiement contient un préfixe de schéma (par exemple, `CREATE TABLE APP_USER.EMPLOYEES`) alors que vous tentez de le créer dans un schéma différent (`PROD_USER`). `PROD_USER` n'a pas les privilèges pour créer des objets dans le schéma `APP_USER`.
*   **Solution :** Assurez-vous que `export.setTransform.emitSchema` est défini sur `false` dans `.dbtools/project.config.json` **avant** d'exécuter `project export` et `project stage`. Si vous avez déjà généré des artefacts avec l'erreur, vous devrez suivre le workflow complet depuis l'exportation pour régénérer des changelogs corrects.

### 2. Problèmes d'incohérence Git (`Changes not staged`, `Untracked files`, `index.lock`)

*   **Cause :** Le workflow Git n'a pas été suivi rigoureusement (oublis de `git add`, `git commit`, ou processus Git bloqués).
*   **Solution :**
    *   **Nettoyer le répertoire de travail :**
        ```bash
        git restore .           # Annule les modifications non stagées des fichiers suivis
        git restore --staged .  # Déstage les fichiers stagés
        git clean -fd           # Supprime les fichiers et répertoires non suivis (ATTENTION : destructif !)
        ```
    *   **Assurer des commits fréquents et logiques :** Après chaque commande `project` qui modifie des fichiers (export, stage, gen-artifact), exécutez `git add` et `git commit` pour versionner ces changements.

### 3. SQLcl non trouvé ou erreur de classe principale (`Erreur : impossible de trouver ou charger la classe principale...`)

*   **Cause :** SQLcl n'est pas correctement installé ou son chemin n'est pas ajouté à la variable d'environnement `PATH` de votre système.
*   **Solution :** Vérifiez votre installation de SQLcl et assurez-vous que le répertoire `bin` de SQLcl est inclus dans votre `PATH`.

---

## Commandes SQLcl Générales Utiles

Ces commandes peuvent être utiles lors de l'utilisation de la console SQLcl.

*   `connect <user>/<pass>@<service>` : Se connecter à une base de données.
*   `show user` : Afficher l'utilisateur actuellement connecté.
*   `spool <nom_fichier>.sql` / `spool off` : Enregistrer la sortie de la console dans un fichier.
*   `set serveroutput on size unlimited` : Activer l'affichage des messages (nécessaire pour `DBMS_OUTPUT`).
*   `set long <nombre>` : Définir la taille maximale des chaînes de caractères longues affichées.
