# <a href="Pres2-Versions.pdf" target="blank">Un historique linéaire</a>

## Retour à l’état attendu

Les TPs de cette formation sont conçus pour s’enchaîner, chaque TP réutilisant
les dépôts git créés au cours du TP précédent. Mais l’expérience montre que cet
enchaînement ne se produit pas toujours comme prévu, si par exemple…

- Vous n’avez pas réussi à finir un TP à temps
- Vous avez exécuté des commandes git imprévues dans un dépôt utilisé par le TP
- Vous avez raté une partie de la formation

Pour éviter que ces problèmes ne se propagent d’un TP au suivant, je vous
propose de reprendre chaque nouveau TP sur une base connue, à savoir le résultat
d’une exécution rigoureuse de l’ensemble des commandes des TPs précédents, et
rien que ces commandes.

Cela ne produira pas exactement le même résultat que si vous aviez fait le TP
vous même (par exemple les messages de commits seront différents et l’auteur des
commits sera la personne fictive « Francine Dupont »), mais au moins vous
opérerez en terrain connu au début de chaque TP.

Pour ce deuxième TP, le script bash à exécuter pour archiver votre travail sur le
premier TP et repartir de l’[archive de référence](TP2.zip) est :

```bash
{{#include 2-historique-lineaire.sh:restore-from-zip}}
```


## Processus de création de version

### Un premier commit

Au cours du TP précédent, nous avons manipulé l’état de notre répertoire de
travail. Il est maintenant temps d’en sauvegarder une première version.

Pour cela, nous allons faire appel à la commande `git commit`, qui en retour va
immédiatement nous plonger dans un éditeur de texte :

```bash
{{#include 2-historique-lineaire.sh:first-interactive-commit}}
```

Le rôle de cet éditeur de texte est de saisir une description des changements
effectués dans la nouvelle version qui va être sauvegardé.

Le format est libre, mais une convention très répandue dans le monde git est de
commencer par un résumé court (une ligne de moins de 80 caractères),
éventuellement suivi d’une paire de sauts de lignes et une description plus
précise. Cette convention est exploitée par de nombreux outils de visualisation,
je vous conseille donc de la suivre.

Notez que le fichier texte ouvert par `git commit` contient déjà un
récapitulatif de l’état actuel du dépôt, similaire à celui qui est affiché
par `git status`. Ce dernier ne sera pas présent dans la description finale. Il
vous permet juste de vérifier rapidement les changements qui seront sauvegardés.

La version sera créée lorsque vous quitterez l’éditeur de texte en sauvegardant
la description. Mais si vous vous rendez compte que vous avez tapé `git commit`
trop vite, pas de panique : il suffit de saisir une description vide (ou de
quitter l’éditeur de texte sans sauvegarder vos modifications) pour annuler
l’opération.

Pour rappel, pour quitter l’éditeur de texte `nano` en enregistrant vos
changements, il faut utiliser le raccourci clavier Ctrl+X (indiqué en bas à
gauche), confirmer que vous voulez enregistrer vos modifications avec O (ou Y si
votre système d’exploitation est configuré en anglais), et confirmer que vous
voulez enregistrer au même endroit en appuyant sur Entrée.

### Nouveau contenu et différences

Après avoir créé un commit, la sortie de `git status` change :

```bash
{{#include 2-historique-lineaire.sh:status-after-commit}}
```

La commande status décrit en effet toujours l’état de l’index et du répertoire
de travail par rapport à la dernière version enregistrée (`HEAD`).

Ici, si vous avez suivi fidèlement le TP1, tous les changements du répertoire de
travail qui ne sont pas dans la liste `.gitignore` ont été enregistrés dans le
premier commit. `git status` devrait donc indiquer qu’il n’y a rien de nouveau.

Effectuons maintenant quelques changements :

```bash
{{#include 2-historique-lineaire.sh:change-then-status}}
```

Comme la plupart des gestionnaires de version, git distingue les changements
apportés à des fichiers sous gestion de version des créations de nouveaux
fichiers dans le répertoire de travail.

Pour visualiser le premier type de changement, on peut utiliser `git diff` :

