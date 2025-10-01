# <a href="Pres5-Reseau.pdf" target="blank">Réseau et forges</a>


Dans cette seconde partie consacrée aux forges et au travail collaboratif avec Git, je vous propose un exercice d'édition collective autour d'un de nos trésors nationaux : le patrimoine gastronomique français.

Pourquoi la cuisine, me direz-vous ? Parce que les recettes constituent un terrain de jeu parfait pour s'initier à la gestion de version en équipe. Elles sont universelles, évolutives, et soulèvent inévitablement des débats passionnés : faut-il vraiment mettre de la crème dans la carbonara ? La quiche lorraine supporte-t-elle une touche de fromage ? Et l'éternel duel pain au chocolat contre chocolatine ne mériterait-il pas d'être enfin tranché par un commit ?

Bref, les recettes réunissent tous les ingrédients d'un bon support pédagogique : elles sont simples à manipuler, riches en discussions possibles, et rappellent avec humour que si la France aime débattre de tout, elle prend sa table très au sérieux.

Reste à voir comment tout cela va s'organiser… et [c'est par ici que ça commence](part2-1.1-definition-forge.md).


## Qu’est-ce qu’une forge logicielle ?

Une **forge logicielle** est une plateforme collaborative en ligne qui permet à plusieurs développeurs de travailler ensemble sur un projet logiciel. Alors que **git** s’occupe uniquement de la gestion des versions en local et du partage entre dépôts distribués, la forge ajoute une surcouche de services qui facilitent l’organisation, la communication et l’automatisation autour d’un projet.

Concrètement, une forge logicielle propose :

* **Un hébergement de dépôts git**
  On peut y pousser ses dépôts locaux pour les rendre accessibles à d’autres personnes. C’est la base : la forge joue le rôle de serveur centralisé, même si git reste un outil distribué.

* **Des outils de collaboration**
  Comme les demandes de fusion (pull requests ou merge requests), les revues de code, les discussions intégrées et les systèmes de commentaires.

* **La gestion de projet**
  Tickets (*issues*), tableaux de tâches (*kanban*), planification de jalons (*milestones*) et documentation intégrée (wiki, README enrichis).

* **L’intégration et le déploiement continus (CI/CD)**
  La forge peut déclencher automatiquement des tests, des builds ou des déploiements à chaque nouveau commit.

* **Un système de gestion des utilisateurs et des permissions**
  Chaque projet peut définir qui a le droit de lire, d’écrire, de valider, ou d’administrer.

### Pourquoi utiliser une forge ?

Sans forge, un projet git peut être partagé à la main (par exemple en échangeant des archives `.zip` ou en donnant accès à un dépôt via SSH). Mais cela devient vite ingérable dès qu’il y a plusieurs contributeurs, ou que le projet prend de l’ampleur. La forge fournit :

* **Un point de rencontre centralisé** entre développeurs, mainteneurs, utilisateurs et testeurs.
* **Une traçabilité claire** des décisions techniques et des contributions.
* **Des workflows organisés** qui réduisent les erreurs (par exemple via les validations automatiques avant fusion).

### Exemples de forges

Les plus connues aujourd’hui sont :

* **GitHub** (la plus utilisée dans l’open source)
* **GitLab** (souvent choisi dans les entreprises et administrations pour son modèle auto-hébergeable)
* **Bitbucket** (lié à l’écosystème Atlassian)
* Des forges auto-hébergées comme **Gitea** ou **SourceHut**

Ces forges reposent toutes sur git, mais elles offrent chacune des particularités et des philosophies différentes. Dans la suite, nous nous attarderons principalement sur GitHub et GitLab, qui sont les plus répandues et couvrent la majorité des cas d’usage.



## Différences GitHub vs GitLab

Nous avons vu que GitHub et GitLab font partie des forges logicielles les plus utilisées aujourd’hui. Elles reposent toutes deux sur git, et proposent des fonctionnalités très proches : gestion de dépôts, suivi des tâches, revue de code, CI/CD, gestion des permissions…
Mais leur histoire et leur philosophie les distinguent, ce qui fait que certains projets choisiront plutôt l’un ou plutôt l’autre.

### GitHub : la référence de l’open source

