# Corrigés des exercices

## Introduction

Au fil des divers TPs, des exercices vous ont été proposés pour tester votre
compréhension des concepts abordés. Dans cette annexe, nous allons discuter une
solution possible à chacun de ces exercices. Notez que la plupart des exercices
ont plusieurs solutions valides.


## Exercices TP1

Pour créer un dépôt git, il suffit d’utiliser la commande `git init` au sein
d’une arborescence de fichiers. On peut le faire au sein d’un dossier existant,
ou bien créer un nouveau dossier pour le dépôt comme on l’a fait pendant le TP :

```bash
{{#include 1-premiers-pas-corrige.sh:create-repo}}
```

Dans le monde du shell Unix, on désigne les fichiers portant l’extension « .o » par
la syntaxe `*.o` qui signifie « tout fichier ou dossier dont le nom se termine
par .o ». On peut, en utilisant cette syntaxe, dire à git d’ignorer les fichiers
portant cette extension via le fichier spécial `.gitignore` :

```bash
{{#include 1-premiers-pas-corrige.sh:ignore-objects}}
```

Maintenant, créons un fichier :

```bash
{{#include 1-premiers-pas-corrige.sh:create-file}}
```

On peut indiquer à git qu’on souhaite versionner ce fichier avec la commande
`git add`. Ce fichier sera alors inclus dans toutes les versions de
l’arborescence enregistrées ultérieurement. Nous verrons comment on enregistre
des versions de l’arborescence au TP2.

```bash
{{#include 1-premiers-pas-corrige.sh:add-changes-for-commit}}
```

Pour déplacer un fichier en informant git de l’opération, on peut utiliser la
commande `git mv` :

```bash
{{#include 1-premiers-pas-corrige.sh:git-mv-example}}
```

Si l’on regarde la sortie de `git status`…

```bash
{{#include 1-premiers-pas-corrige.sh:final-git-status}}
```

…on obtient la sortie suivante dans le terminal :

> ```text
> Sur la branche main
> 
> Aucun commit
> 
> Modifications qui seront validées :
>   (utilisez "git rm --cached <fichier>..." pour désindexer)
>         nouveau fichier : AutreTest.txt
> 
> Fichiers non suivis:
>   (utilisez "git add <fichier>..." pour inclure dans ce qui sera validé)
>         .gitignore
> ```

On y trouve, outre l’information de branche actuelle qu’on choisit d’ignorer
pour l’instant, les informations suivantes :

- Aucune version n’a été enregistrée pour l’instant.
- Si l’on enregistrait notre première version maintenant, le fichier
  `AutreTest.txt` en ferait partie, mais pas le fichier `.gitignore`.


## Exercices TP2

La procédure pour créer un dépôt git vide est la même que précédemment :

```bash
{{#include 2-historique-lineaire-corrige.sh:create-repo}}
```

Ajoutons-y un peu de contenu :

```bash
{{#include 2-historique-lineaire-corrige.sh:create-files}}
```

On indique à git qu’on souhaite versionner des fichiers avec `git add`.
Lorsqu’on souhaite demander à git de sauvegarder tous les fichiers du dépôt, un
raccourci pratique est l’option `--all` :

```bash
{{#include 2-historique-lineaire-corrige.sh:add-all-files}}
```

Ensuite, on peut créer un commit contenant tous ces fichiers avec `git commit` :

```bash
{{#include 2-historique-lineaire-corrige.sh:create-first-commit}}
```

Maintenant, modifions deux fichiers…

```bash
{{#include 2-historique-lineaire-corrige.sh:edit-two-files}}
```

Si l’on souhaite créer un commit qui ne contient que les modifications d’un seul
fichier, il suffit de n’appliquer `git add` qu’à celui-ci :

```bash
{{#include 2-historique-lineaire-corrige.sh:commit-only-one-file}}
```

Du coup, il reste des modifications non sauvegardées à l’autre fichier, comme on
peut le voir dans la sortie de `git status` :