```bash
{{#include 2-historique-lineaire.sh:diff-after-change}}
```

Cette commande décrit les différences entre le répertoire de travail et l’index,
selon un format similaire à celui de l’utilitaire `diff` des systèmes Unix.

<div class="warning">

  Malheureusement, la commande `git diff` a un comportement piégeux hérité
  d’autres gestionnaires de versions historiques : elle ne tient compte que des
  fichiers qui ont précédemment été mis sous gestion de version avec `git add`.
  Un fichier nouvellement créé dans le répertoire de travail ne sera pas
  mentionné par la sortie de `git diff`.

  Ceci fait qu’en pratique, si on prend la mauvaise habitude de n’interroger que
  `git diff` et jamais `git status` pour savoir où on en est, il est facile
  d’oublier les nouveaux fichiers du répertoire de travail lors de la création
  d’un commit et de créer des _commits_ qui n’ont aucun sens (ex : code incomplet
  qui ne compile pas).

  Il est donc important de prendre l’habitude de toujours vérifier la sortie de
  `git status` avant de créer un _commit_ et de ne pas se baser que sur celle de
  `git diff` qui donne une vision incomplète des changements du répertoire de
  travail.

</div>

Puisqu’on en est à parler d’autres gestionnaires de version, les habitués de ces
autres gestionnaires noteront que `git add` combine deux fonctions qui sont en
général distinctes dans d’autres outils :

- Mettre des fichiers sous gestion de version
- Ajouter des changements survenus dans un fichier à la prochaine version

Dans le modèle de git, ces deux opérations sont unifiées par la notion d’index,
qui rend redondante celle de fichier sous gestion de version. Hélas, cette
seconde notion existe hélas toujours dans git, comme le piège ergonomique de
`git diff` discuté ci-dessus l’illustre.

### Aller plus loin avec `git diff`

`git diff` décrit les changements du répertoire de travail par rapport à l’index
(la version en cours de création). Par conséquent, si on ajoute des changements
à l’index, ils disparaissent de la sortie de `git diff` :

```bash
{{#include 2-historique-lineaire.sh:changes-and-diffs}}
```

Ce mode de fonctionnement aide à créer une nouvelle version progressivement :

- On fait un point sur les changements effectués depuis la dernière version
- On décide de ce qui va faire partie de la prochaine version
- On ajoute ces changements à l’index avec `git add`
- On vérifie qu’on n’a rien oublié d’important avec `git diff`
- On crée la nouvelle version avec `git commit`

Mais parfois, on souhaite un autre comportement de la part de `git diff`. On
peut ainsi lui demander la liste des changements effectués au sein du répertoire
de travail depuis la dernière version enregistrée :

```bash
{{#include 2-historique-lineaire.sh:workdir-vs-head}}
```

Ou bien on peut lui demander les changements présents au sein de l’index, qui
seront inclus dans la nouvelle version lorsqu’on appellera `git commit` :

```bash
{{#include 2-historique-lineaire.sh:index-vs-head}}
```

Il est aussi possible, et souvent très utile, de n’afficher que les changements
survenus au sein d’un certain fichier ou dossier avec `git diff <chemin>` :

```bash
{{#include 2-historique-lineaire.sh:diff-target-only}}
```

Plusieurs autres choses sont à noter dans cet exemple :

- La commande `git commit` possède une option `-m` pour spécifier directement la
  description, très pratique quand celle-ci est courte.
- Comme `diff`, `git diff` affiche quelques lignes du fichier autour des
  changements, permettant de comprendre le contexte desdits changements.

### Quelques raccourcis

Outre le raccourci `git commit -m` que nous venons de voir, git possède d’autres
moyens d’accélérer des opérations courantes.

`git add --all [<fichiers>]`, que nous avons brièvement rencontrée précédemment,
ajoute à l’index tous les changements d’un jeu de fichiers et de dossiers, y
compris d’éventuelles suppressions, mais en excluant quand même les fichiers
spécifiés dans le `.gitignore`.