* Créé en 2008, GitHub s’est imposé comme **la forge de référence** pour les projets open source.
* Sa force principale est **sa communauté** : la majorité des bibliothèques, frameworks et outils utilisés aujourd’hui dans le développement logiciel sont hébergés sur GitHub.
* Fonctionnalités marquantes :

  * Pull Requests (PR) pour proposer et discuter des modifications.
  * Pages GitHub pour publier facilement un site statique.
  * GitHub Actions pour mettre en place des workflows CI/CD intégrés.
* **Modèle d’utilisation :** principalement hébergé dans le cloud (github.com). L’auto-hébergement est possible mais rare, via GitHub Enterprise (payant).

### GitLab : la forge complète et auto-hébergeable

* Créé en 2011, GitLab s’est d’abord positionné comme une alternative libre et **auto-hébergeable** à GitHub.
* Sa particularité est d’intégrer dès le départ une chaîne complète de **DevOps** (gestion de projet, CI/CD, déploiement, monitoring).
* Fonctionnalités marquantes :

  * Merge Requests (MR) pour intégrer du code.
  * GitLab CI/CD avec pipelines configurables via un simple fichier `.gitlab-ci.yml`.
  * Gestion avancée des permissions et intégration avec des outils d’entreprise (LDAP, Active Directory, etc.).
* **Modèle d’utilisation :**

  * Version cloud (gitlab.com).
  * Version auto-hébergeable (GitLab CE, édition communautaire, open source).
  * Version entreprise (GitLab EE, avec des fonctionnalités avancées).

### En résumé

* **GitHub** est idéal si vous voulez publier vos projets et bénéficier d’une grande visibilité dans la communauté open source.
* **GitLab** est souvent privilégié en entreprise, lorsqu’on veut garder la maîtrise complète de l’infrastructure, avec un outillage intégré pour tout le cycle de développement.



## Modèles de collaboration (ouvert vs fermé)

Une forge logicielle n’est pas seulement un lieu où l’on héberge du code : c’est aussi un espace de **collaboration**. La manière dont on organise cette collaboration dépend beaucoup du type de projet et du public visé. On distingue principalement deux modèles :

* le **modèle ouvert**, typique des projets open source,
* le **modèle fermé**, plus courant dans les équipes privées ou en entreprise.

### Le modèle ouvert : la collaboration par *fork*

C’est le modèle privilégié par la communauté **open source**, notamment sur GitHub.
Le principe est simple :

1. Le projet est **public** : tout le monde peut consulter le code source.
2. Si quelqu’un souhaite proposer une amélioration (nouvelle fonctionnalité, correction de bug…), il ne modifie pas directement le dépôt officiel.
3. Il crée un **fork** (une copie complète du dépôt sur son propre compte).
4. Il travaille sur une branche dans son fork, puis propose une **Pull Request (GitHub)** ou une **Merge Request (GitLab)** pour soumettre ses changements.
5. Les mainteneurs du projet examinent la proposition, demandent éventuellement des corrections, et choisissent de l’intégrer ou non.

**Avantages :**

* Toute personne peut contribuer sans avoir besoin d’autorisations particulières.
* Encourage la diversité des contributions et la diffusion des idées.
* Sécurise le dépôt principal (les modifications ne passent que par la revue de code).

**Inconvénients :**

* Plus lent pour les contributeurs réguliers, car il faut passer par le processus fork → PR/MR à chaque fois.
* Peut créer de nombreux dépôts dérivés difficiles à suivre.


---

### Le modèle fermé : collaboration par gestion des permissions

Dans un contexte **privé** (projet interne à une entreprise, ou projet confidentiel), on adopte souvent un modèle fermé :

1. Le dépôt est **privé** : seules les personnes autorisées peuvent y accéder.
2. Les collaborateurs sont ajoutés directement au dépôt ou à un groupe, avec des **rôles** et **permissions** (ex. lecteur, contributeur, mainteneur, administrateur).
3. Les contributions se font généralement sur des **branches** internes au projet (par ex. `feature/login`, `bugfix/session`, etc.).
4. L’intégration se fait via des **Merge Requests / Pull Requests internes**, souvent avec une politique stricte de revue de code.

**Avantages :**

* Meilleur contrôle sur qui accède au code et qui peut modifier quoi.
* Processus plus rapide pour les membres de l’équipe (pas besoin de fork).
* Possibilité d’imposer des règles de qualité (revues obligatoires, tests automatiques, conventions de branches).

**Inconvénients :**

* Ne permet pas de contributions extérieures spontanées.
