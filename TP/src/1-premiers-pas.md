# Premiers pas avec git

<a href="Pres1-Introduction.pdf" target="blank">Retrouvez ici les supports de la
présentation.</a>


## Mode d’emploi des TPs

Tout d'abord, notez que le titre de chaque TP est un lien vers les supports
de la présentation correspondante, ce qui vous permet de la réviser à tête
reposée...

Afin de s’adapter au rythme de progression de chacun, les TPs sont pensés pour
être suivis de façon autonome. Ils sont construits de la façon suivante :

- Une **partie guidée**, où des concepts sont introduits à travers l’exécution
  commentée d’une série de commandes, avec un récapitulatif à la fin.
- Des **exercices** pour pratiquer l’utilisation de git.
- Une **antisèche** qui résume toutes les commandes qui ont été introduites.
- Des **informations complémentaires**, qui ne sont pas essentielles mais
  permettent d’approfondir certains aspects de l’outil.

Les commandes à exécuter dans un terminal sont représentées par du texte en
police à chasse fixe, avec un bouton pour copier le texte qui s’affiche au
survol, comme ci-dessous :

```bash
{{#include 1-premiers-pas.sh:whoami}}
```

La plupart des commandes git ont un effet contextuel dépendant des autres
commandes git qui ont été exécutées auparavant. Par conséquent, la partie guidée
du TP suppose que l’ensemble des commandes indiquées ont été exécutées, dans
l’ordre indiqué, et à l’exclusion de toute autre commande. Si vous souhaitez
faire des expériences pour vérifier que vous avez bien compris les explications,
nous vous conseillons de créer un dépôt git à part (par exemple en faisant un
copier-coller du dossier contenant le dépôt actif) afin de ne pas perturber le
bon fonctionnement du TP.

L’idée de ce mode de formation est que chacun puisse avancer à son rythme, sans
devoir se concentrer sur de longs discours magistraux. Mais le formateur est là
pour répondre à toutes vos questions. N’hésitez surtout pas à le solliciter !


## Configuration du système

### Point de départ

Durant cette formation, vous allez travailler sur des postes de travail Linux
équipés des logiciels git, `gitg`, Meld, de quelques éditeurs de texte pour
s’adapter aux habitudes de chacun (`nano`, `vim`, `emacs` et `gedit`), et
d'utilitaires systèmes de base (`wget`, `unzip`).

La plupart des postes ont une étiquette collée dessus avec un nom de machine
commençant par « ld-ens » et se terminant par un numéro entre 1 et 20, du style
« ld-ens17 ». Pour les postes dont l’étiquette s’est décollée, vous pouvez
utiliser les étiquettes des postes voisins pour déduire leur numéro, la
numérotation suivant une logique très simple.

Du numéro de poste, vous pouvez déduire le nom du compte utilisateur que vous
allez utiliser, dans l’exemple ci-dessus ce serait « formation-git-17 ». Le mot
de passe sera communiqué oralement.

Ces postes sont aussi configurés pour partager les supports de TP avec le poste
enseignant, vous trouverez un raccourci vers ceux-ci sur votre bureau.

<div class="warning">

Vous l’avez vu, les mots de passe sont dérivés en suivant une logique
simple, donc tout le reste de la salle peut deviner votre mot de passe. Pour
plus de confidentialité, n’hésitez pas à configurer un mot de passe plus
secret avec la commande `passwd`.

</div>

### S’identifier auprès de git

Les gestionnaires de versions permettent à plusieurs personnes d’échanger des
versions de fichiers entre eux. Il est alors utile de savoir qui a contribué
quoi, et comment contacter cette personne.

git vous demandera donc de lui donner votre nom et votre adresse e-mail avant de
vous laisser sauvegarder des versions.

Si plus tard vous utilisez git avec une forge (GitHub, GitLab...), c'est cette
adresse mail qui sera utilisée par la forge pour relier les commits qui ont été
mis en ligne à votre compte utilisateur.

Voici un exemple d’utilisation des commandes associées :

```bash
{{#include 1-premiers-pas.sh:config-user}}
```

### Choisir un éditeur de texte

git vous demandera parfois de saisir du texte avec un éditeur. Cet éditeur est
configurable, par défaut il s’agit de `vim`.

Le choix d’un éditeur de texte relevant de la guerre de religion, nous dirons
juste qu’il est recommandé d’utiliser un éditeur en mode console pour cet usage,
et qu’il est conseillé à ceux qui n’ont jamais utilisé ce type d’éditeur de
plutôt utiliser `nano` pour cette formation.