Sans paramètre supplémentaire, cette commande synchronise complètement l’index
avec le répertoire de travail. Cela peut conduire à des ajouts involontaires, il
est donc plus prudent de cibler cette commande sur un dossier comme dans
l’exemple suivant :

```bash
{{#include 2-historique-lineaire.sh:add-all-directory}}
```

`git commit -a` crée un commit comprenant tous les changements survenus dans les
fichiers _sous gestion de version_ depuis le dernier commit.


<div class="warning">

  Comme `git diff`, `git commit -a` ignore complètement les fichiers qui n’ont
  pas été mis préalablement sous gestion de version avec `git add`, imitant
  ainsi la logique d’autres gestionnaires de version comme SVN ou Mercurial.

  Cette logique déjà douteuse dans le cadre de `git diff` est encore plus
  piégeuse dans le cadre de `git commit -a`, et il est courant quand on utilise
  cette commande de créer des commits qui n’ont aucun sens, par exemple du code
  qui ne compile pas parce qu’il manque des nouveaux fichiers sources mentionnés
  par les modifications qui ont été commitées dans d’autres fichiers
  préexistants.
  
  Par conséquent, à moins d’être déjà habitué à un gestionnaire de version où ce
  comportement est normal, je vous déconseille d’utiliser `git commit -a`.

</div>


## Exploration de l’historique

### Visualisation interactive

Nous avons maintenant créé quelques commits, et il est possible d’afficher
l’historique de ces derniers avec `git log` :

```bash
{{#include 2-historique-lineaire.sh:git-log}}
```

Si un commit précis de la liste nous interpelle, nous pouvons ensuite demander
à git d’afficher des informations détaillées sur ce dernier avec
`git show <commit>`, où le commit peut être identifié par son _hash_.

Ces deux commandes sont extrêmement configurables : on peut demander à `git log`
et `git show` d’afficher précisément l’information qu’on veut, dans le format
qu’on veut. Mais force est de constater que malgré tous ces efforts, un
affichage en ligne de commande devient rapidement difficile à lire dès lors que
l’information affichée est un tant soit peu complexe. Un terminal textuel n’est
pas vraiment fait pour ça !

Pour cette raison, je vous recommande fortement d’utiliser une interface
graphique pour visualiser votre historique. Au cours de cette formation, nous
utiliserons pour cela le logiciel `gitg` :

```bash
{{#include 2-historique-lineaire.sh:gitg-foreground}}
```

Vous pouvez constater que `gitg` vous permet d’observer d’un coup d’œil votre
historique. En cliquant sur chaque commit, vous avez aussi accès à des
informations plus détaillées : description détaillée, _hash_, détail des
modifications effectuées…

Mais malheureusement, comme la plupart des applications graphiques, `gitg`
empêche la saisie de commandes supplémentaires tant qu’elle est en exécution. Si
vous retournez dans votre terminal, vous pourrez constater qu’il n’acceptera
plus de commandes tant que vous n’aurez pas fermé `gitg`.

Pour éviter ça, lancez l’application en tâche de fond avec l’aide du signe `&` :

```bash
{{#include 2-historique-lineaire.sh:gitg-background}}
```

Dans cette configuration, vous garderez la possibilité de saisir des commandes.

Votre terminal restera toutefois occasionnellement « pollué » par des erreurs
non fatales d’exécution de `gitg`… Si cela vous énerve, vous pouvez ajouter
`2>/dev/null` à la fin de votre commande de lancement `gitg` pour supprimer ces
messages :


```bash
{{#include 2-historique-lineaire.sh:gitg-noerror}}
```

### Premières requêtes

git est basé sur la notion de différence, et chaque version y est définie par
les changements qu’elle opère vis-à-vis de la version précédente.

Si cette vision « locale » des choses est parfois suffisante, il est souvent
nécessaire de raisonner par rapport à des versions relativement éloignées dans
le passé. Pour ce faire, plusieurs options s’offrent à nous.

Tout d’abord, il est possible d’afficher les changements survenus dans le
répertoire de travail depuis une ancienne version avec `git diff <commit>`. Il
est également possible d’afficher la différence entre deux versions enregistrées
du projet avec `git diff <commit1> <commit2>`.

