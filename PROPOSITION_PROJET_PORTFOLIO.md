# Proposition de Projet de Portfolio : "HR_admin_dashboard"

Ceci est une proposition structurée pour construire un projet de portfolio impressionnant qui combine SQLcl, la gestion de versions de base de données, et le développement web avec React.

### L'état d'esprit à adopter : "Database as Code"

Le principe est de traiter les changements de votre base de données (création de table, ajout de colonne, etc.) de la même manière que vous traitez le code de votre application :

1.  **Tout est scripté :** Aucune modification manuelle en production.
2.  **Tout est versionné :** Chaque changement est tracé dans Git.
3.  **Le processus est répétable :** Le même script doit pouvoir mettre à jour n'importe quel environnement (DEV, TEST, PROD) de manière fiable.

SQLcl est un outil parfait pour cela car il intègre **Liquibase**, un standard de l'industrie pour la gestion des migrations de bases de données.

---

### Concept du Projet

**Nom :** "HR_admin_dashboard"

**Description :** Une application web (React) qui permet de visualiser et de gérer les employés de la base de données HR. Le vrai point fort du portfolio ne sera pas l'application elle-même, mais le **workflow de déploiement et de migration de la base de données** que vous allez mettre en place.

**Composants du projet :**

1.  **Frontend :** Une application React simple.
2.  **Backend :** Une API légère (Node.js/Express ou Python/FastAPI) qui communique avec la base de données.
3.  **Base de Données :** Scripts de migration gérés par **SQLcl et Liquibase**.
4.  **Contrôle de Version :** Le tout dans un monorepo **Git**.

---

### Plan d'Action Détaillé

#### Étape 1 : Structurer votre projet Git

Créez une arborescence de dossiers claire :

```
hr-admin-dashboard/
├── database/
│   ├── changelogs/      # Vos scripts de migration SQL
│   └── liquibase.conf   # Fichier de config Liquibase (optionnel)
├── backend/
│   ├── package.json
│   └── server.js        # Votre API Express.js
└── frontend/
    ├── package.json
    └── src/             # Votre code React
```

#### Étape 2 : Initialiser la Base de Données avec SQLcl/Liquibase

1.  **Créer le premier changelog :**
    Dans `database/changelogs/`, créez `v1.0__create_initial_schema.sql`.

    ```sql
    -- liquibase formatted sql

    -- changeset your_name:1
    -- comment: Creation of the initial HR schema tables
    CREATE TABLE regions (
        region_id NUMBER CONSTRAINT regions_id_nn NOT NULL,
        region_name VARCHAR2(25)
    );
    -- ... (DDL pour JOBS, DEPARTMENTS, EMPLOYEES, etc.)
    ```

2.  **Appliquer la migration en DÉVELOPPEMENT :**
    Dans SQLcl, connectez-vous à votre base de développement (`DEV_USER`) et exécutez :

    ```bash
    cd /path/to/project/database
    sql /nolog
    SQL> connect DEV_USER/password@your_db
    SQL> liquibase update --changelog-file=changelogs/v1.0__create_initial_schema.sql
    ```

#### Étape 3 : Développer l'API et le Frontend

1.  **Backend :** Créez une API simple avec Node.js/Express qui se connecte à `DEV_USER` et expose des routes comme `GET /api/employees`.
2.  **Frontend :** Créez une application React qui consomme cette API.
3.  **Commitez tout sur Git.**

#### Étape 4 : Simuler une Évolution (Le Workflow DevOps)

**Scénario :** Ajouter la date de naissance (`date_of_birth`) aux employés.

1.  **Créer une nouvelle migration :**
    Créez `database/changelogs/v1.1__add_dob_to_employees.sql`.

    ```sql
    -- liquibase formatted sql

    -- changeset your_name:2
    -- comment: Add date_of_birth column to employees table
    ALTER TABLE employees ADD (
      date_of_birth DATE
    );
    ```

2.  **Mettre à jour votre base DEV :**
    `SQL> liquibase update --changelog-file=changelogs/v1.1__add_dob_to_employees.sql`

3.  **Mettre à jour votre code (API et React) pour utiliser le nouveau champ.**
4.  **Commitez à nouveau sur Git.**

#### Étape 5 : Déployer en "Production"

1.  **Connectez-vous à l'utilisateur de production (`PROD_USER`).**
2.  **Appliquez toutes les migrations en attente de manière automatique :**

    ```sql
    SQL> connect PROD_USER/prod_password@your_db
    SQL> liquibase update --changelog-file=changelogs/ --search-path=changelogs/
    ```

    Liquibase appliquera uniquement les changesets manquants.