Voici comment on configure `nano` comme éditeur par défaut, vous pouvez modifier
cette commande pour utiliser un des autres éditeurs de texte disponibles si vous
le souhaitez :

```bash
{{#include 1-premiers-pas.sh:config-editor}}
```

Ce choix ne concerne que les situations où git ouvre automatiquement un éditeur
pour vous faire saisir du texte. Vous restez libre d’utiliser l'éditeur que vous
voulez pour modifier vos fichiers entre deux appels à des commandes git.

### Choisir un nom de branche par défaut

Historiquement, lorsqu’on créait un dépôt git, la branche par défaut s’appelait
`master`. Mais ces dernières années ont vu émerger au sein des pays anglo-saxons
un mouvement politique contre l’utilisation de la terminologie maître/esclave
sous-jacente, qui est perçue comme ayant des connotations post-coloniales
malheureuses.

Il y a donc un plan à long terme pour changer le nom de branche par défaut de
git, et pour éviter que vos scripts ne soient cassés par ce changement futur il
est recommandé de choisir vous même un nom de branche par défaut. Nous vous
proposons de l'appeler `main` à la manière de Github :

```bash
{{#include 1-premiers-pas.sh:config-default-branch}}
```

### Afficher la configuration

git peut être configuré à plusieurs niveaux (dépôt, compte utilisateur, système
entier), donc il est utile de pouvoir vérifier quelle est la configuration
finale effective au sein d’un dépôt donné. On l’affiche comme ceci :

```bash
{{#include 1-premiers-pas.sh:config-list}}
```


## Premiers pas avec la gestion de version

### Créer un dépôt

N’importe quel dossier peut être mis sous gestion de version. Il devient alors
ce que l’on appelle un dépôt git. On utilise pour cela la commande `git init` :

```bash
{{#include 1-premiers-pas.sh:init}}
```

Comme le message de statut l’indique, cette opération crée un sous-dossier caché
`.git`, où git stockera l’ensemble de l’état interne du dépôt et en particulier
les versions de fichiers.

### Statut et ajouts

On peut à tout moment demander quel est l’état actuel du dépôt avec
`git status`. Pour l’instant, il ne s’y passe pas grand-chose :

```bash
{{#include 1-premiers-pas.sh:status}}
```

Mais dès la création d’un fichier, le statut change :

```bash
{{#include 1-premiers-pas.sh:status-touch}}
```

Comme la plupart des gestionnaires de versions, git ne suit pas automatiquement
les modifications de tous les fichiers du dossier dans lequel il est actif. Il
faut indiquer quels fichiers on souhaite versionner avec `git add` :

```bash
{{#include 1-premiers-pas.sh:status-add}}
```

Après cette opération, `MonFichier.txt` est suivi par git : lorsqu’on
enregistrera une version du dépôt (un _commit_), ce fichier y sera présent.

En cas de `git add` non désiré, on peut bien sûr annuler cette opération.
Supposons, par exemple, qu’on ait accidentellement ajouté un journal d’exécution
sans intérêt à la gestion de version :

```bash
{{#include 1-premiers-pas.sh:echo-poubelle-add}}
```

Avec une version moderne de git, il suffit d’utiliser la variante de `git reset`
qui prend un fichier en argument pour annuler cette opération :

```bash
{{#include 1-premiers-pas.sh:status-reset}}
```

Sur d’anciennes versions de git que vous pourriez rencontrer si vous êtes amené
à utiliser des distributions Linux très « matures » comme CentOS 7, il fallait
faire appel à la commande plus obscure et spécifique `git rm --cached
<fichier>`.

### Ignorer des fichiers

Tout contenu ne devrait pas être mis sous gestion de version. Il existe trois
raisons classiques d’en exclure des fichiers :

- Ils contiennent des données que l’on ne souhaite pas partager avec autrui
  (ex : mots de passe, configurations d’outils relevant du goût personnel…)
- Ils peuvent être régénérés à partir des fichiers restants (ex : résultats
  d’une compilation de code source, journaux d’exécution…) et représentent donc
  une information redondante
- Ils sont trop lourds pour qu’on puisse se permettre d’en conserver chaque
  version historique

Un problème que nous allons alors vouloir résoudre est que `git` détecte ces
nouveaux fichier et va nous inciter constamment à les versionner lors de chaque
appel à `git status` :

```bash
{{#include 1-premiers-pas.sh:ignore-status}}
```

Pour éviter ça, on peut créer un fichier `.gitignore` à la racine du dépôt, qui
indique que certains fichiers doivent être ignorés par git :

