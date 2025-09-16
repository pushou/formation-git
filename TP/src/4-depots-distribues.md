# <a href="Pres4-Distribution.pdf" target="blank">Dépôts distribués</a>

## Retour à l’état attendu

Pour ce quatrième TP, le script bash à exécuter pour archiver votre travail sur
le troisième TP et repartir de l’[archive de référence](TP4.zip) est :

```bash
{{#include 4-depots-distribues.sh:restore-from-zip}}
```


## Premiers pas avec les dépôts distants

### Clonage de dépôt

Le travail distribué avec git commence souvent par le clonage d’un dépôt
existant. Comme son nom ne l’indique pas, un clone n’est pas une copie parfaite
d’un dépôt git comme on pourrait en créer avec un copier-coller. Il ne reprend
que les éléments suivants du dépôt source :

- Les commits et étiquettes du dépôt d’origine
- Ses branches, qui ne sont pas reprises en l’état mais remplacées par des
  copies en lecture seule avec un nom un peu différent, à l’exception de…
- …sa branche active, dont une version locale est créée au sein du clone. Un
  lien est aussi créé entre cette branche locale et son homologue distant pour
  faciliter les échanges de commits.

Parmi les éléments qui ne seront **pas** recopiés dans le clone, on peut
mentionner le répertoire de travail, l’index, les connexions éventuelles du
dépôt cloné à d’autres dépôts distants, ou la configuration de git.

Il y a aussi une chose qui est présente dans le clone mais n’existait pas dans
le dépôt d’origine, c’est un pointeur vers ledit dépôt, la _remote_ `origin`.
Celle-ci permettra de synchroniser facilement le clone avec son parent par la
suite.

Pour mettre ces concepts en pratique, commençons par créer un clone du dépôt que
nous avons manipulé lors du TP précédent :

```bash
{{#include 4-depots-distribues.sh:clone}}
```

Si vous lancez `gitg` dans les deux dépôts, et basculez l’affichage en mode
« Tous les commits », vous constaterez que l’historique du clone est identique à
celui de son parent en termes de commits (y compris au niveau des _hashes_),
mais que la structure des branches est un peu différente.

Les branches du parent sont reflétées dans le clone sous forme de « branches
distantes ». Ce sont des copies locales en lecture seule (un peu comme des
_tags_, vous pouvez faire un `checkout` dessus mais pas y ajouter des commits).
Leur nom est en `origin/<branche>`, et elles sont affichées avec une couleur
verte dans l’interface de `gitg`.

De plus, la branche active du parent a aussi été recréée sous forme de branche
locale dans le clone, et c’est cette branche-là qui est actuellement active et
extraite dans le répertoire de travail :

```bash
{{#include 4-depots-distribues.sh:status-after-clone}}
```

Notez aussi dans la sortie de `git status` qu’un lien a été créé entre cette
branche locale et la branche distante. Cela permettra par la suite de
synchroniser facilement ces deux branches avec les commandes `git push` et
`git pull`.

Vous pouvez afficher la liste des dépôts distants associés au dépôt local actuel
avec `git remote` sans arguments :

```bash
{{#include 4-depots-distribues.sh:remote}}
```

En mode verbeux, cette commande affiche aussi l’adresse du dépôt distant. Ici,
cette adresse est un chemin d’accès sur le système de fichier local :

```bash
{{#include 4-depots-distribues.sh:remote-verbose}}
```

On peut aussi afficher des informations plus détaillées sur une _remote_ avec
`git remote show` :

```bash
{{#include 4-depots-distribues.sh:remote-show}}
```

### Récupération de changements depuis le parent

Maintenant que nous avons créé un clone, retournons donc un instant dans le
dépôt parent pour créer un commit qui ajoute un nouveau fichier :

```bash
{{#include 4-depots-distribues.sh:first-remote-commit}}
```

Si vous retournez dans le clone, vous constaterez que ce changement n’est pas
visible au niveau du clone : le fichier n’est pas visible dans le répertoire de
travail…

```bash
{{#include 4-depots-distribues.sh:no-file-change-in-clone}}
```

…et il n’y a pas de différence entre la branche locale du clone et la branche
distante associée (qui, pour rappel, n’est qu’une copie en lecture seule de la
branche du dépôt cloné) :

```bash
{{#include 4-depots-distribues.sh:no-branch-change-in-clone}}
```

Comme nous en avons discuté, git n’échange avec les dépôts distants que
lorsqu’on lui demande explicitement de le faire. Pour récupérer les derniers
changements du dépôt parent, il faut en faire la demande explicitement, par
exemple avec `git fetch` :

