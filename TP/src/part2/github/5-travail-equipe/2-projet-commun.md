# Un projet GitHub commun

Après avoir préparé votre propre livre de cuisine, il est temps de passer en
cuisine à plusieurs ! Dans cette partie, vous allez former des **équipes de 2 à
4 personnes** et travailler ensemble sur un **livre de cuisine collaboratif**.


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

Sur le plan technique, tous les membres de l’équipe peuvent d'ores et déjà créer
des _forks_ du dépôt du chef cuisinier et y soumettre des _pull requests_, car
GitHub l'autorise par défaut sur tous les dépôts nouvellement créés et nous
n'avons rien fait pour le désactiver.

Mais sur le plan humain, et un peu technique aussi, il y a quelques petits
obstacles aux contributions qui mériteraient d’être levés pour encourager ces
dernières. Quelques exemples :

- Le nom de dépôt initialement suggéré « mes-recettes » était tout à fait
  approprié pour un dépôt de recettes de cuisines personnel. Mais en tant que
  contributeurs extérieurs il est un peu perturbant de soumettre des contributions à
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
accepter de nouvelles contributions. Le quatrième peut être résolu
collectivement ultérieurement.

### Nom du dépôt

L’énoncé de TP vous a encouragé volontairement à partir sur un nom de dépôt qui
ne marche pas bien en collaboration, car c’est un problème classique en _open
source_.

Quand on commence un projet seul, on ne réfléchit pas toujours à fond à la façon
dont des noms qu’on choisit pour soi-même seront perçus par d’éventuels futurs
collaborateurs. Il est donc facile de se retrouver avec des noms qui seront
problématiques en collaboration plus tard car ils sont...