```bash
{{#include 2-historique-lineaire-corrige.sh:status-after-partial-commit}}
```

Comme ce fichier est sous gestion de version, on peut visualiser ses
modifications non sauvegardées avec `git diff` :

```bash
{{#include 2-historique-lineaire-corrige.sh:diff-after-partial-commit}}
```

Pour créer un commit comprenant toutes les modifications non sauvegardées, on a
plusieurs possibilités. Nous avons déjà vu `git add --all`, ici nous sommes
aussi dans le cas particulier où tous les fichiers sont sous gestion de version
et on peut utiliser `git commit -a` en toute sécurité :

```bash
{{#include 2-historique-lineaire-corrige.sh:commit-the-rest}}
```

À ce stade, nous avons créé trois commits dans le dépôt. Le plus récemment créé
peut être désigné par `HEAD`, son prédécesseur par `HEAD~`, et le commit
précédent, qui est le premier commit de l’historique, par `HEAD~2`.

Nous pouvons donc afficher la différence entre les deux premiers commits de
l’historique avec la commande…

```bash
{{#include 2-historique-lineaire-corrige.sh:diff-grandparent-to-parent}}
```

Le répertoire de travail est-il bien propre ? Demandons à `git status` :

```bash
{{#include 2-historique-lineaire-corrige.sh:status-before-checkout}}
```

On obtient en réponse la sortie suivante :

> ```text
> Sur la branche main
> rien à valider, la copie de travail est propre
> ```

Le répertoire de travail (traduit en copie de travail dans cette version de git)
est donc propre, et on peut donc partir en voyage dans les versions historiques
de l’arborescence, par exemple en visitant le grand-parent du commit actuel,
`HEAD~2` :

```bash
{{#include 2-historique-lineaire-corrige.sh:checkout-grandparent}}
```

Si, durant notre visite, on se rend compte qu’on pourrait avoir besoin de
revenir sur ce commit ultérieurement, il peut être judicieux d’y attacher une
étiquette avec la commande `git tag` :

```bash
{{#include 2-historique-lineaire-corrige.sh:tag-grandparent}}
```

On peut revenir sur la branche `main` avec la commande `git checkout` :

```bash
{{#include 2-historique-lineaire-corrige.sh:back-to-main}}
```


## Exercices TP3

Un dépôt git est un dossier comme les autres, on peut en créer une copie avec
une copie récursive :

```bash
{{#include 3-manipulation-branches-corrige.sh:copy-repo}}
```

Le parent du commit actif est désigné par la syntaxe `HEAD~`, et on peut le
visiter avec la commande `git checkout` :

```bash
{{#include 3-manipulation-branches-corrige.sh:checkout-parent}}
```

Ensuite, on peut créer une branche qui en part avec `git branch` :

```bash
{{#include 3-manipulation-branches-corrige.sh:create-branch}}
```

Et on peut basculer sur cette branche avec `git checkout` :

```bash
{{#include 3-manipulation-branches-corrige.sh:switch-to-branch}}
```

Pour créer un commit ajoutant un nouveau fichier, on crée le fichier, puis on le
l’ajoute à l’index avec `git add`, et on crée le commit avec `git commit` :

```bash
{{#include 3-manipulation-branches-corrige.sh:first-commit}}
```

On peut ensuite visualiser la branche `main` et la branche que l’on vient de
créer en lançant `gitg` dans le dépôt…

```bash
{{#include 3-manipulation-branches-corrige.sh:visualize-with-gitg}}
```

…ou en rafraîchissant son affichage avec Ctrl+R s’il est déjà ouvert. N’oubliez
pas de sélectionner l’option « Branches » ou l’option « All commits » dans le
menu de droite pour pouvoir visualiser les deux branches simultanément.

Notre branche a un peu de retard avec la branche `main`, nous pouvons rattraper
ce retard en y fusionnant les nouveautés de la branche `main` avec `git merge` :

