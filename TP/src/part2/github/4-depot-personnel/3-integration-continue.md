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

### Nom du _workflow_

Par défaut, l'interface web de GitHub désigne les _workflows_ par le chemin vers
le fichier dans lequel ils sont définis. Ce n'est pas toujours très clair, et on
n'a pas forcément envie d'utiliser un nom de fichier très long pour clarifier,
donc la coutume est plutôt d'utiliser l'option [`name`] pour donner au
_workflow_ un nom plus explicite.

Pour cela, ouvrez le fichier `.github/workflows/grammalecte.yml` avec votre
éditeur de texte préféré et ajoutez-y le texte suivant :

```yaml
name: "Vérification grammaire/orthographe"
```

### Événement déclencheur (_trigger_)

Après avoir donné un nom à notre _workflow_, nous allons ensuite vouloir définir
dans quel cas il va s'exécuter. On utilise pour cela l'option
[`on`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#on).

Il est possible de programmer l'exécution d'un _workflow_ en réponse à [de
nombreux événements
déclencheurs](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows).
Nous allons pour commencer déclencher le _workflow_ quand de nouveaux commits
sont ajoutés au dépôt, ce qui correspond à l'événement
[`push`](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#push) :

```yaml
# ... après le nom de workflow ...

on: push
```

### Définir le _job_ d'analyse

Notre premier _workflow_ ne contiendra qu'un seul _job_
`grammaire_et_orthographe` chargé d'analyser le contenu des recettes.

Ce _job_ nécessite un environnement Python afin d’exécuter Grammalecte. Pour
simplifier la gestion d’environnements parfois hétérogènes (chaque _job_ ayant
ses propres dépendances), GitHub Actions permet d’utiliser des [images
Docker](https://hub.docker.com/). Celles-ci offrent des environnements
préconfigurés couvrant un large éventail de besoins.

Ici, nous utiliserons l’image officielle `python:3.12`, qui contient la dernière
version de Python 3.12 :

```yaml
# ... après l'événement déclencheur ...

jobs:
  grammaire_et_orthographe:
    runs-on: ubuntu-latest
    container: python:3.12
    # ... d'autres instructions viendront ici plus tard ...
```

Après avoir utilisé le mot-clé
[jobs](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobs)
pour indiquer que nous allons définir les travaux exécutés par ce _workflow_,
nous déclarons notre premier _job_ en lui donnant le nom
`grammaire_et_orthographe`. Puis nous demandons qu'il soit exécuté par un
_runner_ sous Linux[^linux-runner], car c'est le seul système d'exploitation qui
supporte nativement[^native-docker] l'utilisation de conteneurs Docker. Et enfin
nous demandons que ce _runner_ travaille avec l'image Docker `python:3.12`.

Notez qu'en YAML comme en Python, l'indentation est significative: elle sert à
indiquer que `grammaire_et_orthographe` est un _job_ (car il est plus indenté
que `jobs:`), puis à indiquer que `runs_on` et `container` sont des propriétés
de ce _job_ précis.

[^linux-runner]: ...plus précisément sous la dernière version
                 d'[Ubuntu](https://ubuntu.com/), car 1/Ubuntu est la seule
                 distribution Linux disponible sur les _runners_ par défaut de
                 GitHub et 2/la version d'Ubuntu utilisée importe peu quand on
                 travaille avec des images Docker, donc autant utiliser une
                 version `latest` qui va évoluer automatiquement au fil du
                 temps, ce qui nous fera un numéro de version de moins à
                 maintenir à jour manuellement à l'avenir.

[^native-docker]: Les versions de Docker pour Windows et macOS utilisent une
                  machine virtuelle Linux sous le capot.

### Installer Grammalecte

Nous devons ensuite expliquer à GitHub comment installer Grammalecte dans
l’environnement Python fourni par l’image Docker. Nous utiliserons `pip`, le
gestionnaire de paquets Python, pour installer une surcouche de Grammalecte
nommée  [`grammalint`](https://gitlab.in2p3.fr/sonny.lion/grammalint).

La commande d’installation est la suivante :

```bash
python -m pip install git+https://gitlab.in2p3.fr/sonny.lion/grammalint.git
```

Pour l'exécuter, il suffit d'ajouter une étape à notre _job_ :

```yaml
jobs:
  grammaire_et_orthographe:
    # ... options globales du job ...
    steps:
      - name: Installation de grammalint
        run: python -m pip install git+https://gitlab.in2p3.fr/sonny.lion/grammalint.git
      # ... d'autres instructions viendront ici plus tard ...
```

Avec le mot-clé
[`steps`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idsteps),
nous indiquons que nous commençons la liste des étapes du _job_. Puis nous
créons une première étape (notez le tiret), nous donnons un nom à cet étape
(optionnel mais recommandé) avec l'option
[`name`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idstepsname),[^name-aliasing]
et enfin nous indiquons que cette étape du _job_ consiste à exécuter une
commande _shell_ avec l'option
[`run`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idstepsrun).

[^name-aliasing]: Notez qu'une même option peut avoir un effet différent selon
                  sa profondeur d'indentation, encore une fois l'indentation est
                  très importante en YAML.

### Extraire les fichiers du dépôt

Dans GitHub Actions, l'extraction des fichiers du dépôt est une étape dédiée au
sein d'un _job_, ce qui représente un léger gain en termes de flexibilité par
rapport à la plupart des autres systèmes d'intégration continue où cette
opération est implicite :

- Le travail associé à l'extraction des fichiers n'est pas effectué quand il
  n'est pas utile, par exemple si le _job_ échoue dès les étapes préparatoires
  (comme l'installation de `grammalint` ici). Ou, sur des _workflows_ plus
  complexes, si un _job_ ne dépend que des sorties des _jobs_ précédents (ex :
  binaires précompilés) et pas des fichiers source contenus dans le dépôt.
- Puisque l'opération d'extraction est explicite, il est possible de la
  configurer pour lui demander d'extraire un commit de son choix. C'est
  intéressant quand on utilise des déclencheurs autres que `push` où la notion
  de dernier commit n'a pas forcément de sens.

Ici, nous voulons travailler avec les derniers commits qui ont été poussés, donc
il nous suffit d'exécuter l'action `checkout` avec ses paramètres par défaut :

```yaml
jobs:
  grammaire_et_orthographe:
    # ... options globales du job ...
    steps:
      # ... installation de grammalint ...
      - name: Extraction des fichiers
        uses: actions/checkout@v5
      # ... d'autres instructions viendront ici plus tard ...
```

Notez l'utilisation du mot-clé
[`uses`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idstepsuses).
Celui-ci nous indique que `checkout` n'est pas une commande _shell_ normale,
mais une action, c'est à dire un programme réutilisable de complexité
arbitraire. Ce programme est distribué par GitHub, et vous trouverez sa
documentation (par exemple les options qu'il accepte en paramètre) dans [le
dépôt de code source associé](https://github.com/actions/checkout/).

GitHub n'ont pas le monopole de la création d'actions, et vous pouvez aussi
[utiliser des actions créées par d'autres
personnes](https://github.com/marketplace?type=actions) ou [créer vos propres
actions](https://docs.github.com/en/actions/how-tos/create-and-publish-actions),
ce qui est utile quand vos fichiers de _workflows_ commencent à devenir
répétitifs. Mais cela dépasse le cadre de cette formation.

### Effectuer l’analyse des fichiers

Une fois `grammalint` installé et le commit actif extrait, il faut indiquer à
GitHub comment lancer l’analyse des fichiers Markdown. Pour vérifier un fichier
spécifique, on utilise la commande suivante :

```bash
python -m grammalint -i recettes/crepes-classiques.md
```

Pour analyser tous les fichiers Markdown du dossier `recettes/` (y compris ceux
des sous-dossiers), on utilise la commande suivante :

```bash
python -m grammalint -i recettes/**/*.md
```

En intégrant cette seconde commande à notre _job_ sous forme d'étape
supplémentaire, le fichier de _workflow_ complet devient :

```yml
name: "Vérification grammaire/orthographe"

on: push

jobs:
  grammaire_et_orthographe:
    runs-on: ubuntu-latest
    container: python:3.12
    steps:
      - name: Installation de grammalint
        run: python -m pip install git+https://gitlab.in2p3.fr/sonny.lion/grammalint.git
      - name: Extraction des fichiers
        uses: actions/checkout@v5
      - name: Vérification de la grammaire/orthographe
        run: python -m grammalint -i recettes/**/*.md
```


## Mettre à l’épreuve le _workflow_

Une fois votre _workflow_ prêt, il est temps de vérifier que tout fonctionne.

Pour cela, versionnez le fichier et poussez-le (_push_) sur le dépôt distant.
Rendez-vous ensuite dans l’interface web de GitHub, onglet **Actions**, pour
observer le _workflow_ en action. Vous devriez voir une page similaire à
celle-ci :

![Interface GitHub - Actions](../../../images/github-actions-tab.png)

Dans la table de droite, chaque ligne correspond à l'exécution d'un _workflow_
et se structure de la façon suivante :

- D'abord un petit pictogramme qui indique si l'exécution a réussi ou échoué.
  Ici, nous avons une croix rouge qui signale un échec. En cas de réussite ce
  serait une coche verte.
- Ensuite un titre qui est par défaut tiré du message de commit. Vous pouvez
  le personnaliser avec l'option de _workflow_
  [`run-name`](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#run-name).
- Sous le titre, des infos plus détaillées concernant le _workflow_ qui s'est
  exécuté, le nombre de fois que ce _workflow_ s'est exécuté précédemment,
  l'identifiant du commit qui a déclenché le _workflow_, et le nom d'utilisateur
  de la personne qui a poussé ce commit.
- A droite, en bleu, le nom de la branche au sein duquel le commit a été poussé.
- Et enfin, des statistiques concernant le moment auquel le _workflow_ s'est
  exécuté et la durée pendant laquelle il s'est exécuté.

Si le _workflow_ ne s’exécute pas, vérifiez que...

- le fichier de _workflow_ possède bien l'extension `.yml` ou `.yaml` ;
- il est placé à la position `.github/workflows/xyz.yml` par rapport à la racine
  du dépôt ;
- il a bien été inclus dans un commit qui a ensuite été poussé sur GitHub.


## TODO: Consulter les journaux du _workflow_

TODO
