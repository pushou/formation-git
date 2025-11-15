# Bases de l'intégration continue

Écrire des recettes, c’est bien. Bien les écrire, c’est encore mieux ! Le
concept d’intégration continue (_Continuous Integration_, ou en abrégé CI)
désigne l’automatisation de tâches de validation et de vérification. Cela
permet, par exemple, de s’assurer que le contenu d'une branche respecte
certaines normes de qualité avant qu'il ne soit fusionné dans la branche
principale.

Dans notre cas, nous allons mettre en place une intégration continue qui
vérifiera automatiquement l’orthographe, la grammaire et certaines règles
typographiques de vos recettes rédigées en Markdown, à l’aide de
[Grammalecte](https://grammalecte.net/).


## Tour d'horizon de GitHub Actions

L'intégration continue est un sujet complexe, riche en concepts et en jargon
spécifique à chaque forge. Nous vous proposons donc avant de commencer la
pratique un petit survol des concepts et du jargon de GitHub, dont nous allons
approfondir plusieurs points par la suite.

Le système d'intégration continue de GitHub s'appelle [GitHub
Actions](https://docs.github.com/fr/actions/get-started/understand-github-actions)
et il se configure avec un ensemble de fichiers YAML dans une hiérarchie de
répertoires `.github/workflows` que vous devez créer à la racine de votre
dépôt.

Chacun de ces fichiers YAML définit un
[_workflow_](https://docs.github.com/fr/actions/concepts/workflows-and-actions/workflows),
c'est à dire un ensemble de [travaux
(_jobs_)](https://docs.github.com/fr/actions/reference/workflows-and-actions/workflow-syntax#jobs)
qui s'exécutent automatiquement en réponse à un [événement déclencheur
(_trigger_)
](https://docs.github.com/fr/actions/using-workflows/triggering-a-workflow). Les
différents _jobs_ d'un _workflow_ sont par défaut autorisés à s'exécuter en
parallèle, mais on peut introduire des dépendances entre eux si besoin. Ils se
décomposent chacun en un certain nombre d'étapes (_steps_) qui s'exécutent quand
à elles de façon séquentielles. Ces étapes peuvent être de simples [commandes
_shell_](https://docs.github.com/fr/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idstepsrun)
ou utiliser des [briques logicielles plus
complexes](https://docs.github.com/fr/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idstepsuses)
appelées « actions ».[^custom-actions]

Lorsque l'événement déclencheur se produit, l'ensemble des travaux associés au
_workflow_ est exécuté (on parle de _run_). Chaque _job_ est alors traité par un
serveur[^runner-server] appelé exécuteur (_runner_), idéalement en parallèle
dans la limite des exécuteurs et des _jobs_ disponibles. Si l'on multiplie cette
charge de travail par un grand nombre de _jobs_, de _workflows_ et de projets,
vous devinez qu'une infrastructure d'intégration continue peut vite consommer
[beaucoup de ressources informatiques](https://arxiv.org/abs/2510.26413). Pour
cette raison, les forges diffèrent beaucoup les unes des autres au niveau de la
quantité et du type de ressources qu'elles choisissent de mettre gratuitement à
la disposition des projets _open source_, et c'est donc un critère à vérifier
quand vous choisissez l'hébergement d'un projet.

Dans le cas de GitHub, les projets _open source_ ont accès gratuitement à
[différents types d'exécuteurs prêts à
l'emploi](https://docs.github.com/fr/actions/reference/runners/github-hosted-runners#standard-github-hosted-runners-for-public-repositories)
permettant d'effectuer des travaux sous Windows, macOS et Linux avec des
processeurs x86 et Arm. Leur configuration matérielle est, prise
individuellement, plutôt modeste, mais chaque utilisateur GitHub a la
possibilité d'en utiliser [jusqu'à 20
simultanément](https://docs.github.com/en/actions/reference/limits#job-concurrency-limits-for-github-hosted-runners),
y compris au sein d'un seul de ses dépôts. En découpant bien ses _workflows_ en
_jobs_ parallèles, il est donc possible d'avoir accès à des ressources
informatiques déjà très importantes.

Toutefois, si ces ressources ne suffisent pas[^resource-hog] ou si on a des
besoins spécifiques (ex: GPU, données de test sensibles qui ne doivent pas
quitter votre réseau interne...), il est aussi possible de [configurer ses
propres
serveurs](https://docs.github.com/en/actions/how-tos/manage-runners/self-hosted-runners)
comme exécuteurs GitHub (_self-hosted runners_).

Dans la suite de cette formation, nous ne détaillerons pas davantage cette
notion d'exécuteur, et prendrons pour acquis que ceux qui sont fournis
gratuitement par GitHub sont suffisants, afin de pouvoir nous concentrer
davantage sur la définition des _workflows_.

[^custom-actions]: On peut définir soi-même des actions réutilisables à base de
                   commandes _shell_, programmes Javascript ou conteneurs
                   Docker, mais il existe aussi un grand nombre d'actions prêtes
                   à l'emploi fournies par GitHub et des tierces parties. Bien
                   sûr, comme chaque fois qu'on dépend du code d'un tiers, cette
                   décision devrait idéalement être prise en considérant tous
                   les aspects du compromis sous-jacent, pas seulement le
                   moindre effort au temps court mais aussi les risques
                   potentiels au temps long en termes de sécurité et de
                   maintenance.

[^resource-hog]: ...auquel cas il est toujours bon de prendre le temps de
                 vérifier que l'on utilise vraiment les ressources disponibles
                 efficacement, avec ce qu'il faut de [mise en
                 cache](https://github.com/actions/cache) des résultats
                 intermédiaires réutilisables entre différentes exécutions d'un
                 même _job_, une combinatoire qui reste sous contrôle au sein
                 des
                 [matrices](https://docs.github.com/fr/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idstrategymatrix)
                 éventuellement utilisées, etc.

[^runner-server]: Suivant la logique moderne du _cloud_, les exécuteurs sont
                  typiquement des machines virtuelles, ce qui permet d'héberger
                  un grand nombre d'exécuteurs dont la consommation de ressource
                  individuelle est fable sur une grosse machine hyperviseur
                  unique et d'adapter facilement l'infrastructure aux demandes
                  utilisateur variées en termes de versions de systèmes
                  d'exploitation.


## Préparation

Avant de commencer, assurez-vous que votre répertoire de travail est propre
(aucune modification en cours), que votre dépôt est à jour (synchronisé avec le
dépôt distant sur GitHub) et que vous êtes sur la branche `main`.

Créez ensuite une branche dédiée à la mise en place de l’intégration continue :

```bash
git checkout -b ci-grammalecte
```


## Créer le fichier de _workflow_

Comme nous n'avons encore défini aucun _workflow_, il faut d'abord créer
l'arborescence de répertoires `.github/workflows`, par exemple avec cette
commande à la racine de votre dépôt :

```bash
mkdir -p .github/workflows
```

Ceci fait, nous pouvons créer notre premier fichier _workflow_. Nous allons
commencer par un fichier vide que nous allons ensuite remplir étape par étape
afin de mieux expliquer sa structure :

```bash
touch .github/workflows/grammalecte.yml
```

### TODO: Nom de pipeline etc

TODO