```bash
{{#include 3-manipulation-branches-corrige.sh:auto-merge-main}}
```

Maintenant, remplaçons le contenu d’un fichier au sein de la branche active…

```bash
{{#include 3-manipulation-branches-corrige.sh:edit-on-secondary-branch}}
```

…et au sein de la branche `main`, en basculant sur celle-ci :

```bash
{{#include 3-manipulation-branches-corrige.sh:conflicting-edit-on-main-branch}}
```

Si l’on essaye de fusionner nouvelle-branche au sein de `main` avec `git merge`,
il y aura conflit au niveau de ce fichier :

```bash
{{#include 3-manipulation-branches-corrige.sh:conflicting-secondary-merge}}
```

…comme indiqué par le message d’erreur suivant :

> ```text
> CONFLIT (ajout/ajout) : Conflit de fusion dans LeFichier.txt
> Fusion automatique de LeFichier.txt
> La fusion automatique a échoué ; réglez les conflits et validez le résultat.
> ```

On peut résoudre ce conflit de plusieurs façons, l’approche préconisée dans
cette formation est l’utilisation d’un outil de visualisation tel que Meld :

```bash
{{#include 3-manipulation-branches-corrige.sh:resolve-conflict-with-meld}}
```

Au sein de l’interface de Meld, double-cliquez sur le fichier conflictuel, qui
apparaît en rouge dans l’interface, puis résolvez le conflit en choisissant la
version « de gauche », la version « de droite », ou en écrivant une version de votre
cru qui vous semble réunir les meilleures idées de chacune.

Après avoir quitté Meld en sauvegardant vos changements et en validant la
résolution du conflit, vous pourrez terminer la fusion avec
`git merge --continue` ou `git commit` :

```bash
{{#include 3-manipulation-branches-corrige.sh:commit-conflict-resolution}}
```


## Exercices TP4

Pour cloner un dépôt, on utilise la commande `git clone` :

```bash
{{#include 4-depots-distribues-corrige.sh:clone-repo}}
```

Si l’on compare le contenu de l’original et du dépôt du point de vue du
répertoire de travail, en lançant la commande `ls -al` d’abord sur le dépôt
original…

```bash
{{#include 4-depots-distribues-corrige.sh:ls-origin}}
```

…avec la sortie suivante…

> ```text
> total 28
> drwxr-xr-x 4 hadrien users 4096 19 nov.   2018 .
> drwxr-xr-x 8 hadrien users 4096 18 sept. 16:44 ..
> -rw-r--r-- 1 hadrien users   19 19 nov.   2018 AutreContenu.txt
> drwxr-xr-x 8 hadrien users 4096 19 nov.   2018 .git
> -rw-r--r-- 1 hadrien users    6 19 nov.   2018 .gitignore
> drwxr-xr-x 2 hadrien users 4096 19 nov.   2018 MonDossier
> -rw-r--r-- 1 hadrien users   44 19 nov.   2018 Poubelle.log
> ```

…puis sur le clone…

```bash
{{#include 4-depots-distribues-corrige.sh:ls-clone}}
```

…avec la sortie suivante…

> ```text
> total 20
> drwxr-xr-x 3 hadrien users 4096 18 sept. 16:44 .
> drwxr-xr-x 8 hadrien users 4096 18 sept. 16:44 ..
> -rw-r--r-- 1 hadrien users   19 18 sept. 16:44 AutreContenu.txt
> drwxr-xr-x 8 hadrien users 4096 18 sept. 16:44 .git
> -rw-r--r-- 1 hadrien users    6 18 sept. 16:44 .gitignore
> ```

…on observe que le dossier `MonDossier` et le fichier `Poubelle.log` ne sont pas
présents dans le clone.

Ces différences s’expliquent par le fait que le répertoire de travail d’un clone
n’est pas une copie à l’identique de celui du dépôt d’origine, mais représente
plutôt une copie du dernier _commit_ enregistré dans le dépôt d’origine.