```bash
{{#include 4-depots-distribues.sh:first-fetch}}
```

Notez que git mentionne une activité au niveau de la copie locale
`origin/univers-parallele`. À ce stade, le changement n’est toujours pas présent
dans le répertoire de travail et la branche locale…

```bash
{{#include 4-depots-distribues.sh:file-still-missing}}
```

…mais il est maintenant visible dans la branche distante :

```bash
{{#include 4-depots-distribues.sh:branch-changed-in-clone}}
```

Nous pouvons intégrer le changement à notre branche locale par une fusion. Elle
s’effectuera en avance rapide, car notre branche locale n’a pas divergé par
rapport à la branche distante :

```bash
{{#include 4-depots-distribues.sh:fast-forward-parallel-merge}}
```

### Le raccourci `git pull`

Il est très courant de vouloir se mettre à jour par rapport à une branche
distante, et `git` fournit donc des raccourcis pour accélérer cette opération.

Le raccourci `git pull <remote> <branche>` est équivalent à une séquence de deux
commandes :

- `git fetch <remote> <branche>`, une variante de `git fetch` qui ne met à jour
  qu’une seule branche distante, et peut donc être plus rapide à s’exécuter.
- `git merge <remote>/<branche>`, vue au TP 3, qui intègre les changements de la
  branche distante que l’on vient de récupérer à la branche active.

Cela divise par deux la quantité de texte que l’on doit saisir pour effectuer
cette opération courante efficacement, ce qui est déjà appréciable. Et nous
verrons dans un instant qu’il est possible de raccourcir encore…

Mais d’abord, effectuons un commit dans le dépôt parent pour tester `git pull`.

```bash
{{#include 4-depots-distribues.sh:first-pull}}
```

`git pull` accepte en paramètre les mêmes options que `git merge`, il est donc
notamment possible de lui indiquer qu’on ne souhaite fusionner que s’il n’y a
pas eu de divergence (`git pull --ff-only`), ou au contraire qu’on souhaite
créer un commit de fusion même si git pourrait s’en passer (`git pull --no-ff`).

<div class="warning">

  Comme `git pull` fait (notamment) appel à `git merge`, cette commande modifie
  le répertoire de travail. Il est donc recommandé de vérifier que le répertoire
  de travail est propre avec `git status` avant de l’utiliser.

</div>

### Notion de branche amont

Il est courant d’avoir dans son dépôt `git` local une branche qui a un
« homologue distant » :

- Pour soumettre un développement au projet, on va commencer par mettre en ligne
  une copie de la branche locale associée à ce développement, ce qui permettra
  par la suite d’en discuter avec les collègues. Nous étudierons ce processus
  plus en détail au TP 5.
- À l’inverse, il peut être intéressant d’effectuer un suivi local d’une branche
  existant sur un serveur distant, par exemple la branche qui représente la
  version de développement officielle du projet (généralement appelée `main`,
  `master` ou `develop`).

Pour nous aider à maintenir ces versions locales et distantes d’une branche
synchrones, git fournit la notion de branche amont (_upstream branch_). Ce
concept nous permet d’expliquer à `git` qu’il existe un lien entre une branche
locale et une branche distante sur une _remote_.

Une fois ce lien enregistré, on disposera de formes raccourcies des commandes de
synchronisation. Par exemple, `git pull` sans argument supplémentaire
récupérera la version actuelle de la branche amont associée au sein de la
branche active et la fusionnera au sein de celle-ci.

Alors, comment mémoriser ce lien entre branche locale et branche amont ?

Tout d’abord, a évoqué en début de TP que lorsqu’on fait un `git clone`, git
configure automatiquement un lien entre la branche active du dépôt qui a été
cloné et la branche locale associée dans le dépôt cloné. C’est indiqué dans la
première ligne de `git status` :

```bash
{{#include 4-depots-distribues.sh:status-after-pull}}
```

Un autre raccourci bien pratique pour créer une branche locale connectée à une
branche distante est de demander un `checkout` d’une branche locale qui n’existe
pas encore, mais dont un homologue distant existe :

```bash
{{#include 4-depots-distribues.sh:checkout-nonexistent-main}}
```

Quand on exécute cette commande, git commence par chercher une branche locale
`main`, et constate qu’il n’en existe pas, mais qu’il existe une branche
distante du même nom, `origin/main`. Il crée alors une branche locale `main`
à l’emplacement actuel de cette branche distante, et configure la branche
distante `origin/main` comme amont de la branche locale `main`.