Vous aurez peut-être remarqué que nous avons déjà utilisé la première de ces
deux commandes, avec l’identifiant `HEAD` qui désigne le dernier _commit_
enregistré. Pour des raisons de concision, nous parlerons désormais de « commit
actif ».

À tout identifiant de commit, nous pouvons ajouter le suffixe `~[N]` pour
désigner le (N-ième) parent de ce commit. Ainsi, `HEAD~` est le parent du commit
actif, et `HEAD~2` est son grand-parent.

Avec cette syntaxe, nous pouvons demander à git la différence entre le
répertoire de travail et le parent du commit actif…

```bash
{{#include 2-historique-lineaire.sh:diff-workdir-vs-head-parent}}
```

…ou bien les changements du commit actif par rapport à son parent :

```bash
{{#include 2-historique-lineaire.sh:diff-head-vs-head-parent}}
```

### Nommer un commit

Désigner des commits par des _hashes_ absolus ou par des chemins relatifs à base
de HEAD est fastidieux, et le risque d’erreur est élevé. Lorsqu’on doit souvent
faire référence à un commit, il est préférable de lui donner un nom plus
lisible pour un être humain.

En gestion de version, cela s’appelle une étiquette (_tag_), et on peut en créer
une avec la commande `git tag <étiquette> [<commit>]` :

```bash
{{#include 2-historique-lineaire.sh:tag-basic}}
```

Après l’exécution de ces commandes…

- `important` pointe sur le commit actif (`HEAD`)
- `papa` pointe sur le commit avant le commit actif (`HEAD~`)
- `maman` pointe sur le commit avant `important` (donc `HEAD~`, comme `papa`)
- `ancetre` pointe deux commits avant le commit actif (donc sur le commit
  `HEAD~2`, qui précède le commit doublement étiqueté `papa`/`maman`).

Vous pouvez visualiser ces étiquettes dans `gitg` en redémarrant ce dernier ou
en rafraîchissant son affichage avec le raccourci clavier `Ctrl+R`.

Contrairement à `HEAD` et à la branche active, les étiquettes ne bougent pas.
Si vous créez de nouveaux commits par la suite, `important` pointera
toujours vers le même commit.

Si vous le souhaitez, vous pouvez ajouter une description à votre étiquette,
avec l’option `--annotate` de `git tag`. Ces annotations sont souvent utilisées
pour indiquer les points du développement d’un logiciel auxquels une version
publique a été distribuée, et documenter les nouveautés de cette version.

Par défaut, `git tag --annotate` ouvre un éditeur de texte comme `git commit`.
Et comme avec `git commit`, on peut utiliser l’option `-m` pour saisir
l’annotation dans la ligne de commande :

```bash
{{#include 2-historique-lineaire.sh:tag-annotate-interactive}}
```

On peut afficher la description d’une étiquette annotée avec la commande `git
show` :

```bash
{{#include 2-historique-lineaire.sh:show-annotated-tag}}
```

La liste des étiquettes présentes dans le dépôt peut être affichée avec `git tag
--list`, ou tout simplement `git tag` :

```bash
{{#include 2-historique-lineaire.sh:tag-list}}
```

Et enfin, vous pouvez détruire des étiquettes avec `git tag --delete` :

```bash
{{#include 2-historique-lineaire.sh:tag-delete}}
```

### Revenir dans le passé

git nous permet aussi de remonter le temps, et de charger le contenu d’une
version préalablement enregistrée dans le répertoire de travail.

Pour que les choses se passent bien, il faut au préalable s’assurer que ledit
répertoire de travail soit _propre_, c’est-à-dire qu’il n’y ait pas de
changements non enregistrés dans celui-ci. Pour savoir si c’est le cas, on peut
comme toujours utiliser `git status` :

```bash
{{#include 2-historique-lineaire.sh:status-before-checkout}}
```

Si vous avez suivi le déroulement prévu du TP, ce n’est pas le cas, il y a des
changements en attente. Il va falloir s’occuper de ces changements d’abord, par
exemple en les sauvegardant sous forme d’un nouveau `commit`.