Ce _commit_ ne contenait pas le dossier `MonDossier` puisqu’il s’agit d’un
dossier vide, non géré par git, ni le fichier `Poubelle.log` puisqu’il est
ignoré par git.

Si maintenant l’on compare les dépôts du point de vue de l’arbre de _commits_
avec `gitg`…

```bash
{{#include 4-depots-distribues-corrige.sh:visualize-and-switch-to-origin}}
```

On constate que leur structure générale est similaire mais que le clone possède
le dépôt original comme _remote_ (sous le nom par défaut `origin`), et visualise
simultanément sa version locale de la branche `main` et une copie locale de
celle du dépôt original, `origin/main`.

C’est le fait de pouvoir différentier les versions locales et distantes de
branches, comme ici `main`, qui permet d’utiliser git de façon distribuée sans
connexion permanente à internet.

Pour créer une branche en vue d’y ajouter quelques commits, on peut par exemple
utiliser le raccourci `git checkout -b` :

```bash
{{#include 4-depots-distribues-corrige.sh:create-and-fill-branch}}
```

À ce stade, le clone du dépôt n’est pas au courant de l’existence de ces commits
et de cette nouvelle branche, puisqu’avec git les échanges entre dépôts sont
déclenchés manuellement. On peut remédier à cela avec `git fetch` :

```bash
{{#include 4-depots-distribues-corrige.sh:goto-clone-and-fetch}}
```

Maintenant, le clone `Exercice4` est au courant de l’existence de la branche
`test` du dépôt `MonDepot`, qu’il représente comme la branche distante
`origin/test`. Nous pouvons en créer une version locale et basculer dessus avec
un raccourci basé sur `git checkout` :

```bash
{{#include 4-depots-distribues-corrige.sh:remote-branch-checkout-shortcut}}
```

Ensuite, nous pouvons rajouter des commits à cette branche locale, comme nous le
ferions sur n’importe quelle autre branche locale :

```bash
{{#include 4-depots-distribues-corrige.sh:add-more-commits-to-branch}}
```

Pour récupérer ces changements dans le dépôt d’origine, une façon de faire est
d’ajouter notre clone comme _remote_ de ce dernier…

```bash
{{#include 4-depots-distribues-corrige.sh:goto-origin-and-make-clone-remote}}
```

…puis récupérer les changements de sa branche `test` et les intégrer au sein
de notre branche test locale avec, par exemple, le raccourci `git pull` :

```bash
{{#include 4-depots-distribues-corrige.sh:pull-branch-from-clone}}
```

Pour terminer, ajoutons quelques commits sur la branche `main` de `MonDepot` :

```bash
{{#include 4-depots-distribues-corrige.sh:checkout-main-and-add-commits}}
```

On peut propager ces changements sur le `main` de `Exercice4` avec un
simple `git push` :

```bash
{{#include 4-depots-distribues-corrige.sh:push-branch-to-clone}}
```

Si l’on souhaite intégrer les changements correspondants à la branche `test` du
clone, il faudra comme précédemment s’y rendre, récupérer les changements, et
les fusionner. Faisons cela avec `git fetch` et `git merge` :

```bash
{{#include 4-depots-distribues-corrige.sh:merge-origin-main-to-clone-test}}
```


## Exercices partie 2

En raison de la nature interactive et ouverte de la partie 2 sur les forges,
nous ne fournissons pas de correction pour les exercices de cette partie.

En revanche les dépôts de recettes de cuisine auxquels vous contribuez
initialement ([version GitHub](https://github.com/hadrienG2/recettes) et
[version GitLab](https://gitlab.in2p3.fr/git-kitchen/recettes)) visent à vous
fournir un exemple des différentes techniques enseignées durant cette formation,
notamment pour l'intégration continue et la gestion des permissions utilisateur.

N'hésitez pas à demander aux formateurs une explication de leur fonctionnement
sous le capot !