On peut visualiser les branches distantes paramétrées comme branches amont des
branches locales avec le mode très verbeux de `git branch --list` :

```bash
{{#include 4-depots-distribues.sh:very-verbose-branch}}
```

Dans les rares cas où il est nécessaire de configurer manuellement l’amont d’une
branche locale, la commande `git branch` fournit des moyens de le faire. Sur les
versions actuelles de `git`, on utilise la syntaxe
`git branch --set-upstream-to <remote>/<branche>`. Mais des versions très
anciennes de git utilisaient une syntaxe différente. Si vous êtes amené un jour
à utiliser ces versions, consultez `git help branch` pour plus de détails.

### Soumission de changements avec `git push`

De la même façon qu’il est possible de se synchroniser avec les branches et
commits d’un dépôt distant avec `git fetch` et `git pull`, il est possible de
transmettre des informations en sens inverse et d’ajouter des modifications à un
dépôt distant avec `git push`.

Comme `git pull`, et contrairement à `git fetch`, `git push` est normalement
utilisé pour travailler sur une branche ou une étiquette à la fois. On ne
cherche généralement pas à modifier toutes les branches du dépôt distant, mais
seulement celle sur laquelle on est en train de travailler. Cela rejoint un
grand principe de la gestion de version distribuée, qui est qu’une
synchronisation locale est en général préférable à une synchronisation globale.

La forme la plus explicite de `git push` prend en paramètre une _remote_ et une
référence (étiquette ou branche), puis essaie de créer une version distante de
cette référence, ou de la mettre à jour si elle existe déjà :

```bash
{{#include 4-depots-distribues.sh:push-remote-branch}}
```

En l’occurrence, il ne se passe rien, puisque nous n’avons pas modifié la branche
`main` depuis la dernière fois que nous nous sommes synchronisés avec le
dépôt `origin`.

Il est courant de vouloir pousser la branche active. Un premier raccourci de
`git push` consiste donc à ne préciser que la _remote_ cible. C’est alors la
branche active qui sera soumise à cette _remote_.

```bash
{{#include 4-depots-distribues.sh:push-remote}}
```

Dans le dépôt parent, on peut voir que les nouveaux commits ont été propagés par
`git push` :

```bash
{{#include 4-depots-distribues.sh:log-after-first-pushes}}
```

Enfin, la forme la plus concise de `git push` ne précise même pas la _remote_
cible. Celle-ci est alors déduite de la branche amont associée à la branche
active.

```bash
{{#include 4-depots-distribues.sh:push-shorthand}}
```

Pour utiliser cette variante de `git push`, vous devez avoir défini une branche
amont associée à la branche active. Si ce n’est pas déjà fait, un raccourci
existe pour configurer une branche amont et pousser vers cette dernière : la
commande `git push --set-upstream <remote> <branche>`, l’option `--set-upstream`
pouvant s’abrévier en `-u`.

Si vous utilisez une version récente de git (>=2.37.0), vous pouvez aussi
configurer `git push` pour effectuer automatiquement cette configuration dans la
majorité des cas (pas d’ambiguïté sur le dépôt cible) :

```bash
{{#include 4-depots-distribues.sh:push-auto-setup-remote}}
```

<div class="warning">

  Lorsqu’on utilise des clones locaux d’un dépôt git normal, comme c’est le cas
  dans ce TP, on ne peut pas faire de `git push` vers la branche qui est
  actuellement active dans le dépôt cible. En cas de besoin, il faut donc aller
  dans le dossier du dépôt cible et faire un `git checkout` d’une autre branche.

  Vous ne rencontrerez heureusement que rarement ce problème dans la vie de tous
  les jours. Les clones locaux sont peu utilisés, et la seule raison pour
  laquelle cette formation y a recours est que cela vous permet de mieux
  visualiser ce qui se passe et vous évite de devoir apprendre la gestion des
  _remotes_ et celle des échanges réseau en même temps…

</div>


## Aller plus loin avec les _remotes_

### Dépôts distants multiples

Rien n’interdit de travailler avec plusieurs _remotes_ à la fois, et cela
s’avérera très utile pour certaines pratiques de gestion de version distribuée
que nous étudierons dans la suite de cette formation.

Créons donc un deuxième clone de notre dépôt parent, et ajoutons une _remote_
qui pointe vers celui-ci avec `git remote add` :