- Trop possessifs (ex : `mon-depot`,
  [`godbolt`](https://www.youtube.com/watch?v=kvMqdLf4URI))
- Hostiles aux moteurs de recherche (ex :
  [`C#`](https://en.wikipedia.org/wiki/C_Sharp_(programming_language)),
  [`R`](https://www.r-project.org/), [`n`](https://www.npmjs.com/package/n))
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
pour ses projets et de les ouvrir au plus grand nombre.

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

Légalement parlant, la plupart des documents écrits sont sous le même régime de
droit d’auteur. Du point de vue de la loi, il n’y a pas une grande différence
entre un roman, une page web, un fichier de configuration et le code source d'un
logiciel : tout texte suffisamment original est légalement considéré comme la
propriété intellectuelle de son auteur.

Le cadre légal de la propriété intellectuelle est un sujet très complexe, et
même en se focalisant sur le cas des logiciels en droit français, il y a de quoi
remplir [un beau pavé de >600
pages](https://www.lgdj.fr/droit-des-logiciels-9782130626152.html). On ne va
donc certainement pas fournir une explication exhaustive du sujet dans ce cours.
Mais on peut poser les bases suivantes :

- Le droit d’auteur protège les oeuvres sur un temps très long par rapport aux
  échelles de temps de l’informatique, puisqu’il dure [70 ans après la mort de
  l’auteur en Union
  Européenne](https://en.wikipedia.org/wiki/Copyright_Duration_Directive).
- En France, on divise traditionnellement le droit d’auteur en deux parties :
  - Les droits « moraux » sont des droits dont l’auteur dispose pour toute la
    durée de protection et auquel il ne peut pas renoncer. Il s'agit par exemple
    du droit de citation.
  - Les droit « patrimoniaux » peuvent être cédés à autrui via un contrat de
    licence, traditionnellement rédigé contre rémunération. Il s'agit par
    exemple du droit de distribuer des copies d'une œuvre.
- En l’absence de licence explicite de la part du détenteur des droits, il est
  illégal pour quelqu’un qui a accès à une oeuvre d’en redistribuer des copies
  ou des oeuvres dérivées. Cette notion d’œuvre dérivée est large et couvre par
  exemple les versions modifiées d’un texte où des passages de l’original sont
  encore reconnaissables (ce qui inclut les commits dans un dépôt git) et les
  traductions dans une autre langue (ce qui inclut les binaires issus de la
  compilation d’un logiciel). Même les programmes qui se lient dynamiquement à
  une bibliothèque sont concernés par les droits patrimoniaux de cette dernière
  car ils contiennent des petits fragments de son code (noms de fonctions,
  définitions de types, code _inline_…).
  - On le voit, la création d’un _forks_ et la publication de commits basés sur
    le dépôt d’autrui est illégale en l’absence de licence explicite permettant
    l'utilisation du texte du dépôt original ! Il est donc impossible de
    collaborer légalement sur un projet _open source_ en utilisant un
    gestionnaire de version comme git sans avoir préalablement mis le projet
    commun sous une licence adéquate sur laquelle l’ensemble des co-auteurs
    s’accordent.
- Traditionnellement, les licences ont pour objectif d’autoriser la copie de
  façon restreinte et moyennant finance afin de monétiser l’accès à une oeuvre.
  Les licences _open source_ détournent cette logique en utilisant le droit
  d’auteur pour encourager au contraire l’accès libre à l’oeuvre (sous sa forme
  originale, donc le code source pour un logiciel) par le plus grand nombre. Il
  existe de [très nombreuses licences _open
  source_](https://choosealicense.com/appendix/) que l'on distingue les une des
  autres par…
  - Le type d’œuvre auxquelles la license est destinée à s'appliquer. La plupart
    des licences _open source_ ont été conçues pour s’appliquer à des logiciels,
    mais certaines comme la famille [Creative
    Commons](https://creativecommons.org/) sont adaptées à des travaux de nature
    moins informatique comme des oeuvres d’art.
  - La volonté ou non d’assurer que le travail qui a été partagé gratuitement ne
    soit pas exploité derrière par des entités commerciales peu scrupuleuses qui
    veulent profiter au maximum du travail de la communauté en lui rendant le
    minimum en retour. On lutte contre ce parasitisme en utilisant des licences
    dites « _copyleft_ » qui imposent que les oeuvres dérivées soient
    redistribuées sous une licence similaire à celle de l’oeuvre originale, la
    plus connue étant sans doute la [license
    GPL](https://fr.wikipedia.org/wiki/Licence_publique_g%C3%A9n%C3%A9rale_GNU).
  - Plus généralement, la volonté de prévenir différents types d’abus qui
    respectent à la lettre le texte de licences plus simples mais n’en
    respectent aucunement l’esprit. Mentionnons comme exemples d’abus que
    certaines licences tentent d’éviter...
    - L’utilisation des brevets logiciels (dans les pays où ils sont facilement
      accordés) pour tenter d’empêcher la réimplémentation _open source_ de
      logiciels propriétaires.
    - La mise à disposition de logiciels uniquement via une API réseau pour
      contourner l'obligation de redistribution des sources des licences
      _copyleft_.
    - La mise à disposition d’un code source dont les versions modifiées ne sont
      pas utilisables car l’appareil sur lequel le logiciel est destiné à être
      installé rejette l’installation de versions modifiées du logiciel
      (_tivoization_).
  - De leur côté, on le devine, les parasites de l’_open source_ usent de toute
    leur influence médiatique pour encourager au contraire l’utilisation de
    licences les moins protectrices possibles pour les œuvres et logiciels, afin
    de préserver au maximum leur liberté de piller le travail bénévole sans rien
    avoir à contribuer en retour. On trouve à cet autre extrême du spectre des
    licences comme [BSD](https://fr.wikipedia.org/wiki/Licence_BSD),
    [MIT](https://fr.wikipedia.org/wiki/Licence_MIT) et
    [Apache](https://fr.wikipedia.org/wiki/Licence_Apache).

Pour conclure ce petit point de droit, il faut aussi mentionner que globalement
parlant, les salariés ne sont pas titulaires des droits patrimoniaux des œuvres
qu’ils produisent sur leur temps de travail, qui appartiennent à leur employeur.
Choisir soi-même une licence pour un texte qu’on a écrit sur son temps de
travail puis le publier soi-même est donc illégal, et on devrait à la place
toujours passer pour ça par une discussion avec le service valorisation de son
employeur. Mais hélas, l'incompétence généralisée desdits services concernant
l’_open source_ nous conduit trop souvent à devoir « oublier » cet aspect légal
important du droit d’auteur…

C’est donc ce que nous allons faire ici pour le livre de cuisine commun, en vous
encourageant à choisir vous-même une des licences [Creative
Commons](https://creativecommons.org/share-your-work/cclicenses/) pour celui ci,
qui sont les mieux adaptées pour un document textuel comme ce livre de cuisine.
Comprenez-vous les différentes variantes proposées et leurs implication ?
Laquelle vous semble la plus pertinente ? A votre brigade de cuisiniers de
prendre le temps d’en débattre puis d’en décider collectivement !

Quand vous aurez choisi, prenez le texte de la licence et sauvegardez-le dans un
fichier `LICENSE` (ou `LICENSE.md` si le texte de la license est disponible avec
formatage Markdown). Ce fichier sera, suivant une convention bien établie, placé
à la racine du dépôt et intégré à `main`.

### Documentation pour contributeurs

A ce stade, votre dépôt est prêt pour des contributions internes, et vous pouvez
d’ores et déjà recommencer à pratiquer les exercices de la section [« Contribuer
à un dépôt »](../3-contribution.md) pour vous remettre en tête le processus de
base de soumission d'une _pull request_ et pratiquer un peu le côté mainteneur /
chef cuisinier du processus.

Nous verrons plus loin dans ce chapitre comment fluidifier ce processus pour
éviter, par exemple, que plusieurs personnes ne perdent du temps à travailler
sur la même recette sans le savoir. Mais en attendant, je vous propose comme
exercice collectif d’améliorer l’accessibilité du dépôt pour les contributeurs
extérieurs afin d’augmenter vos chances d’attirer ce type de contribution.

Comme vu précédemment, la convention pour indiquer la licence sous laquelle le
contenu d’un dépôt git est diffusé est de placer un fichier `LICENSE` ou
`LICENSE.md` à la racine du dépôt. Il existe d’autres conventions de ce type que
l'on retrouve dans de nombreux projets _open source_, et que vous gagneriez à
respecter dans vos dépôts :

- Il est très courant de placer un fichier `README` ou `README.md` à la racine
  du dépôt pour faire une présentation basique du projet orientée vers les
  contributeurs potentiels : comment il s’appelle, son objectif, des
  instructions d’installation et un mini tutoriel d'utilisation si c’est un
  logiciel, des instructions pour le rendu HTML si c’est un site web, une
  référence pour les citations si il existe des publications sur le projet… Cela
  ne remplace pas une documentation plus complète pour les gros projets, mais
  rend déjà le projet plus accueillant en aidant beaucoup les nouveaux venus à
  mettre le pied à l'étrier.
- On utilise souvent un autre fichier `CONTRIBUTING.md` pour fixer la politique
  de contribution du projet : quel type de contributions sont recherchées
  activement par le projet, le processus de contribution recommandé (ex :
  prévenir avant un gros développement via une _issue_ pour pouvoir raffiner la
  conception avec les mainteneurs et autres contributeurs, découper les gros
  développements en petites _pull requests_ pour faciliter la revue). Un autre
  élément classique de ce fichier est de rappeler les règles de vie de la
  communauté autour du projet que tout contributeur devrait respecter sous peine
  de banissement (_code of conduct_). En France il s’agit souvent avant tout
  d’un rappel à la loi, mais l’expérience montre que ce type de rappel est
  malheureusement souvent nécessaire sur Internet…
- Une autre convention un peu moins répandue mais partagée par plusieurs projets
  académiques est d’ajouter un fichier `AUTHORS.md` qui donne des informations
  complémentaires sur les auteurs par rapport à ce qui est présent dans les
  métadonnées de commits git : affiliation académique, ORCID… Attention
  toutefois avec les informations de contact comme les adresses mail, car les
  _spammeurs_ adorent fouiller le contenu des dépôts git public de façon
  automatisée pour y trouver de nouvelles personnes à harceler.[^commit-mail]

Prenez le temps d'aller collectivement visiter le dépôt de code source de
quelques gros projets _open source_ que vous appréciez, et examinez les fichiers
texte à la racine du dépôt dont le nom est en majuscule : il s’agit généralement
d’une documentation pour contributeur de ce style. Notez les ressemblances et
les différences entre les fichiers fournis par ces projets et leur contenu, puis
décidez quels fichiers vous souhaitez ajouter à votre dépôt de recette et quels
contenus vous souhaitez mettre dedans. Enfin, répartissez-vous les tâches de
rédaction associées.

[^commit-mail]: Ce problème de spam explique aussi pourquoi de plus en plus de
                forges anonymisent les adresses mail des commits git que l’on y
                pousse par défaut, ou proposent de le faire en option. La
                conception de git a hélas mal vieilli sur ce point.


## Protéger la branche principale

<div class="warning">

Les actions qui suivent ne peuvent être effectuée que par le chef cuisinier. Les
autres membres de la brigade peuvent les observer aussi, ou bien commencer à
creuser les instructions suivantes pour être parés pour les contributions
futures.

</div>

Dans la méthode de travail classique utilisée par cette formation, la branche
`main` du dépôt a un statut spécial d'historique officiel du projet. Par
exemple...

- Quand on visualise le dếpôt dans l'interface web, on voit d'abord cette
  branche.
- Le site web officiel du projet est typiquement généré à partir de cette
  branche.
- Pour les projets logiciels, les versions que l'on publie sous forme de paquets
  (ex: v2.0.0) dérivent souvent de commits _taggés_ sur cette branche.
- Les contributions extérieures dérivent de cette branche et sont fusionnées en
  son sein.

Tout ceci fait qu'on souhaite souvent s'imposer et imposer aux autres une
certaine prudence dans la manipulation de cette branche. Par exemple…

- On peut souhaiter qu’aucun changement ne soit mis en ligne sur `main` par
  _push_ direct, et que tout changement passe par une _pull request_. Cela
  assure que les changements des contributeurs internes et externes sont traités
  de façon uniforme (ce qui facilite par exemple la création d'un _change log_),
  et ouvre ainsi la porte au point suivant.
- On peut souhaiter qu’aucun changement ne soit fusionné au sein de `main` avant
  que l’intégration continue n’aie réussi sur une version de la branche qui est
  à jour par rapport à `main`. Cela assure que l’on ne fusionnera pas au sein de
  `main` des changements qui risquent de casser l’intégration continue.

Dans le vocabulaire de GitHub, les _rulesets_ sont la façon moderne d’obtenir ce
genre de garantie. Pour en configurer un pour la branche `main`, procédez de la
façon suivante :

- Rendez-vous dans les réglages du dépôt (onglet _Settings_), puis dans la
  section « Rules → Rulesets » du panneau latéral, puis cliquez sur le bouton
  « New ruleset » et sélectionnez l’option « New branch ruleset » dans le menu
  qui s'ouvre.
- Dans le champ « Ruleset Name » du formulaire qui s’ouvre, donnez au _ruleset_
  le nom que vous voulez.
- En-dessous, assurez-vous que le **Enforcement status** soit réglé sur
  **Active** pour que les règles suivantes soient bien mises en application.
- Dans la section « Target branches », cliques sur le bouton « Add target » et
  choisissez l’option « Include default branch » dans le menu qui s'ouvre.
- Dans la section « Branch rules », activez les options suivantes :
  - **Restrict deletions** permet de garantir que la branche principale ne sera
    pas supprimée par accident (plus précisément qu’un _push_ qui tente de la
    supprimer sera rejeté).
  - **Require a pull request before merging** permet d'interdire le _push_
    direct sur `main`. N’hésitez pas à faire un tour de la section cachée « Show
    additional settings » pour voir comment il est possible au-delà d’exiger un
    certain type de traitement des _pull requests_.
  - **Require status checks to pass** permet d’exiger que certaines tâches
    d’intégration continue réussissent avant qu’une _pull request_ ne puisse
    être fusionnée. Pour bien fonctionner, cette option doit être configurée
    davantage en effectuant les réglages suivantes dans la section cachée « Show
    additional settings » :
    - Cochez la case **Require branches to be up to date before merging** pour
      assurer que les tests aient vraiment été lancés sur la fusion de `main` et
      de la branche proposée, et pas sur une ancienne version de la branche
      proposée qui n'est pas forcément à jour par rapport à `main`.
    - Cliquez sur le bouton « Add checks » et trouvez la tâche
      `grammaire_et_orthographe` avec la barre de recherche afin d’ajouter la
      vérification de grammaire/orthographe à la liste des tâches d’intégration
      continue qui doivent réussir avant qu'une _pull request_ ne soit
      fusionnée.
  - **Block force pushes** permet d'assurer qu’aucun _force push_ ne sera
    effectué sur la branche concernée. Il est fortement recommandé de le faire
    au moins pour la branche `main`, car c’est une branche sur laquel tous les
    contributeurs basent leur travail et un _force push_ dessus peut donc avoir
    des conséquences très graves.

Enfin, cliquez sur **Create** et effectuez les formalités de vérification
d’identité éventuellement demandées par GitHub pour confirmer l'opération.
N’hésitez pas à faire en passant un tour rapide des autres options pour voir ce
que les _rulesets_ offrent comme autres possibilités, et à solliciter les
formateurs si il y a des options que vous ne comprenez pas.

Pendant que vous êtes dans les réglages du dépôt, faites aussi un tour dans la
partie « General » en haut du menu à gauche, défilez jusqu'à la section « Pull
Requests », et prenez connaissance des options disponibles à cet endroit.
Plusieurs vous intéresseront potentiellement. Ici aussi, n'hésitez pas à
solliciter les formateurs si il y a des choses que vous ne comprenez pas dans
les options proposées.

Après avoir activé ces règles, essayez maintenant de modifier le fichier de
recette `recettes/crepes-classiques.md` en local, de faire un commit, puis de
pousser directement sur `main`. Si la protection est bien en place, GitHub
devrait refuser le _push_ avec un message d'erreur de ce style :

```text
remote: error: GH013: Repository rule violations found for refs/heads/main.
remote: Review all repository rules at https://github.com/ManuMacaron/livre-cuisine/rules?ref=refs%2Fheads%2Fmain
remote: 
remote: - Changes must be made through a pull request.
remote: 
remote: - Required status check "grammaire_et_orthographe" is expected.
remote: 
To github-manu-macaron:ManuMacaron/livre-cuisine.git
 ! [remote rejected] main -> main (push declined due to repository rule violations)
erreur : impossible de pousser des références vers 'github-manu-macaron:ManuMacaron/livre-cuisine.git'
```

Il ne vous reste alors qu'à créer une branche pour pouvoir intégrer vos
modifications via une _pull request_. N'hésitez pas à relire la [section
précédente](../3-contribution.md) si besoin.

Une fois la branche et la _pull request_ créées, vous pourrez fusionner vos
modifications dans `main` via l'interface web de GitHub. Pour cela rendez-vous
dans l'onglet « Pull requests », sélectionnez votre _pull request_, puis cliquez
sur le bouton « Merge pull request » et confirmez la fusion après édition
éventuelle du message de commit associé au commit de fusion.

Vous pourrez alors retourner voir le contenu et le graphique des commits de
votre dépôt pour vérifier que vos modifications ont bien été intégrées dans
`main`.


## Organiser le travail avec les tickets (_issues_)

Avant de plonger vous plonger dans la rédaction des recettes, il est utile de
planifier et organiser les tâches à accomplir, sinon on se retrouve vite avec
trois recettes de gâteau au chocolat et zéro recettes de risotto.

GitHub propose pour cela un outil simple et efficace : les **tickets**
(_issues_). Les **tickets** vous permetteront par exemple de…

* proposer une **nouvelle recette** (« Créer la recette du fondant au
  chocolat »),
* proposer une **correction** (« Erreur sur les proportions du gâteau au
  yaourt »),
* ou encore suggérer une **amélioration** (« Ajouter une photo à la recette des
  crêpes »).

Un **ticket** peut aussi être découpé en plusieurs sous-tâches pour mieux
répartir le travail.

### Créer un ticket

Chaque membre du groupe doit créer au moins un ticket.
Prenez un moment pour définir les tâches et les répartir clairement.

1. Ouvrez l’onglet **Issues** et cliquez sur le bouton vert **New issue**.
2. Saisissez un titre, par exemple : « Ajouter la recette de la tarte aux pommes
   classique ».
3. Dans la description, vous pouvez préciser par exemple :
   * le type de recette ou de correction ;
   * les contraintes éventuelles (ex. « prévoir une version sans gluten ») ;
4. Cliquez sur **Create issue**.

Votre ticket s’affiche maintenant dans la liste des _issues_, visible par toute
la brigade, et le chef cuisinier peut affecter le ticket à un membre de la
brigage (_assignee_) ou ajouter des _labels_[^labels] pour faciliter le tri.

[^labels]: Vous pouvez utiliser les _labels_ GitHub ou GitLab pour organiser vos
           _issues_ par type, priorité ou encore statut (ex. `à faire`,
           `urgent`, `en cours`, `terminé`, `CI/CD`, `recette`). Vous
           retrouverez quelques exemples d'utilisation des _labels_ sur [le
           projet GitLab associé à cette
           formation](https://gitlab.in2p3.fr/grasland/formation-git/-/work_items).


## Créer un _fork_ et cloner le dépôt en local

Chaque membre de la brigade autre le chef doit maintenant créer un _fork_ du
dépôt, le cloner en local, et configurer les _remotes_ afin de pouvoir
facilement ajouter des recettes. Si vous avez un trou de mémoire, retrouvez le
détail de la procédure dans la section [contribution](../3-contribution.md).

De son côté, le chef peut continuer à travailler comme quand il était tout seul,
à pousser des branches directement dans le dépôt, à ceci près qu'il ne peut plus
pousser directement sur la branche `main` puisque nous avons choisi de faire
passer toutes les contributions y compris celles du chef par une _pull request_
(et donc par une vérification de la CI) afin d'homogénéiser les procédures
qualité.


## Du ticket à la _pull request_ : un flux de travail collaboratif

Vous allez travailler à plusieurs sur le même dépôt git. Pour limiter les
conflits, il est impératif de toujours créer une nouvelle branche pour chaque
recette ou correction. Essayez aussi tant que possible de limiter la durée de
vie de vos branches pour faciliter les fusions.

Pour simplifier la collaboration et fluidifier le processus de contribution,
nous vous proposons de suivre la démarche suivante :

1. Choisir un ticket à traiter
2. Créer une branche dédiée avec un nom explicite et le numéro du ticket (ex.
   `123-recette-tiramisu` pour le ticket #123)
3. Modifier ou ajouter la recette/correction [^close-with-commit]
4. Pousser la branche sur GitHub
5. Créer une _pull request_ pour intégrer les modifications dans la branche
   principale `main`
6. Assigner un relecteur (un autre membre de la brigade)[^reviewer] pour valider
   les modifications avant fusion
7. Corriger en fonction des retours éventuels
8. Fusionner la _pull request_ une fois validée[^cleanup-branch]

[^close-with-commit]: Pour fermer automatiquement le ticket une fois la _pull
request_ fusionnée, ajoutez `fixes #<numéro-du-ticket>` dans le message du
commit ou de la _pull request_ (ex. `fixes #123` pour le ticket #123).

[^reviewer]: Pour garantir la qualité des contributions, il est recommandé de
confier la relecture à une personne autre que l’auteur. En effet, il est souvent
plus facile de repérer les erreurs dans le travail des autres que dans le sien.

[^cleanup-branch]: Après la fusion de la _pull request_, pensez à supprimer la
branche de travail locale et distante pour garder un dépôt propre. Le chef
cuisinier peut automatiser la suppression des branches de développement des
_forks_ en cochant l’option « Automatically delete head branches » dans les
paramètres du dépôt, mais la suppression des branches locales doit être
effectuée manuellement avec la commande `git branch -d <nom-de-la-branche>`.

<div class="warning">

Pour éviter les conflits, n’oubliez pas de toujours synchroniser votre branche
locale avec la branche `main` avant de créer une nouvelle branche de
travail. Pensez aussi à régulièrement mettre à jour votre branche de travail
avec les dernières modifications de `main` en utilisant `git merge` ou `git
rebase`.

</div>

À vous de jouer ! Créez vos tickets, ajoutez vos meilleures recettes, rédigez
vos _pull requests_ et regardez votre livre de cuisine collaboratif prendre
forme, page après page.


## Conclusion

Dans ce TP, vous avez découvert comment travailler en équipe sur GitHub et gérer
un dépôt commun. En particulier, vous avez appris à :

- Modifier les paramètres d’un dépôt initialement pensé comme projet personnel
  afin de l’ouvrir aux contributions extérieures ;
- Protéger la branche `main` pour imposer l'utilisation de _pull requests_.
- Organiser le travail grâce aux tickets (_issues_) pour répartir clairement les
  tâches ;
- Créer des branches pour chaque contribution et assurer un flux de travail
  propre et sans (trop de) conflit ;
- Soumettre et relire les modifications via les _pull requests_, afin de
  garantir la qualité et la cohérence du projet.

Grâce à ces notions, votre brigade dispose désormais de bases solides pour
collaborer efficacement sur tout type de projet GitHub, qu’il s’agisse d’un
simple livre de cuisine ou d’un véritable projet de développement logiciel.

Dans la [prochaine section](3-deploiement-continu.md), nous reprendrons les
notions d’intégration continue abordées précédemment et les transposerons à ce
nouveau contexte collaboratif. Nous verrons comment utiliser cet outil pour vous
accompagner dans vos demandes de fusion et automatiser certaines vérifications.
Et enfin nous aborderons la mise en ligne de votre livre de cuisine sous la
forme d’un site web statique généré automatiquement à chaque mise à jour du
projet.
