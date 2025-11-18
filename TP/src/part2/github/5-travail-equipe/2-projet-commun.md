# Un projet GitHub commun

Après avoir préparé votre propre carnet de recettes, il est temps de passer en
cuisine à plusieurs ! Dans cette partie, vous allez former des **équipes de 2 à
4 personnes** et travailler ensemble sur un **livre de recettes collaboratif**.


## Création de la brigade

Dans chaque groupe, désignez un chef de projet, que nous appellerons dans la
suite le **chef cuisinier**. C’est cette personne qui sera responsable de gérer
le dépôt commun.

Le chef cuisinier devra ensuite se signaler pour permettre aux formateurs de
vérifier l’équilibre des groupes. Puis, comme annoncé en introduction, il sera
chargé de transformer son dépôt personnel en dépôt collectif. Nous conseillons à
tous les autres membres de l'équipe de suivre ce que le chef cuisinier fait sur
son poste afin de se familiariser avec le processus.

Côté GitHub, aucune opération technique n’est nécessaire pour créer une équipe,
puisque nous partons sur un mode de collaboration ouvert par _fork_ où les
membres de l’équipe n'ont pas plus de permissions d’accès au dépôt que
d'éventuels contributeurs extérieurs.


## Du dépôt personnel au dépôt collectif

Sur le plan technique, tous les membres de l’équipe peuvent déjà en réalité
d'ors et déjà créer des _forks_ du dépôt du chef cuisinier et y soumettre des
_pull requests_, car GitHub l'autorise par défaut sur tous les dépôts
nouvellement créés et nous n'avons rien fait pour le désactiver.

Mais sur le plan humain, et un peu technique aussi, il y a quelques petits
obstacles aux contributions qui mériteraient d’être levés pour encourager ces
dernières. Quelques exemples :

- Le nom de dépôt initialement suggéré « mes-recettes » était tout à fait
  approprié pour un dépôt de recettes de cuisines personnel. Mais en tant que
  contributeurs extérieurs il est un perturbant de soumettre des contributions à
  un dépôt dont le nom est aussi possessif. Il serait donc préférable de
  basculer vers un **nom plus inclusif** comme « nos-recettes ».
- Lorsqu’un contributeur extérieur soumet une nouvelle recette de cuisine depuis
  son _fork_, l’**intégration continue** ne s’exécute actuellement pas sur les
  exécuteurs du dépôt officiel, uniquement sur ceux du _fork_ du contributeur.
  Cette configuration n'est pas idéale pour des raisons que nous verrons plus
  loin.
- Le travail à plusieurs soulève des questions de **droit d’auteur et licences
  d'utilisation**. Comme nous le verrons, c’est en fait déjà une question à se
  poser sur un dépôt personnel, elle devient juste plus pressante sur un dépôt
  collectif.
- Pour un contributeur extérieur, le fonctionnement du projet n’est documenté
  nulle part et est peu clair. Il serait donc souhaitable d’ajouter au moins une
  **explication rapide** de ce qu'on essaie de faire et comment autrui peut y
  contribuer.

Il est préférable de gérer les trois premiers points avant de commencer à
accepter à accepter de nouvelles contributions. Le quatrième peut être résolu
collectivement ultérieurement.

### Nom du dépôt

L’énoncé de TP vous a encouragé volontairement à partir sur un nom de dépôt qui
ne marche pas bien en collaboration, car c’est un problème classique en _open
source_.

Quand on commence un projet seul, on ne réfléchit pas toujours à fond à la façon
dont des noms qu’on choisit pour soi-même seront perçus par d’éventuels futurs
collaborateurs. Il est donc facile de se retrouver avec des noms qui seront
problématiques en collaboration plus tard car ils sont...