```bash
{{#include 1-premiers-pas.sh:ignore-gitignore-status}}
```

Il est en général pertinent de mettre `.gitignore` sous gestion de version car
si un fichier vous gêne, il a de fortes chances de gêner vos collègues aussi. On
le fait avec `git add`, comme précédemment :

```bash
{{#include 1-premiers-pas.sh:ignore-add-gitignore}}
```

`.gitignore` supporte les motifs usuels du shell Unix, comme l’étoile
(_wildcard_), et sa configuration s’applique à chaque sous-dossier du dépôt.
Pour gérer des situations plus complexes, des syntaxes plus sophistiquées sont
disponibles, consultez `git help gitignore` pour plus de détails.

### Déplacement et suppression de fichier

À partir du moment où un fichier est sous gestion de version, il est préférable
d’informer le gestionnaire de version quand on effectue un déplacement ou une
suppression, en utilisant respectivement `git mv` et `git rm`.

```bash
{{#include 1-premiers-pas.sh:mv-with-git}}
```

En effet, un gestionnaire de versions n’est pas en position de détecter ces
opérations, et si on les effectue avec les outils habituels, elles seront
interprétées par git d’une façon inattendue et indésirable. Prenons l’exemple
d’un mouvement de fichier dont git n’a pas été informé :

```bash
{{#include 1-premiers-pas.sh:mv-without-git}}
```

Ici, la commande `mv` standard a ainsi été interprétée comme la suppression d’un
fichier sous gestion de version et la création d’un nouveau fichier non
versionné. Ce n’est pas ce qui était désiré !

Une commande pratique pour se tirer de ce genre de mauvais pas est
`git add --all`, qui intègre à la gestion de version tous les changements d’un
répertoire passé en paramètre (ou, si aucun répertoire n’est passé en paramètre,
tous les changements du dépôt).

Nous pouvons l’utiliser de la façon suivante :

```bash
{{#include 1-premiers-pas.sh:mv-add-all}}
```

Pour ce qui concerne `git rm`, un point à connaître est que git refusera par
défaut de supprimer un fichier ayant des changements non enregistrés dans une
version, car ces données seraient alors perdues. Ainsi, la commande suivante
échouera :

```bash
{{#include 1-premiers-pas.sh:rm-unversioned}}
```

Après s’être assuré qu’on souhaite bien perdre ces changements, l’option
`--force`, qui s’abrévie en `-f`, peut être utilisée pour confirmer l’opération.

```bash
{{#include 1-premiers-pas.sh:rm-unversioned-force}}
```

### Gestion des dossiers

Contrairement à votre système d’exploitation, git ne gère qu’une arborescence de
_fichiers_. L’existence de dossiers n’est prise en compte que dans la mesure où
il y a des fichiers à l’intérieur :

```bash
{{#include 1-premiers-pas.sh:folder-empty}}
```

Cela ne signifie pas pour autant que git ne supporte pas les dossiers, on peut
très bien passer un dossier en paramètre de `git add` par exemple…

```bash
{{#include 1-premiers-pas.sh:folder-add}}
```

…mais certaines commandes n’accepteront un dossier en paramètre que si elles
sont agrémentées d’une option `--recursive` (qui s’abrévie en `-r`). C’est
généralement le cas lorsqu’il est risqué d’effectuer une opération sur un
dossier sans connaître son contenu. Par exemple, la commande de suppression
suivante échouera.

```bash
{{#include 1-premiers-pas.sh:folder-rm}}
```

Notez que puisque le contenu de ce dossier n’a pas encore été sauvegardé, vous
devriez même utiliser `-rf` dans ce cas précis pour convaincre git que vous
savez ce que vous faites.

### Aide de git

Comme la plupart des outils Unix, git dispose d’une documentation de référence
accessible depuis la ligne de commande, soit via la traditionnelle interface
`man`, soit via la commande `git help`.

```bash
{{#include 1-premiers-pas.sh:help-long}}
```

`git help` reproduit par défaut le comportement de la commande `man`, mais donne
aussi accès à quelques documentations généralistes qui ne sont pas facilement
accessibles par le biais de `man`, comme `git help everyday`.