```bash
{{#include 2-historique-lineaire.sh:commit-before-checkout}}
```

Maintenant, nous sommes prêts. Revenons donc à un ancien commit, par exemple le
parent de celui que nous venons de créer, avec la commande `git checkout` :

```bash
{{#include 2-historique-lineaire.sh:checkout-head-parent}}
```

<div class="warning">
  
  git affiche alors un message pour vous avertir que vous n’êtes plus sur une
  branche, et que si vous créez des commits quand le dépôt est dans cet état,
  vous ne pourrez pas facilement les retrouver par la suite. En terminologie
  git, on désigne cet état par le nom morbide de `HEAD détachée`.

  Le reste du message vous explique comment vous pourriez préserver vos
  changements en créant une autre branche. Nous reviendrons sur tout ça quand
  nous aurons abordé les branches, mais ici nous ne souhaitons pas créer de
  nouveaux commits donc vous pouvez ignorer cette suggestion.

</div>

Quoi qu’il en soit, si vous regardez les fichiers de votre dépôt, vous pouvez
constater que leur contenu a changé pour reprendre la valeur qu’ils avaient dans
la version précédente. Une vraie machine à voyager dans le temps !

N’hésitez pas à revenir en différents points de votre historique avec
`git checkout`, en utilisant `gitg` pour retrouver les identifiants de vos
commits. Par défaut, `gitg` affiche l’historique relativement au commit actif,
mais vous pouvez lui faire afficher l’ensemble des commits du dépôt en
sélectionnant l’option « Tous les commits » dans le menu de gauche.

Quand vous avez fini d’explorer, il est facile de revenir à la fin de
l’historique principal en rebasculant sur la branche `main` :

```bash
{{#include 2-historique-lineaire.sh:checkout-back-main}}
```

### Annuler un jeu de commits

Il est possible d’annuler l’effet d’un jeu de commits de façon non-destructive
(il est possible de revenir à l’état avant annulation par la suite) avec la
commande `git revert`.

Cette commande modifie l’effet du répertoire de travail, il faut donc s’assurer
d’abord que ledit répertoire de travail est propre :

```bash
{{#include 2-historique-lineaire.sh:status-before-revert}}
```

Ensuite, pour annuler par exemple l’effet du dernier commit effectué, on utilise
la commande `git revert`, qui crée un commit annulant l’effet d’anciens commits
de l’historique.

Comme `git commit`, `git revert` ouvre un éditeur de texte pour saisir la
description du commit. Mais contrairement à `git commit`, **on ne peut pas
utiliser `-m` ici** pour saisir cette description directement dans la ligne de
commande.

```bash
{{#include 2-historique-lineaire.sh:revert-head}}
```

À plus grande échelle, il est aussi possible d’annuler l’effet de plusieurs
commits avec la variante `git revert <commit1> <commit2>`, ou celui
d’une série de commits avec la variante `git revert <commit1>..<commitN>` (notez
les deux points entre les deux identifiants de commit spécifiant le début et la
fin du jeu de changement à annuler).

Dans ce cas, `git revert` peut créer plusieurs commits d’annulation, et c’est la
raison pour laquelle l’option `-m` ne peut pas être supportée par `git revert` :
elle n’a de sens que pour des commandes qui ne créent qu’un seul commit.

Puisque `git revert` fonctionne en créant un nouveau commit, c’est une commande
sans risque : l’ancien commit n’est pas perdu, il reste facilement accessible au
sein de l’historique. On ne peut donc pas perdre accidentellement des données en
utilisant `revert`.

