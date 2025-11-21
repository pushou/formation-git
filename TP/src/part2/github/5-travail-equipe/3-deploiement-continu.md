# Déploiement continu du livre de recettes

Avoir un livre de cuisine numérique, c’est bien. Le rendre agréable à consulter
et accessible en ligne, c’est encore mieux.

Dans cette partie, nous allons compléter le _workflow_ de détection automatique
de faute de français que votre chef cuisinier a introduit dans le chapitre
[« Intégration Continue »](../4-depot-personnel/3-integration-continue.md) avec
un deuxième _workflow_ de déploiement continu (_Continuous Deployment_ ou CD).
Grâce à _GitHub Pages_, vous pourrez héberger un [site web
statique](https://fr.wikipedia.org/wiki/Page_web_statique) directement depuis
votre dépôt GitHub et ainsi transformer vos fichiers Markdown en un véritable
livre de recettes en ligne.


## Coordination d’équipe

Avant de commencer à modifier le dépôt collaboratif, prenez un moment pour lire
le TP et discuter de ce qu'il faut faire avec votre brigade. En particulier,
posez-vous la question de :

- Qui prépare les tickets ?
- Qui gère ou modifie les _workflows_ ?
- Qui modifie ou corrige les recettes ?
- Qui valide les _pull requests_ avant leur intégration dans `main` ?

Utilisez les tickets pour suivre les tâches à réaliser et l’avancement du
projet. N’oubliez pas de toujours travailler sur une branche dédiée.


## Générer et publier le site web

### Création du _workflow_

Le déploiement continu n’est en fait rien d'autre qu’un cas particulier
d’intégration continue. Notre objectif ici va être d’utiliser le système
d’intégration continue GitHub Actions, précédemment introduit dans le chapitre
[« Intégration continue »](../4-depot-personnel/3-integration-continue.md), pour
transformer nos recettes markdown en site statique puis mettre en ligne ce site
statique comme site page web officielle du projet.

Nous vous conseillons comme toujours de faire ce travail sur une branche
dédiée, qui part de la dernière version de la branche `main` du dépôt officiel :

```bash
git checkout main
git pull
git checkout -b continuous-deployment
```

Comme précédemment, la première étape va être de créer un fichier texte pour
héberger le nouveau _workflow_ à l'intérieur du dossier caché 
`.github/workflows` à la racine du dépôt.

Nous vous proposons d’appeler ce fichier `pages.yml`, mais son nom n’a pas
d’importance du moment qu’il s’appelle autrement que le fichier contenant le
_workflow_ de vérification des fautes de français. Créez ce fichier de la façon
que vous préférez, ouvrez-le avec votre éditeur de texte favori, puis nous
allons comme précédemment le décortiquer point par point pour expliquer sa
logique.

D'abord, on va donner un nom à notre nouveau _workflow_, décrire quels
événements déclenchent son exécution, et préparer une liste de tâches
initialement vide :

```yaml
name: "Déploiement continu"

on: [push, pull_request]

jobs:
  # … les tâches seront décrites ici …
```

Si vous avez bien compris les chapitres précédents, cette partie de la
configuration ne devrait pas avoir de secret pour vous. Sinon n'hésitez pas à
relire le chapitre [« Intégration
continue »](../4-depot-personnel/3-integration-continue.md) et la section sur
les _pull requests_ du chapitre [« Projet commun »](2-projet-commun.md) et/ou à
poser vos questions aux formateurs.

Contrairement à notre _workflow_ précédent, qui ne comportait qu’une seule
tâche, ce _workflow_ va être composé de deux tâches, une tâche `build_pages` qui
génère le site statique et une autre tâche `deploy_pages` qui le met en ligne.
Il y a plusieurs raisons à cela :

- Les _pull requests_ issues de _forks_ n’ont pas la permission de modifier le
  site officiel sur GitHub, et ce pour une bonne raison : leurs modifications
  sont encore en cours de discussion et n’ont pas encore été approuvées par le
  chef cuisinier. On ne souhaite donc pas que la tâche de mise en ligne
  s’exécute sur les _pull requests_.
- Il est en revanche utile de conserver la tâche de construction du site
  statique même sur les _pull requests_, car cela permet aux contributeurs de
  vérifier le rendu du site sans avoir besoin de configurer le générateur de
  site statique sur leur machine, et cela permet aussi au générateur de site
  statique de signaler d’éventuels problèmes trouvés durant la traduction des
  recettes Markdown en HTML (par exemple des métadonnées incorrectes).
- Enfin, d’un point de vue de sécurité informatique, le [principe de moindre
  privilège](https://fr.wikipedia.org/wiki/Principe_de_moindre_privil%C3%A8ge)
  nous recommande de n’accorder des permissions sensibles (ici celle de modifier
  le site officiel du projet) qu’à un fragment de code aussi petit et simple que
  possible. La décomposition en deux tâches nous approche de cet idéal en nous
  évitant d’accorder cette permission au générateur de site statique qui est un
  programme relativement complexe.

### Génération du site statique

Nous allons logiquement commencer par définir la tâche `build_pages`. Comme la
tâche `grammaire_et_orthographe` que nous avons défini précédemment, celle-ci va
utiliser un conteneur Docker contenant un environnement logiciel prêt à
l’emploi. Mais ici le conteneur est encore plus clés-en-main qu’avant puisqu’il
contient déjà le générateur de site statique prêt à l'emploi, sans qu’il y ait
besoin d'installer quoi que ce soit en plus.

```yaml
jobs:
  build_pages:
    runs-on: ubuntu-latest
    container: docker://gitlab-registry.in2p3.fr/sonny.lion/astro-chef:1.1.2
    # … d'autres options vont suivre …
```

En revanche, il y a un petit ajustement de configuration à faire. Le générateur
de site statique a été conçu pour GitLab Pages, où le site statique est hébergé
par défaut à une URL de la forme `https://PROJET-xyz.gitlab.in2p3.fr/`. Mais ici
nous utilisons GitHub Pages où le site statique est hébergé à une URL de la
forme `https://UTILISATEUR.github.io/PROJET`. Et la présence de ce dossier
`PROJET` supplémentaire casse tous les chemins de fichier absolus au sein des
pages web générées si elle n'est pas signalée au générateur de site statique
avec la variable d'environnement `BASE_URL`.

Nous configurons donc cette variable d’environnement à la bonne valeur avec
l'option
[`env`](https://docs.github.com/fr/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idenv) :

```yaml
jobs:
  build_pages:
    # … options précédentes …
    env:
      # Si vous avez appelé le dépôt commun autrement que "nos-recettes",
      # ce chemin doit être modifié pour utiliser le bon nom de dépôt.
      BASE_URL: "/nos-recettes"
    # … les étapes de la tâche vont suivre …
```

Au niveau des étapes, nous allons commencer par récupérer le contenu du dépôt
git directement puisqu’il n'y a pas d’installations à effectuer au préalable…

```yaml
jobs:
  build_pages:
    # … options de la tâche …
    steps:
      - name: Check out git repository
        uses: actions/checkout@v5
      # … d'autres étapes vont suivre …
```

…puis nous allons construire le site statique, ce qui nécessite de jongler un
peu avec les fichiers car le générateur est conçu pour travailler dans un
répertoire bien précis alors que GitHub Actions est conçu pour récupérer les
fichiers de sortie à un autre endroit…

```yaml
jobs:
  build_pages:
    steps:
      # … récupération des fichiers …
      - name: Build the static website
        run: |
          # On déplace les recettes à l'endroit attendu par astro-chef
          cp -r ./recettes $APP_DIR/recettes
          # On génère les pages HTML avec astro-chef
          (cd $APP_DIR && yarn build)
          # On ramène ces pages à un endroit où le runner GitHub peut les voir
          mv $APP_DIR/dist .
      # … d'autres étapes vont suivre …
```

…et enfin nous allons émettre le résultat en sortie de la tâche avec l'action
[`upload-pages-artifact`](https://github.com/actions/upload-pages-artifact), qui
génère un artefact au format attendu par une autre action que nous allons
utiliser par la suite :

```yaml
jobs:
  build_pages:
    steps:
      # … étapes précédentes …
      - name: Generate and upload the artifact
        uses: actions/upload-pages-artifact@v4
        with:
          path: dist/
```

Ceci complète notre tâche `build_pages`, dont la définition complète est donc
ceci :

```yaml
jobs:
  build_pages:
    runs-on: ubuntu-latest
    container: docker://gitlab-registry.in2p3.fr/sonny.lion/astro-chef:1.1.2
    env:
      # Si vous avez appelé le dépôt commun autrement que "nos-recettes",
      # ce chemin doit être modifié pour utiliser le bon nom de dépôt.
      BASE_URL: "/nos-recettes"
    steps:
      - name: Check out git repository
        uses: actions/checkout@v5
      - name: Build the static website
        run: |
          # On déplace les recettes à l'endroit attendu par astro-chef
          cp -r ./recettes $APP_DIR/recettes
          # On génère les pages HTML avec astro-chef
          (cd $APP_DIR && yarn build)
          # On ramène ces pages à un endroit où le runner GitHub peut les voir
          mv $APP_DIR/dist .
      - name: Generate and upload the artifact
        uses: actions/upload-pages-artifact@v4
        with:
          path: dist/
```

### Mise en ligne

Comme annoncé précédemment, nous allons ensuite définir une deuxième tâche
`deploy_pages` dont la fonction est de mettre en ligne le site généré par
`build_pages`. Comme la précédente, cette tâche va s’exécuter sous Linux, mais
ici nous n’aurons pas besoin de conteneur Docker :

```yaml
jobs:
  # … définition de build_pages …
  deploy_pages:
    runs-on: ubuntu-latest
    # … d'autres instructions vont suivre …
```

Comme cette tâche modifie le site officiel du projet, elle ne devrait s’exécuter
que sur la branche `main`, ce qu'on peut imposer avec l’option
[`if`](https://docs.github.com/fr/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idif) :

```yaml
jobs:
  deploy_pages:
    # … sélection du système d’exploitation …
    if: ${{ github.ref == 'refs/heads/main' }}
    # … d'autres instructions vont suivre …
```

De plus, cette tâche dépend de la précédente, puisqu’elle a besoin de l’artefact
produit par cette dernière. Mais dans la logique de GitHub Actions, les tâches
sont considérées comme indépendantes et s’exécutent en parallèle par défaut. On
doit donc spécifier explicitement cette dépendance entre tâches en utilisant
l'option
[`needs`](https://docs.github.com/fr/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idneeds) :

```yaml
jobs:
  deploy_pages:
    # … options précédentes …
    needs: build_pages
    # … d'autres instructions vont suivre …
```

Ensuite, il faut ajuster les permissions de sécurité car GitHub considère la
modification du site officiel du projet comme une opération sensible que les
tâches n’ont pas le droit de faire par défaut. Nous demandons donc les
permissions requises avec l’option [`permissions`](https://docs.github.com/fr/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idpermissions) :

```yaml
jobs:
  deploy_pages:
    # … options précédentes …
    permissions:
      pages: write     # Modifier les pages du projet
      id-token: write  # S'authentifier comme tâche autorisée à le faire
    # … d'autres instructions vont suivre …
```

Nous complétons enfin les options de la tâche `deploy_pages` en indiquant à
GitHub Actions qu’elle a vocation à déployer un site statique dans
l'environnement GitHub Pages à une certaine URL. Contrairement au nom de dépôt
de `BASE_URL`, il ne sera pas nécessaire de spécifier ladite URL en dur dans le
fichier de configuration de _workflow_, car nous pouvons l’obtenir de l'action
qui effectue la mise en ligne du site via une technique que nous allons
expliquer plus loin.

```yaml
jobs:
  deploy_pages:
    # … options précédentes …
    environment:
      name: github-pages
      # Nous expliquerons cette syntaxe étrange plus loin
      url: ${{ steps.pages.outputs.page_url }}
```

Pour compléter la définition de la tâche `deploy_pages`, il ne nous reste plus
qu’à spécifier son unique étape qui met le site en ligne en utilisant l'action
[`deploy-pages`](https://github.com/actions/deploy-pages).

```yaml
jobs:
  deploy_pages:
    # … options de la tâche …
    steps:
      - name: Deploy to GitHub Pages
        id: pages
        uses: actions/deploy-pages@v4
```

Nous utilisons l’option
[`id`](https://docs.github.com/fr/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idstepsid)
pour donner à cette étape de mise en ligne un identifiant technique `pages`,
distinct du nom `name` visible dans l'interface web de GitHub. Cet identifiant
technique nous permet d’avoir accès aux résultats émis en sortie de l’action.
L’unique résultat
[`page_url`](https://github.com/actions/deploy-pages?tab=readme-ov-file#outputs-)
de l'action `deploy-pages` nous indique à quelle URL les pages sont mises en
ligne, et c'est exactement l'information dont nous avions besoin pour configurer
l'option [`environment`](https://docs.github.com/fr/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idenvironment) plus haut.

Pour rappel, nous avions indiqué dans cette section que l’URL du site va être
`${{ steps.pages.outputs.page_url }}`, ce qui se lit de la façon suivante :

- Avec la syntaxe `${{ … }}`, nous indiquons à GitHub que l’URL n’est pas
  directement spécifiée par le fichier de _workflow_ mais sera calculée durant
  chaque _run_ selon une logique à préciser.
- Entre les crochets, nous indiquons ensuite que l’URL doit être obtenue à
  partir de la sortie appelée `page_url` de l’étape dont l’identifiant technique
  est `pages`.

En mettant tout ensemble, la définition complète de notre tâche `deploy_pages`
est donc…

```yaml
jobs:
  # … définition de build_pages …
  deploy_pages:
    runs-on: ubuntu-latest
    if: ${{ github.ref == 'refs/heads/main' }}
    needs: build_pages
    permissions:
      pages: write
      id-token: write
    environment:
      name: github-pages
      url: ${{ steps.pages.outputs.page_url }}
    steps:
      - name: Deploy to GitHub Pages
        id: pages
        uses: actions/deploy-pages@v4
```

### A vous de jouer

Combinez les options de base du _workflow_ avec la définition des tâches
`build_pages` et `deploy_pages` pour obtenir une configuration complète de
déploiement continu, puis ajoutez ce fichier à votre branche de développement et
poussez celle-ci sur le dépôt adéquat.

Vous pourrez ensuite contrôler l’exécution du _workflow_ dans l’onglet
« Actions » de l’interface web de GitHub. Normalement, la tâche `build_pages`
devrait s’exécuter avec succès, et la tâche `deploy_pages` ne devrait pas
s’exécuter puisque vous ne travaillez pas sur la branche `main` qui est la seule
branche où cette tâche est autorisée à s’exécuter.

Une fois satisfait, soumettez cette branche de développement comme _pull
request_ au dépôt officiel puis faites-la intégrer à la branche `main` par le
chef cuisinier, et contrôlez une nouvelle fois le résultat dans l’onglet
« Actions » du dépôt officiel. Cette fois-ci la tâche `deploy_pages` devrait
s’exécuter avec succès.

Vous remarquerez alors l’apparition en bas à droite de la page d’accueil du
dépôt officiel d’un déploiement `github-pages` avec une coche verte, sur lequel
vous pouvez cliquer pour avoir accès à l’URL à laquelle le site a été mis en
ligne. N’hésitez pas à visiter cette URL pour contrôler que tout va bien. Mais
clairement, elle est un peu trop bien cachée dans les profondeurs de l’interface
de GitHub pour que vos visiteurs la trouvent facilement. Il est donc tentant de
terminer par une autre _pull request_ qui met cette information plus en valeur
dans le `README` du dépôt officiel !


## Conclusion

Dans ce TP, vous avez vu comment utiliser _GitHub Pages_ pour automatiser la
**génération et la publication** d’un site web statique à partir de fichiers
_Markdown_. Vous avez appris à :

- Définir un _workflow_ de déploiement continu qui sépare bien les tâches de
  génération et mise en ligne du site.
- Générer un site web statique grâce au générateur _Astro_ ;
- Déployer automatiquement ce site via _GitHub Pages_ et le consulter en ligne.

En ajoutant à cela les vérifications de fautes de français déjà mises en place
précédemment, vous disposez désormais d’un processus complet de **vérification,
génération et déploiement continu** pour votre livre de recettes collaboratif.
Il ne vous reste plus qu’à enrichir le contenu et à faire évoluer le site au fil
des contributions de votre brigade.

N'hésitez pas à aller lire la [conclusion commune](../../conclusion-commune.md).
Puis, si vous êtes en avance, commencez à jeter un oeil au parcours alternatif
[« GitLab fermé »](../../github/1-intro.md) du TP. Celui-ci vous présentera, sur
une autre forge couramment utilisée (GitLab), une méthode de travail plus
adaptée pour des projets internes manipulant des informations sensibles.


---

## Exercices

Nous vous invitons à réfléchir aux questions suivantes pour approfondir votre
compréhension de l’intégration et du déploiement continus avec GitHub :

1. Que se passe-t-il si la vérification grammaticale échoue ? Le site est-il
   tout de même publié ?
2. Combien d’étapes sont exécutées durant votre _workflow_ de déploiement
   continu ? Savez-vous différencier celles que vous avez définies vous même de
   celles qui ont été ajoutées automatiquement par GitHub ?
3. Afin d’éviter les accidents, le chef cuisinier peut-il configurer les _pull
   requests_ pour qu’il ne soit possible de les fusionner que si la génération
   du site statique a réussi ?