En principe, `git help` donne également accès à des formats de documentation
alternatifs, tels que des pages HTML. Mais ces derniers ne sont malheureusement
que rarement inclus dans les distributions de git. Si vous souhaitez consulter
la documentation au format HTML, il est donc plus sûr de le faire en ligne à
l’adresse [https://www.git-scm.com/docs](https://www.git-scm.com/docs).

Si vous ne cherchez pas une explication détaillée du fonctionnement d’une
commande, mais seulement un bref rappel de la syntaxe et des options, vous
pouvez aussi utiliser l’option `-h` :

```bash
{{#include 1-premiers-pas.sh:help-short}}
```


## Conclusion

Dans ce premier TP, nous avons vu comment…

- Configurer son système pour l’utilisation de git
- Mettre un répertoire sous gestion de version
- Connaître l’état actuel de git
- Désigner quels fichiers doivent être versionnés ou non
- Effectuer des opérations de base sur ces fichiers
- Utiliser l’aide de git

Mais des zones d’ombres demeurent. Comment créer des versions ? Et quelle est
donc cette « branche `main` » dont `git status` ne cesse de parler ? Nous
répondrons à ces questions dans les prochaines séquences.


## Exercices

1. Créez un dépôt git vide.
2. Configurez le dépôt pour ignorer les fichiers portant l’extension « .o ».
3. Créez un fichier et indiquez à git que vous souhaitez le versionner.
4. Déplacez ce fichier vers un autre emplacement et informez-en git.
    - La sortie de `git status` ne doit parler que de deux fichiers à la fin,
      celui que vous venez de déplacer et celui qui a été créé à la question 2.
5. Affichez l’état final du dépôt. En ignorant pour l’instant la partie « Sur
   la branche main », comprenez-vous les autres messages affichés ?


## Antisèche

Afficher la configuration actuelle de git :

```bash
{{#include 1-premiers-pas.sh:config-list}}
```

Saisir les identifiants d’utilisateur qui seront insérés dans les commits :

```bash
{{#include 1-premiers-pas.sh:config-user}}
```

Définir l’éditeur de texte utilisé par git :

```bash
{{#include 1-premiers-pas.sh:config-editor}}
```

Définir le nom de branche par défaut des dépôts nouvellement créés :

```bash
{{#include 1-premiers-pas.sh:config-default-branch}}
```

Transformer le répertoire courant en dépôt git :

```bash
{{#include 1-premiers-pas.sh:init-only}}
```

Afficher l’état du dépôt git actif :

```bash
{{#include 1-premiers-pas.sh:status}}
```

Mettre un fichier (ou un dossier) sous gestion de version :

```bash
{{#include 1-premiers-pas.sh:add-only}}
```

Annuler un `git add` accidentel :

```bash
{{#include 1-premiers-pas.sh:reset-only}}
```

Mettre tous les fichiers du répertoire courant sous gestion de version :

```bash
{{#include 1-premiers-pas.sh:add-workdir}}
```

Intégrer à la gestion de version tous les changements du répertoire courant,
y compris les suppressions, les déplacements…

```bash
{{#include 1-premiers-pas.sh:mv-add-all-only}}
```

Supprimer un fichier sous gestion de version :

```bash
{{#include 1-premiers-pas.sh:cheatsheet-rm}}
```

Déplacer un fichier sous gestion de version :

```bash
{{#include 1-premiers-pas.sh:cheatsheet-mv}}
```

Ignorer les fichiers d’extension « .log » :

```bash
{{#include 1-premiers-pas.sh:ignore-gitignore-docs}}
```

Afficher le manuel d’une commande git ou l’explication d’un concept git :

```bash
{{#include 1-premiers-pas.sh:cheatsheet-help}}
```

Afficher un bref rappel de la syntaxe d’une commande git :

```bash
{{#include 1-premiers-pas.sh:help-short-docs}}
```


## Informations complémentaires

### Interface de configuration

On peut configurer git selon trois périmètres :

1. Ensemble des utilisateurs du système hôte (« system »)
2. Compte utilisateur actif (« global »)
3. Dépôt git actif (« local », choix par défaut)

Quand deux périmètres sont en désaccord, c’est la configuration du périmètre le
plus étroit qui est utilisée. Par exemple, si la configuration système spécifie
que l’éditeur de texte à utiliser est `vi` et la configuration d’utilisateur
spécifie que c’est `emacs`, git utilisera `emacs` comme éditeur de texte.

L’emplacement de la configuration varie d’un système d’exploitation à l’autre.
Mais vous n’avez heureusement pas besoin de l’apprendre par cœur, car vous
pouvez manipuler cette dernière avec l’utilitaire `git config`, dont voici
quelques utilisations fictives :

```bash
{{#include 1-premiers-pas.sh:appendix-config}}
```

Pour rappel, la configuration s’appliquant au dépôt actuel (qui est donc la
configuration système amendée d’abord par la configuration utilisateur puis par
la configuration spécifique au dépôt actif) peut être affichée avec `git config
--list`.