- Trop possessifs (ex : `mondepot`,
  [`godbolt`](https://www.youtube.com/watch?v=kvMqdLf4URI))
- Impossibles à chercher (ex : [`R`](https://www.r-project.org/),
  [`n`](https://www.npmjs.com/package/n))
- Trop génériques et/ou déjà pris (ex :
  [`code`](https://code.visualstudio.com/),
  [`opensycl`](https://github.com/AdaptiveCpp/AdaptiveCpp/tree/9f842c701a599107cc6d117d3539f971036363a1?tab=readme-ov-file#adaptivecpp-formerly-known-as-hipsycl--open-sycl))
- Offensants et/ou ridicules (ex : `ducon`,
  [`etron`](https://fr.wikipedia.org/wiki/Audi_e-tron))

Changer de nom n'est pas simple, car un nom est un identifiant à la fois social
(discussions avec les collègues, moteurs de recherches…) et technique (URLs,
noms de paquets logiciels…). Mais quand on s’y prend suffisamment tôt, c’est une
migration qui reste faisable. Il est donc conseillé de prendre le temps de
passer en revue ses choix de noms avant de commencer à faire de la publicité
pour ses projets et de les ouvrir aux contributions du plus grand nombre.

A ce stade, pour passer du nom possessif `mes-recettes` au nom plus inclusif
`nos-recettes`, il vous suffit de faire 3 choses :

- Vous rendre dans l’onglet « Settings » de l’interface du dépôt, écrire un
  nouveau nom dans la case « Repository name », et cliquer sur « Rename ».
- Récupérer les nouvelles addresses SSH et/ou HTTPS du dépôt et reconfigurer
  tous vos dépôts git locaux pour utiliser ces nouvelles adresses avec `git
  remote set-url`.
- Prendre l’habitude de naviguer vers la nouvelle adresse du dépôt avec votre
  navigateur web, en changeant vos marque-pages éventuels.

Nous vous conseillons donc de le faire maintenant plutôt que d'attendre le
moment où vous aurez plusieurs contributeurs/utilisateurs auxquels vous devrez
dire de changer le nom qu’ils utilisent via des moyens de communication parfois
inexistants !

### Intégration continue des _pull requests_

Actuellement, notre _workflow_ de vérification grammaticale et orthographique
est configuré pour s'exécuter à chaque _push_ avec le déclencheur `on: push`.
Cette configuration étant héritée par les _forks_, un contributeur qui commence
à travailler sur un _fork_ bénéficiera également de retours automatiques de
l’intégration continue à chaque _push_ sur ce _fork_.

En revanche, le _workflow_ n’est actuellement pas configuré pour s’exécuter sur
le dépôt original lorsqu’une _pull request_ est soumise à ce dernier depuis un
_fork_. Ce mode de déclencheur est intéressant pour différentes raisons :

- Quand on veut éviter à tout pris des commits incorrects sur `main` (par
  exemple quand le site web du projet est directement publié à partir de
  `main`), il est plus facile de faire confiance à un résultat d’intégration
  continue provenant des exécuteurs officiels du projet que s’il vient
  d’exécuteurs inconnus sous le contrôle du contributeur.
- Si à un moment le projet évolue et a besoin d’exécuteurs spéciaux (par exemple
  avec des GPUs pour faire du _machine learning_), ce sera plus simple pour les
  contributeurs extérieurs d'avoir un accès contrôlé à ces ressources que de
  devoir les répliquer à l’identique de leur côté.
- Et surtout, de façon plus terre à terre, l’interface de _pull request_ de
  GitHub est pensée pour cette configuration et son ergonomie est nettement
  moins bonne quand on en sort. Par exemple on ne peut plus voir facilement les
  résultats d’intégration continue à côté des discussions autour de la _pull
  request_, ni configurer une _pull request_ pour être fusionnée automatiquement
  lorsque l’intégration continue réussit.

Pour autoriser l'exécution des _workflows_ sur une _pull request_, il faut faire
deux choses:

- Ajouter le déclencheur
  [`pull_request`](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#pull_request)
  à la configuration YAML du _workflow_. La liste des déclencheurs deviendra
  donc `on: [push, pull_request]`. Une fois ce changement intégré à la branche
  `main` du dépôt, toutes les _pull requests_ en bénéficieront automatiquement.
- Approuver manuellement l’exécution du _workflow_ pour les premières _pull
  requests_ de chaque contributeur. Cette mesure de sécurité vise à empêcher des
  inconnus malveillants de bloquer votre intégration continue en créant un grand
  nombre de _pull requests_.[^runner-security]

[^runner-security]: Les plus expérimentés d’entre vous auront remarqué que ce
                    n’est pas le seul risque de sécurité pour les exécuteurs, et
                    que si vous déployez vos propres exécuteurs vous devez être
                    très prudent. Un exécuteur, c’est avant tout une machine
                    virtuelle ou physique sur laquelle on laisse des inconnus
                    exécuter du code à peu près arbitraire, donc sa
                    configuration de _sandboxing_ doit être ajustée avec le plus
                    grand soin.

### Droit d'auteur et licences

TODO: ...on le tourne en discussion collective de l'équipe, et après on met le
      README.md et le CONTRIBUTING.md en exo collectif. Enfin on racroche les
      wagons avec la version gitlab en basculant sur la protection de branche
      principale, à faire après quelques PRs histoire que la liste des jobs soit
      initialisée pour la fonctionnalité mandatory check.