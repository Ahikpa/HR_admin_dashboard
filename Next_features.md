
✦ Excellente question. Maintenant que la structure de base est fonctionnelle (le backend parle à la base de données, et le frontend
  parle au backend), l'étape logique est d'enrichir l'application pour la rendre réellement utile et interactive, pour qu'elle
  devienne un vrai "dashboard".

  Voici les prochaines étapes logiques, par ordre de complexité croissante :

   1. Améliorer l'affichage des données (Frontend) :
       * Recherche et Filtrage : Ajouter un champ de recherche au-dessus du tableau pour filtrer les employés par nom ou par e-mail en
         temps réel. C'est probablement l'étape la plus utile et la plus naturelle maintenant.
       * Pagination : Si la liste d'employés est longue, on ne veut pas tout charger d'un coup. Ajouter des boutons "Page suivante" /
         "Page précédente" est une amélioration classique.
       * Tri : Permettre de cliquer sur les en-têtes de colonnes (par exemple sur "Nom" ou "Salaire") pour trier le tableau.

   2. Ajouter des fonctionnalités de "Dashboard" :
       * Statistiques et Indicateurs : Créer une nouvelle zone dans l'interface qui affiche des chiffres clés (ex: Nombre total
         d'employés, Salaire moyen). Cela nécessiterait de créer une nouvelle route dans l'API (ex: /api/stats).
       * Graphiques : Ajouter une visualisation simple, comme un graphique montrant le nombre d'employés par département.

   3. Permettre la gestion des données (CRUD) :
       * Ajouter, Modifier, Supprimer : Mettre en place des formulaires pour créer un nouvel employé, des boutons pour modifier ou
         supprimer un employé existant. C'est la partie la plus complexe car elle implique de sécuriser l'API et de gérer l'état des
         données avec plus de rigueur.

  Je vous suggère de commencer par l'étape 1. Recherche et Filtrage. C'est une fonctionnalité fondamentale pour ce type
  d'application, qui nous amènera à faire évoluer à la fois le frontend et le backend de manière cohérente.

  Qu'en pensez-vous ?

---

## Feuille de Route "Database as Code" (DbC) : Progression

Maintenant que le workflow de base "Database as Code" est maîtrisé, voici les prochaines étapes pour approfondir vos compétences et passer de débutant à intermédiaire, puis à avancé.

### De Débutant à Intermédiaire

1.  **Migration de Données (pas seulement le Schéma) :**
    *   **Défi :** Gérer les changements de *données* (ex: tables de référence, données de configuration) qui doivent être versionnés et déployés avec les changements de schéma.
    *   **Concepts :** Utilisation de `loadData` de Liquibase ou de scripts SQL personnalisés pour les changements de données. Comprendre la différence entre les migrations DDL (schéma) et DML (données).
    *   **Action :** Ajoutez une nouvelle table de référence (ex: `JOB_GRADES`) avec des données initiales, puis modifiez ces données dans une version ultérieure, le tout géré par SQLcl/Liquibase.

2.  **Fonctionnalités Avancées de Liquibase :**
    *   **Défi :** Explorer des types de changements et des fonctionnalités plus complexes de Liquibase.
    *   **Concepts :**
        *   `preconditions` : S'assurer que certaines conditions sont remplies avant l'exécution d'un changeset (ex: la table existe, la colonne n'existe pas).
        *   `contexts` et `labels` : Appliquer des changesets de manière conditionnelle (ex: uniquement pour les environnements `dev` ou `prod`, ou pour des fonctionnalités spécifiques).
        *   `rollback` : Comprendre comment définir et exécuter des rollbacks pour les changesets.
        *   `includeAll` : Gérer les changelogs de manière plus efficace sur plusieurs fichiers/répertoires.
    *   **Action :** Implémentez une fonctionnalité qui nécessite un déploiement conditionnel ou une stratégie de rollback spécifique.

### De Intermédiaire à Avancé

1.  **Intégration CI/CD :**
    *   **Défi :** Automatiser l'ensemble du workflow "Database as Code" au sein d'un pipeline d'Intégration Continue/Livraison Continue (CI/CD).
    *   **Concepts :** Jenkins, GitLab CI/CD, GitHub Actions, Azure DevOps. Déclenchement de builds sur les push Git, déploiement automatisé vers les environnements de test, approbation manuelle pour la production.
    *   **Action :** Mettez en place un pipeline CI/CD de base qui exécute automatiquement `project export`, `project stage`, `project release`, `project gen-artifact`, et déploie vers une base de données de test chaque fois que des changements sont poussés vers une branche spécifique.

2.  **Refactoring et Évolution du Schéma :**
    *   **Défi :** Gérer des changements de schéma complexes comme la division de tables, le renommage de colonnes ou la modification de types de données sans temps d'arrêt ni perte de données.
    *   **Concepts :** Conception de base de données évolutive, modèles de refactoring "sûrs" (ex: modèle expand-contract), gestion des grands ensembles de données.
    *   **Action :** Implémentez un refactoring significatif (ex: division de la table `EMPLOYEES` en `EMPLOYEES` et `EMPLOYEE_CONTACTS`) en utilisant une stratégie de migration sûre en plusieurs étapes.

3.  **Optimisation des Performances des Migrations :**
    *   **Défi :** S'assurer que les migrations de base de données sont rapides et ne causent pas de goulots d'étranglement de performance, en particulier dans les grands environnements de production.
    *   **Concepts :** Stratégies d'indexation, évitement des balayages complets de table pendant les migrations, optimisation du DDL/DML pour la vitesse.
    *   **Action :** Analysez la performance d'une migration complexe et identifiez les zones d'optimisation.

4.  **Sécurité dans le Database as Code :**
    *   **Défi :** Mettre en œuvre les meilleures pratiques de sécurité pour l'accès à la base de données, les identifiants et les données sensibles dans le workflow DbC.
    *   **Concepts :** Coffres-forts (HashiCorp Vault, Azure Key Vault), variables d'environnement, principe du moindre privilège, audit.
    *   **Action :** Intégrez une solution de gestion des secrets pour les identifiants de base de données dans votre pipeline CI/CD.

5.  **Bases de Données Multiples/Persistance Polyglotte :**
    *   **Défi :** Gérer les changements de base de données sur différentes technologies de base de données (ex: Oracle et PostgreSQL, ou une base de données NoSQL).
    *   **Concepts :** Couches d'abstraction de base de données, outils de migration courants (ex: Flyway, scripts personnalisés pour différentes bases de données).
    *   **Action :** Explorez comment Liquibase ou d'autres outils peuvent gérer les migrations pour un type de base de données différent.

---

**Approche d'Apprentissage Générale :**

*   **Pratique Pratique :** Le plus important est de continuer à pratiquer. Créez de petits projets isolés pour chaque défi.
*   **Lisez la Documentation :** Plongez plus profondément dans la documentation de SQLcl Projects et Liquibase.
*   **Communauté et Ressources :** Engagez-vous avec les communautés Oracle et DevOps. Recherchez des blogs, des tutoriels et des projets open source.
*   **Scénarios Réels :** Pensez aux problèmes du monde réel que vous pourriez rencontrer dans un cadre professionnel et essayez de les résoudre en utilisant DbC.