```bash
{{#include 4-depots-distribues.sh:new-clone-and-add-remote}}
```

Notons qu’ajouter une _remote_ ne déclenche pas d’échanges immédiats. Il faut
utiliser `git fetch` pour récupérer le contenu actuel de la nouvelle _remote_.
Introduisons à l’occasion une variante de `git fetch` bien pratique quand on
travaille avec plusieurs dépôts distants qui permet de récupérer les nouveautés
de toutes les _remotes_ à la fois :

```bash
{{#include 4-depots-distribues.sh:fetch-all}}
```

Vous noterez dans la sortie de `git fetch` qu’il n’y a qu’une branche distante
`autre/univers-parallele`, et pas de branche `autre/main`. Cela s’explique de
la façon suivante :

- `git clone` ne crée qu’une seule branche locale, correspondant à la branche
  active du dépôt qui a été cloné. Les autres branches du dépôt source ne sont
  représentées que par des branches distantes en lecture seule.
- `git fetch` ne prend en compte que les branches locales du dépôt auquel on est
  connecté, pas ses branches distantes. Dit autrement, les _remotes_ de nos
  _remotes_ ne sont pas prises en compte par `git fetch`.

### `git pull` et `git push` face à la divergence

Même si `git push` et `git pull` sans arguments procèdent d’une logique très
similaire (mettre à jour la branche amont par rapport à la branche locale, ou la
branche locale par rapport à la branche amont), il y a une grande différence
conceptuelle entre ces deux commandes : `git pull` tolère une divergence de la
branche locale par rapport à la branche amont, alors que `git push` le rejette.

Mettons-le en évidence en créant une petite divergence d’historique :

```bash
{{#include 4-depots-distribues.sh:divergence-before-pull}}
```

Après ces commandes, `MonAutreClone` et `MesBranches` contiennent un commit sur
leur branche `main` qui n’est pas présent au sein de la branche `main` de
`MonClone`, et `MonClone` contient un commit sur sa branche `main` qui n’est
pas présent au sein de la branche `main` des deux autres dépôts. On est donc
bien dans un scénario classique de divergence d’historique.

Puisque la commande `git pull` est basée sur `git merge`, elle ne va pas se
formaliser de cet état de fait, et simplement fusionner les deux historiques en
créant un commit de fusion :

```bash
{{#include 4-depots-distribues.sh:pull-merges-divergence}}
```

On peut observer l’apparition du commit de fusion correspondant dans `gitg`.

En revanche, `git push` a un comportement différent. Dans la même situation de
divergence, l’opération sera rejetée :

```bash
{{#include 4-depots-distribues.sh:push-rejects-divergence}}
```

Pour qu’un `git push` soit accepté, il faut que le commit qui termine la branche
locale ait pour parent celui qui termine la branche distante. Contrairement au
cas de `git pull`, il n’y a pas de fusion implicite : si on veut une fusion, il
faut la faire nous-mêmes avant de pousser.

### Importance des méthodes de travail (_workflows_)

Les ennuis liés à la divergence ne s’arrêtent pas là. Même avec `git pull` et sa
fusion implicite, nous pouvons avoir des soucis si la fusion se passe mal. Pour
nous en convaincre, aggravons notre divergence par un conflit de fusion :

```bash
{{#include 4-depots-distribues.sh:pull-conflict}}
```

De tels conflits sont désagréables à gérer, puisque l’on doit arbitrer entre
différentes versions d’une même branche, qu’on ne peut plus synchroniser tant
que le conflit n’est pas résolu.

Et malheureusement, sur un projet distribué suffisamment gros, on ne peut pas
empêcher que ce genre de chose arrive si tout le monde est autorisé à travailler
librement sur toutes les branches.

Des méthodes de travail ont donc été développées pour éviter ce genre d’accident.
Elles visent notamment à éviter les divergences d’historique entre versions
locales et distantes d’une même branche. Nous présenterons une de ces méthodes
en détail par la suite, mais mentionnons préalablement quelques principes que
toutes les méthodes ont en commun :

1. À tout instant, une seule personne ou machine doit être responsable d’écrire
   sur une branche, les autres ne pouvant que lire l’état de celle-ci.
2. S’il est possible que d’autres personnes lisent le contenu d’une branche, la
   personne qui modifie celle-ci doit s’abstenir d’effectuer toute modification
   d’historique qui pourrait créer des divergences avec ces clients, comme par
   exemple pousser une branche après un `git rebase`.