<div class="warning">

  Le prix à payer pour cette sécurité est que `git revert` n’est pas l’outil
  approprié pour éliminer du dépôt un fichier qui n’aurait jamais dû s’y
  trouver, comme un secret cryptographique ou un profil de performances
  d’exécution de plusieurs gigaoctets. Avec `git revert`, ces fichiers
  resteraient dans l’historique, ce qui n’est pas désirable. Pour les éliminer
  vraiment du dépôt, il faudra faire appel à des outils beaucoup plus
  destructeurs tels que `git filter-branch`, ou le logiciel tiers `filter-repo`.

  Ces outils pouvant causer beaucoup de dommages s’ils sont mal maniés, je vous
  recommande donc de ne pas y avoir recours quand vous débutez avec git, et de
  privilégier chaque fois que c’est possible des méthodes d’édition d’historique
  moins dangereuses car plus compréhensibles et d’impact plus localisé, telles
  que `git reset --hard HEAD~N` qui enlève « juste » les N derniers commits de
  l’historique de la branche active. Nous reviendrons sur ces possibilités après
  avoir abordé la question des branches.

</div>

## Conclusion

Dans ce TP, nous avons vu comment git permet de…

- Sauvegarder des versions de son travail (_commits_)
- Comparer des versions de fichiers avec `git diff`
- Visualiser l’historique du dépôt
- Désigner les commits au sein de ce dernier de différentes façons
- Accéder à d’anciennes versions de son travail

Avec ces notions, nous pouvons utiliser git pour construire un historique de
fichiers linéaire. C’est tout à fait suffisant pour travailler seul sur un
projet, et les anciens gestionnaires de version allaient rarement au-delà.

Mais pour collaborer facilement avec d’autres personnes, il va falloir
introduire un outil qui permet à git de représenter la notion d’évolution
parallèle : la branche. Ce sera le sujet de la prochaine séquence.


----

## Exercices

1. Créez un dépôt git vide.
2. Ajoutez quelques fichiers du contenu de votre choix, puis enregistrez un
   _commit_ contenant ces fichiers.
3. Modifiez au moins deux des fichiers que vous avez sauvegardés, puis créez un
   commit ne comprenant que les modifications d’un seul fichier.
4. Affichez les modifications qui n’ont pas encore été sauvegardées.
5. Utilisez un raccourci git pour créer un commit contenant les modifications
   des autres fichiers sans avoir besoin de les nommer dans les commandes que
   vous utilisez.
6. Affichez la différence entre les deux premiers commits que vous avez
   effectués au sein du dépôt.
7. Vérifiez que le répertoire de travail est propre.
8. Basculez sur le grand-parent du commit actuel, et attachez-y une étiquette,
   puis revenez sur votre commit de départ.

## Antisèche

Ajouter des changements à l’index pour les inclure dans le prochain commit :

```bash
{{#include 2-historique-lineaire.sh:cheatsheet-add}}
```

…en prenant en compte les suppressions de fichier (rejetées par défaut) :

```bash
{{#include 2-historique-lineaire.sh:cheatsheet-add-all}}
```

Créer un _commit_, une version sauvegardée du projet :

```bash
{{#include 2-historique-lineaire.sh:cheatsheet-commit}}
```

Saisir la description du commit directement dans la commande :

```bash
{{#include 2-historique-lineaire.sh:cheatsheet-commit-message}}
```

Afficher les changements des **fichiers versionnés** par rapport à l’index :

```bash
{{#include 2-historique-lineaire.sh:diff-after-change}}
```

…par rapport au dernier commit enregistré (commit actif) :

```bash
{{#include 2-historique-lineaire.sh:workdir-vs-head}}
```

`HEAD` désigne le dernier commit enregistré. Pour tout commit `com`, `com~`
désigne le commit parent (celui qui le précède) dans l’historique, `com~2` le
commit grand-parent (le parent du parent), et ainsi de suite.

Afficher les changements dans l’index par rapport au commit actif :

```bash
{{#include 2-historique-lineaire.sh:index-vs-head}}
```

Afficher les différences quand on passe du commit A au commit B :

```bash
{{#include 2-historique-lineaire.sh:cheatsheet-diff-commits}}
```

Restreindre l’affichage des changements à certain fichiers ou dossiers :

```bash
{{#include 2-historique-lineaire.sh:diff-folder}}
```

Afficher l’historique des commits en ligne de commande :

```bash
{{#include 2-historique-lineaire.sh:git-log}}
```

Lancer le visualiseur d’historique `gitg` sans bloquer le terminal :

```bash
{{#include 2-historique-lineaire.sh:gitg-background}}
```

