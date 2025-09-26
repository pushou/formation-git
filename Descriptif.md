# Descriptif de la formation git

## Objectifs

- Comprendre les principes de la gestion de version distribuée
- Pouvoir gérer des versions de documents textuels avec l’outil git
- Collaborer efficacement à l’aide des forges logicielles (GitHub, GitLab)



## Public

Toute profession pratiquant l’édition collaborative de documents texte brut (code source de programmes, fichiers de configurations, documents LaTeX...).


## Pré-requis

Comprendre les manipulations de fichier de base du _shell_ Unix (cd/mkdir/ls/cat/diff/…) ainsi que les redirections des sorties > et >>.


## Programme

### Partie 1 : Gestion de version avec git

1. **Introduction, répertoire de travail et index**

   - De la gestion de version à git en particulier
   - Configurer git et créer un dépôt
   - Répertoire de travail et état de git
   - Définir le périmètre de la gestion de version

2. **Gérer un historique**

   - De l'index au _commit_
   - Créer et explorer un historique
   - Donner un nom à une version
   - Premières commandes d'annulation

3. **Manipulation de branches**

   - Utilité d'un historique divergent
   - Créer des branches
   - Fusionner des changements
   - Résoudre des conflits de fusion

4. **Dépôts distribués**

   - Notion de _remote_
   - Gestion des collisions d'identifiants
   - Du clonage aux outils de synchronisation
   - Précautions à prendre en environnement distribué



### Partie 2 : De Git à la forge logicielle

1. **Introduction aux forges logicielles et prise en main de GitLab/GitHub**

   - Qu’est-ce qu’une forge logicielle ?
   - Différences entre GitHub et GitLab
   - Modèles de collaboration : collaboration ouverte (*forks*) vs collaboration fermée (projet commun)
   - Préparation aux communications sécurisées (clé SSH)

2. **Gérer un projet collaboratif sur une forge**

   - Créer un nouveau projet ou contribuer à un projet existant
   - Gérer la visibilité, les membres, les rôles et les permissions
   - Organiser les tâches via le système de tickets
   - Réviser, commenter et valider des contributions à l’aide de *merge requests*

3. **Intégration et déploiement continus (CI/CD)**

   - Concepts de CI/CD et mise en œuvre sur GitLab/GitHub
   - Créer, exécuter et inspecter un pipeline
   - Gérer la persistance des données (artefacts)
   - Déployer automatiquement un site statique avec GitLab/GitHub Pages


### Bonus

Des sujets plus avancés pourront être abordés à la carte selon la demande et le temps disponible. Par exemple :

1. **Fonctionnalités avancées de git :**

- La recherche de l'origine d'un problème avec `bisect`
- Les alternatives à la fusion `rebase` et `cherry-pick`
- Les nombreux modes de fonctionnement de `checkout` et `reset`
- Les outils d'annulation plus avancées comme les _reflogs_
- Les sous-modules et l'extension git LFS

2. **Fonctionnalités avancées de CI/CD :**

- Jobs conditionnels et règles (rules)
- Gestion du cache et couverture de tests
- Passage d’artefacts entre jobs
- Publication de packages via GitLab Package Registry
- Création automatisée de releases
- Utilisation de variables et secrets
- Utilisation de services dans les jobs (Gitlab)
- Gestion des runners personnalisés GitLab
- Planification des exécutions (schedules)

## Méthodes pédagogiques

Alternance d’apports théoriques et d’exercices pratiques.