### Ce que vous montrez dans votre Portfolio

- **Maîtrise de SQLcl** comme outil d'automatisation.
- **Gestion de Schéma de BDD** avec Liquibase.
- **Workflow DevOps** de DEV à PROD.
- **Intégration Git** cohérente.
- **Compétences Full-Stack** (React, Node.js/Python, SQL).

---

✦ Excellente question, c'est un point fondamental et il est crucial de bien le comprendre.

Actuellement, dans notre discussion, DEV et PROD ne sont pas des conteneurs Docker, mais des "environnements" logiques. Pour un
projet comme celui-ci, la manière la plus simple et la plus courante de les mettre en place est d'utiliser des schémas
(utilisateurs) différents au sein de la même instance de base de données Oracle.

Pensez-y de cette manière :

- Votre Base de Données Oracle (l'Instance) : C'est un grand bâtiment. Ce bâtiment peut être un conteneur Docker, un logiciel
  installé sur votre PC, ou une base de données dans le cloud.
- Vos Environnements (DEV et PROD) : Ce sont des appartements séparés à l'intérieur de ce bâtiment. Chaque appartement appartient
  à un utilisateur différent (DEV_USER, PROD_USER) et les murs sont solides : ce qui se passe dans un appartement n'affecte pas
  l'autre.

---

Qu'est-ce que DEV et PROD concrètement ?

1.  `DEV_USER` (Votre Atelier de Développement)

    - Objectif : C'est votre espace de travail personnel. C'est ici que vous testez vos scripts de migration (liquibase update),
      que vous faites des expériences, que vous cassez des choses et que vous les réparez.
    - Qui y accède ? Vous seul, via votre application en local et via SQLcl.
    - Conséquence : Si vous faites une erreur et supprimez une table, seule votre base de développement est affectée.
      L'application "live" continue de fonctionner.

2.  `PROD_USER` (Le Site en Ligne)
    - Objectif : C'est l'environnement "propre" et stable que vos utilisateurs finaux (ou un recruteur évaluant votre projet)
      utiliseraient.
    - Qui y accède ? Votre application "déployée".
    - Conséquence : On ne touche à cet environnement qu'avec des scripts testés et validés (ceux que vous avez d'abord fait
      fonctionner sur DEV_USER). Les changements sont rares et contrôlés.

---

Comment "Switcher" entre les deux ?

Le "switch" se fait au moment de la connexion. Vous n'êtes jamais connecté aux deux en même temps. Vous choisissez délibérément
sur quel environnement vous voulez travailler.

1. Switcher dans SQLcl

C'est la commande connect.

- Pour travailler en développement :
  Vous vous connectez avec l'utilisateur de développement. Toutes les commandes (liquibase update, SELECT, etc.) s'appliqueront
  au schéma de DEV_USER.

1 SQL> connect DEV_USER/votre_mot_de_passe_dev@service_db
2 -- Vous êtes maintenant dans l'environnement DEV

- Pour déployer en production :
  Vous vous déconnectez et vous reconnectez avec l'utilisateur de production. La commande liquibase update s'appliquera alors
  au schéma de PROD_USER.

1 SQL> connect PROD_USER/mot_de_passe_prod_super_secret@service_db
2 -- Vous êtes maintenant dans l'environnement PROD

2. Switcher dans votre Application (Backend)

Votre application web (Node.js/Python) a un fichier de configuration où sont stockées les informations de connexion à la base de
données. C'est là que le switch s'opère.

La meilleure pratique est d'utiliser des variables d'environnement.

Exemple en Node.js :

    1 // Dans votre fichier de connexion à la base (db.js)
    2
    3 const oracledb = require('oracledb');
    4
    5 // Les credentials sont lus depuis les variables d'environnement
    6 // Si elles ne sont pas définies, on utilise celles de DEV par défaut.
    7 const dbConfig = {
    8     user: process.env.DB_USER || "DEV_USER",
    9     password: process.env.DB_PASSWORD || "votre_mot_de_passe_dev",

10 connectString: "localhost/XE" // ou votre service_db
11 };
12
13 async function connectToDatabase() {
14 await oracledb.createPool(dbConfig);
15 }
16
17 module.exports = { connectToDatabase };

- Pour lancer en mode DEV : Vous lancez simplement votre application. Elle se connectera à DEV_USER par défaut.
- Pour lancer en mode PROD : Vous lancez votre application en spécifiant les variables d'environnement.

1 # Sur un serveur de production
2 export DB_USER=PROD_USER
3 export DB_PASSWORD=mot_de_passe_prod_super_secret
4 node server.js