Créer une étiquette pointant sur le commit actif :

```bash
{{#include 2-historique-lineaire.sh:cheatsheet-tag}}
```

Créer une étiquette pointant sur un commit autre que le commit actif :

```bash
{{#include 2-historique-lineaire.sh:cheatsheet-tag-with-commit}}
```

Créer une étiquette annotée comprenant une description :

```bash
{{#include 2-historique-lineaire.sh:cheatsheet-tag-annotate}}
```

Afficher la liste des étiquettes présentes dans le dépôt :

```bash
{{#include 2-historique-lineaire.sh:tag-list}}
```

Détruire une ou plusieurs étiquette·s :

```bash
{{#include 2-historique-lineaire.sh:cheatsheet-tag-delete}}
```

Afficher les propriétés d’un commit et de ses étiquettes éventuelles :

```bash
{{#include 2-historique-lineaire.sh:cheatsheet-show}}
```

<div class="warning">

  Les commandes suivantes modifient le répertoire de travail et doivent donc
  être exécutées dans un répertoire de travail propre, sans modifications non
  enregistrées.

  Charger le contenu d’un commit historique dans le répertoire de travail :
  
  ```bash
  {{#include 2-historique-lineaire.sh:cheatsheet-checkout}}
  ```
  
  Revenir sur la branche `main`, la fin de l’historique principal du dépôt :
  
  ```bash
  {{#include 2-historique-lineaire.sh:checkout-back-main}}
  ```
  
  Créer un commit qui annule l’effet d’un ou plusieurs commits précédents :

  ```bash
  {{#include 2-historique-lineaire.sh:cheatsheet-revert}}
  ```
  
  Créer un commit qui annule l’effet de tous les commits entre A et B :
  
  ```bash
  {{#include 2-historique-lineaire.sh:cheatsheet-revert-range}}
  ```

</div>

---

## Informations complémentaires

### Contrôler finement les ajouts à l’index

Parfois, il arrive que l’on se soit un peu laissé emporter et que l’on ait
effectué de nombreuses modifications sur un fichier en oubliant de créer des
versions intermédiaires.

Dans de nombreux projets, créer un grand commit fourre-tout regroupant tous ces
changements est mal vu, et il est préférable de décomposer ces modifications en
plusieurs commits plus simples. Mais comment faire lorsqu’il y a plusieurs
changements qui n’ont rien à voir au sein d’un même fichier ?

git fournit pour ce genre de cas l’outil `git add --patch <fichier>`. C’est une
variante plus avancée de `git add`, qui permet d’ajouter sélectivement des
modifications du fichier à l’index.

Une description complète de cet outil serait difficile à faire par écrit du fait
de sa nature interactive, et sort un peu du cadre de cette formation courte.
Mais si vous avez de l’avance sur le TP, nous vous invitons à solliciter le
formateur pour une démonstration.

### Corriger son dernier commit

Au lieu de créer un nouveau commit, on peut aussi vouloir modifier le commit
précédent, par exemple pour ajouter des modifications oubliées ou pour changer
la description. Tout cela est possible avec l’option `--amend` :

```bash
{{#include 2-historique-lineaire.sh:commit-amend}}
```

Les plus attentifs remarqueront peut-être dans la sortie de `git commit --amend`
que cette opération modifie aussi le _hash_ hexadécimal qui identifie le commit.
Il y a deux raisons à cela :

- Le _hash_ d’un commit est une fonction déterministe de son contenu. C’est ce qui
  fait qu’il est improbable que deux commits indépendants sur le réseau
  aient le même _hash_, permettant ainsi la gestion de version distribuée.
- Un gestionnaire de version ne modifie jamais directement un commit. Quand on
  fait `git commit --amend`, git retire l’ancien commit de l’historique et le
  remplace par un nouveau commit avec nos modifications. L’ancien commit est en
  réalité toujours présent dans le dépôt, et il existe des moyens d’y remonter
  en cas de manipulation accidentelle.

`git commit --amend` est un premier exemple de commande qui modifie
l’historique. git dispose d’un vocabulaire riche de commandes de ce type, que
nous aurons l’occasion d’explorer davantage au cours de la formation.