La restriction de `git push` décrite ci-dessus permet d’aller dans le sens de ce
second objectif, puisqu’elle évite à une divergence locale de se propager sur le
dépôt distant, qui est potentiellement partagé avec autrui.

Si l’on souhaite imposer une discipline similaire à `git pull` afin d’éviter des
fusions incorrectes, on peut le faire en utilisant systématiquement
`git pull --ff-only`. Sur les versions actuelles de git, il est possible
d’obtenir ce comportement sans devoir spécifier l’option `--ff-only` à
répétition en utilisant l’option `pull.ff`:

```bash
{{#include 4-depots-distribues.sh:config-pull-ff-only}}
```


## Conclusion

Dans ce TP, nous avons vu comment git, en tant que gestionnaire de versions
distribué, est capable de gérer des communications entre plusieurs dépôts, sans
qu’il y ait besoin de communiquer à chaque opération.

Il est intéressant de mettre en parallèle la relative simplicité du vocabulaire
de commandes utilisé avec la complexité conceptuelle conséquente qu’ajoute la
synchronisation de dépôts distribués.

Nous conclurons cette formation en montrant comment l’utilisation de quelques
outils supplémentaires, couplés avec des méthodes de travail adaptées, permet de
mater cette complexité.


----

## Exercices

1. Créez un clone du dépôt `MonDepot` que vous avez utilisé au TP1 et au TP2
2. Comparez le contenu du clone à celui de dépôt original avec `ls -al` et
   `gitg`. Comprenez-vous toutes les différences observées ?
3. Créez une branche `test` au sein de `MonDepot` et ajoutez-y quelques commits.
4. Récupérez la branche `test` dans le clone, créez-en une version locale et
   basculez dessus.
5. Ajoutez quelques commits sur `test` au sein du clone.
6. Ajoutez le clone comme _remote_ de `MonDepot`, puis mettez à jour la branche
   `test` de `MonDepot` par rapport aux nouveaux commits du clone.
7. Basculez sur la branche `main` de `MonDepot` et créez-y quelques commits.
8. Propagez ces changements sur la branche `main` du clone, sans quitter le
   dépôt `MonDepot`.
9. Rendez-vous maintenant dans le clone, et fusionnez les nouveautés de la
   branche `main` de `MonDepot` au sein de la branche `test` du clone.

## Antisèche

Créer un clone d’un dépôt :

```bash
{{#include 4-depots-distribues.sh:cheatsheet-clone}}
```

Afficher les dépôts distants (_remotes_) et les chemins associés :

```bash
{{#include 4-depots-distribues.sh:remote-verbose}}
```

Afficher des informations détaillées sur une _remote_ :

```bash
{{#include 4-depots-distribues.sh:cheatsheet-remote-show}}
```

Ajouter une _remote_ au dépôt :

```bash
{{#include 4-depots-distribues.sh:cheatsheet-remote-add}}
```

Récupérer les changements d’une _remote_ :

```bash
{{#include 4-depots-distribues.sh:cheatsheet-fetch-remote}}
```

Récupérer les changements de toutes les _remotes_ :

```bash
{{#include 4-depots-distribues.sh:fetch-all}}
```

Mettre à jour une branche distante puis la fusionner dans la branche active :

```bash
{{#include 4-depots-distribues.sh:cheatsheet-explicit-pull}}
```

Récupérer et fusionner les changements de l’amont de la branche active :

```bash
{{#include 4-depots-distribues.sh:implicit-pull}}
```

…sauf s’il y a eu divergence entre la branche locale et la branche distante :

```bash
{{#include 4-depots-distribues.sh:cheatsheet-implicit-pull-ff-only}}
```

Configurer `git` pour appliquer le fonctionnement ci-dessus par défaut :

```bash
{{#include 4-depots-distribues.sh:config-pull-ff-only}}
```

Créer ou mettre à jour des branches et/ou étiquettes sur une _remote_ :

```bash
{{#include 4-depots-distribues.sh:cheatsheet-explicit-push}}
```

Pousser une branche en marquant la branche distante comme branche amont :

```bash
{{#include 4-depots-distribues.sh:cheatsheet-push-set-upstream}}
```

Créer ou mettre à jour l’homologue distant de la branche active sur une _remote_ :

```bash
{{#include 4-depots-distribues.sh:cheatsheet-push-by-remote}}
```

Mettre à jour la branche amont associée à la branche active :

```bash
{{#include 4-depots-distribues.sh:push-shorthand-only}}
```

Afficher les branches amont associées aux branches locales du dépôt :