<div class="warning">

  Un point de vigilance que je dois évoquer dès maintenant, mais ne pourrai
  détailler que plus tard dans la formation, est qu’il vaut mieux éviter
  d’utiliser ces commandes d’édition d’historique sur des commits ou branches
  qui ont été publiés sur un serveur partagé.

</div>

### Annuler des manipulations accidentelles

L’une des fonctions fondamentales d’un gestionnaire de version étant de pouvoir
revenir en arrière en cas de problème, la plupart des opérations git peuvent
être annulées. Voici une première série de commandes pour annuler…

- L’ajout de modifications à l’index → `git reset [<fichiers>]`
    * D’anciennes versions de git distinguaient l’ajout de modifications à
      l’index de l’ajout de fichiers à la gestion de version. Avec elles, il faut
      utiliser `git rm --cached <fichiers>` dans le second cas.
- La création d’un commit → `git reset --soft HEAD~`
- La création d’un commit + les ajouts préalables à l’index → `git reset HEAD~`
- La création d’un commit + les ajouts préalables à l’index + les modifications
  préalables du répertoire de travail → `git reset --hard HEAD~`
    * Soyez prudents avec cette commande : si votre répertoire de travail n’est
      pas propre, ses changements seront perdus de façon irréversible.

Les pouvoirs d’annulation de git se limitent malheureusement aux données qui ont
été versionnées. Les opérations sur le répertoire de travail sont en général
irréversibles. C’est une des raisons pour lesquelles il vaut mieux créer
fréquemment des commits simples que de créer rarement des commits complexes.

La seule chose qu’il est facile de faire dans le répertoire de travail, c’est de
ramener des fichiers du répertoire de travail à l’état enregistré dans `HEAD`,
on utilisera pour ça la commande `git checkout HEAD -- <liste de fichiers>`.
Comme toute opération sur le répertoire de travail, cette commande est
irréversible, donc dangereuse, et doit être utilisée avec prudence pour éviter
des pertes de données.

### Mettre des changements de côté

Parfois, lorsqu’on souhaite se promener dans l’historique avec `git checkout`,
devoir sauvegarder les modifications de son répertoire de travail est ennuyeux.
On n’est pas encore prêt à créer un commit qui représente une version cohérente
du projet, et on n’en voit pas la nécessité alors qu’on veut juste, disons,
aller jeter un coup d’œil à l’histoire du dépôt.

Pour ce genre de cas, git fournit un outil bien pratique appelé `git stash`. Cet
outil prend toutes les modifications non enregistrées du répertoire de travail
et les met de côté dans un endroit à part du dépôt (en fait une branche
temporaire de l’historique).

En voici une petite démonstration :

```bash
{{#include 2-historique-lineaire.sh:stash}}
```

La liste des modifications sauvegardées prend la forme d’une pile, que l’on peut
consulter avec la commande `git stash list` :

```bash
{{#include 2-historique-lineaire.sh:stash-list}}
```

Lorsqu’on est prêt à reprendre le travail sur cette version du répertoire de
travail, il suffit d’utiliser la commande `git stash pop` pour restaurer la
dernière version sauvegardée du répertoire de travail :

```bash
{{#include 2-historique-lineaire.sh:stash-pop}}
```

Cette opération modifie le répertoire de travail comme git checkout, et il est
donc recommandé de ne l’effectuer qu’au sein d’un répertoire de travail propre.

### Autres outils graphiques

Une liste relativement complète d’outils graphiques pour visualiser et manipuler
des dépôts git est disponible sur [le site officiel de
git](https://www.git-scm.com/downloads/guis).

L’auteur de cette formation travaille essentiellement sous Linux, mais quand il
lui arrive de développer sous macOS ou Windows, il aime bien le logiciel
[Sourcetree](https://www.sourcetreeapp.com/). D’autres développeurs lui ont
aussi dit beaucoup de bien de [GitKraken](https://www.gitkraken.com/), par
contre dans ce dernier cas il faut être prêt à sortir le chéquier, car les
limitations de la version gratuite sont très restrictives.