```bash
{{#include 4-depots-distribues.sh:very-verbose-branch}}
```


---

## Informations complémentaires

### Forcer la mise à jour d’une référence distante

Certaines méthodes de travail couramment utilisées avec git requièrent de
modifier l’historique d’un dépôt distant. Par exemple, il existe des projets qui
exigent que toute soumission de modifications soit basée sur la version de
développement actuelle, ou que l’historique des modifications soit simplifié
pour en faciliter le passage en revue.

Toutes ces modifications impliquent l’utilisation de `rebase`, et donc la
création d’un historique local qui diverge de la version distante d’une branche.
Si vous tentez d’appliquer ces méthodes, vous constaterez donc que `git push`
rejette vos soumissions, en raison du risque de perdre des commits de
l’historique et/ou de perturber des collègues qui auraient construit du travail
par-dessus les versions distantes de vos branches que vous avez poussées
précédemment.

Il est possible, dans les cas comme celui décrit ci-dessus, de passer outre et
forcer `git push` à accepter la soumission, détruisant ce faisant la version
distante précédente de la branche :

```bash
{{#include 4-depots-distribues.sh:force-push}}
```

Notez que quand on utilise un dépôt distant sur une forge, l’administrateur de
ce dépôt peut interdire cette opération dangereuse pour éviter des pertes de
données. Dans ce cas, il vous faudra négocier ou trouver une autre solution.

### Détruire une branche distante

Lorsqu’on a fini de travailler sur une branche distante, par exemple parce
qu’elle a été intégrée à la version officielle du projet, il est d’usage de
détruire celle-ci. Cela évite une prolifération des branches inactives qui peut
rendre l’historique d’un dépôt incompréhensible.

Sur les versions modernes de git, on peut le faire en utilisant
`git push --delete`…

```bash
{{#include 4-depots-distribues.sh:push-delete}}
```

…et sur les anciennes versions de git, il fallait utiliser son prédécesseur plus
mystérieux (relevant d’une logique inutilement obscure), le signe « : ».

```bash
{{#include 4-depots-distribues.sh:push-delete-legacy}}
```

Bien entendu, comme avec `--force`, il est préférable de n’effectuer cette
opération que lorsqu’on est sûr qu’aucun collaborateur n’est actuellement en
train de travailler par-dessus la branche qui est sur le point d’être supprimée.

<div class="warning">

  Un point important à retenir concernant les suppressions est que par défaut,
  `git fetch` ne détruit pas les étiquettes et copies locales des branches
  distantes qui n’existent plus sur le dépôt interrogé. Pour obtenir ce
  résultat, il faut utiliser l’option `--prune` :
  
  ```bash
  {{#include 4-depots-distribues.sh:fetch-prune}}
  ```
  
  Cette logique vise à assurer que `git fetch` soit une commande 100 % sûre, qui
  ne peut pas détruire de données en local même quand les autres utilisateurs du
  dépôt distant ont fait des erreurs. Mais elle rend la notion de « branche
  distante » moins intuitive, puisqu’on doit plus souvent garder en tête que ce
  que git présente comme une branche distante est en réalité une copie locale
  d’une branche sur un dépôt distant, qui est sujette à se désynchroniser à la
  moindre suppression.
  
  On peut donc trouver plus ergonomique de rendre l’utilisation de `--prune`
  automatique avec le paramètre de configuration `fetch.prune` :
  
  ```bash
  {{#include 4-depots-distribues.sh:config-fetch-prune}}
  ```

</div>

### Branches, étiquettes, et références

Dans ce TP, j’ai principalement parlé de branches. Cependant, il est possible de
pousser des étiquettes (_tags_) en utilisant exactement la même syntaxe.

```bash
{{#include 4-depots-distribues.sh:push-tag}}
```

Les étiquettes sont couramment utilisées pour représenter des versions
publiées d’un projet. Par exemple, dans un projet logiciel, on utilise
couramment des étiquettes « v1.0 », « v1.1 », « v2.0 »… qui correspondent aux
versions stables.

La notion d’étiquette annotée, que nous avions brièvement décrite précédemment,
permet dans ce contexte d’ajouter des notes de version qui décrivent les
nouveautés de chaque version publiée par rapport à la précédente.

Il existe également un raccourci `git push --tags` qui permet de pousser sur un
dépôt distant l’ensemble des étiquettes locales. Ce raccourci est à utiliser
avec prudence : toutes les étiquettes que vous créez n’ont pas forcément
vocation à être publiées…
