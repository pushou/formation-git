# Déploiement continu du livre de recettes

Avoir un livre de cuisine numérique, c’est bien. Le rendre agréable à consulter
et accessible en ligne, c’est encore mieux.

Dans un premier temps, vous allez mettre en place un système d’intégration
continue similaire à celui utilisé pour votre dépôt individuel. Vous découvrirez
ensuite la notion de déploiement continu (_Continuous Deployment_ ou CD). Grâce
à _GitLab Pages_, vous pourrez héberger un [site web
statique](https://fr.wikipedia.org/wiki/Page_web_statique) directement depuis
votre dépôt GitLab et ainsi transformer vos fichiers Markdown en un véritable
livre de recettes en ligne.


## Coordination d’équipe

Avant de commencer à modifier le dépôt collaboratif, prenez un moment pour lire
le TP et discuter de ce qu'il faut faire avec votre brigade. En particulier,
posez-vous la question de :

- Qui prépare les tickets ?
- Qui gère ou modifie le _pipeline_ ?
- Qui modifie ou corrige les recettes ?
- Qui valide les _merge requests_ avant leur intégration dans `main` ?

Utilisez les tickets pour suivre les tâches à réaliser et l’avancement du
projet. N’oubliez pas de toujours travailler sur une branche dédiée.


## Définir le _pipeline_ de vérification

Comme dans le [chapitre
précédent](../4-depot-personnel/3-integration-continue.md), commencez par créer
un fichier nommé `.gitlab-ci.yml` à la racine de votre dépôt.

Pour rappel, ce fichier décrit les **étapes du _pipeline_** qui seront exécutées
automatiquement à chaque _push_ (ou selon les règles que vous aurez définies).

Nous allons d’abord introduire l’étape `lint`, dédiée à la vérification
grammaticale et orthographique du contenu du livre. En vous inspirant du
_pipeline_ mis en place pour votre dépôt individuel, ajoutez le _job_
`grammaire_et_orthographe`.

Vous pouvez réutiliser le script de vérification existant, en veillant
simplement à adapter le chemin vers vos recettes si nécessaire.

### Exercices

1. Assurez-vous que le _job_ `grammaire_et_orthographe` fonctionne correctement
   en lançant un _pipeline_.
2. Corrigez les erreurs détectées et ajustez votre script, puis relancez un
   _pipeline_ jusqu’à obtenir un résultat sans erreur.


## Générer et publier le site web

Maintenant que le contenu de votre livre est automatiquement vérifié, il est
temps de le rendre accessible en ligne. Pour cela, vous allez configurer deux
nouvelles étapes dans le _pipeline_ : `build` et `deploy`.

Le _pipeline_ final comprendra donc au total trois étapes, que nous définissons
comme avant avec le mot-clé [`stages`](https://docs.gitlab.com/ci/yaml/#stages)
suivi d'une liste à puces :

```yml
stages:
  - lint
  - build
  - deploy
```

GitLab exécutera les _jobs_ dans cet ordre, étape par étape, du _lint_ jusqu’au
_deploy_.

L’étape `build` a pour objectif de transformer les fichiers Markdown du livre en
un **site web statique** — des pages HTML simples, sans base de données ni
traitement côté serveur. L’étape `deploy`, quant à elle, publiera ce site à
l’aide du système intégré _GitLab Pages_.

Pour générer les pages web à partir de vos fichiers Markdown, vous utiliserez un
générateur de site statique nommé [_Astro_](https://astro.build/). Pas
d’inquiétude : vous n’avez pas besoin de devenir expert en Astro ni d’écrire du
code. Une image Docker préconfigurée (incluant Astro et un modèle de site) vous
sera fournie. Bien entendu, vous pouvez utiliser votre propre configuration si
vous le souhaitez.

<div class="warning">

L’image Docker étant préconfigurée pour un usage spécifique, vos recettes
doivent impérativement être au format Markdown, dans un dossier
<code>recettes/</code> à la racine du dépôt.

Pour bénéficier pleinement de la mise en page, veillez également à respecter les
propriétés de l’en-tête YAML (métadonnées) du gabarit fourni.

</div>

### Configurer la construction du site

Pour générer le site web, GitLab a besoin d’un _job_ spécifique nommé `pages`.
Ce nom est **réservé** : il permet à GitLab d’identifier automatiquement le
_job_ chargé de publier un site via _GitLab Pages_.[^pages]

[^pages]: Il est désormais possible d’utiliser un autre nom de _job_ pour le
déploiement des pages, mais cela nécessite une configuration supplémentaire.
Pour plus de détails, consultez la documentation officielle :
<https://docs.gitlab.com/user/project/pages/#user-defined-job-names>.

Ajoutez donc le _job_ `pages` dans votre fichier `.gitlab-ci.yml` :

```yml
pages:
  stage: build
  image: # à définir quand le dépôt sera créé
  before_script:
    # Installer les dépendances
    - npm install
  script:
    # Générer le site web
    - npx astro build
  # ... suite à venir ...
```

Ce _job_ est très proche de celui utilisé pour la vérification grammaticale. On
y retrouve notamment :

* l’[étape](https://docs.gitlab.com/ci/yaml/#stage) à laquelle il appartient
  (ici `build`) ;
* l’utilisation d’une [image](https://docs.gitlab.com/ci/yaml/#image) Docker
  spécifique (celle contenant _Astro_) ;
* un mot-clé [`before_script`](https://docs.gitlab.com/ci/yaml/#before_script)
  suivi d'une commande pour installer les dépendances ;
* un mot-clé [`script`](https://docs.gitlab.com/ci/yaml/#script) suivi d'une
  commande pour générer le site web.

### Définir les _artefacts_ à publier

Il faut maintenant indiquer à GitLab quels fichiers doivent être conservés et
publiés une fois le site généré. La commande `npx astro build` crée un dossier
`dist/` à la racine du dépôt, qui contient tous les fichiers HTML, CSS,
JavaScript et médias nécessaires au site web.

Pour que GitLab conserve ce dossier après l’exécution du _job_, nous allons
utiliser une section [`artifacts`](https://docs.gitlab.com/ci/yaml/#artifacts)
comme précédemment :

```yml
  # ... job pages ...
  artifacts:
    paths:
      - dist
```

Problème : par défaut, _GitLab Pages_ s’attend à publier le contenu d’un dossier
nommé `public/`. Pour utiliser un autre répertoire, vous devez le préciser
explicitement dans la configuration à l’aide d'une section
[`pages`](https://docs.gitlab.com/ci/yaml/#pages) :

```yml
pages:
  # ... reste de la configuration ...
  pages:  # Spécifie le répertoire à publier (par défaut 'public/')
    publish: dist
```

## Déployer le site

Pour finaliser la publication du site, il vous suffit d’envoyer votre fichier
`.gitlab-ci.yml` modifié dans le dépôt et d’attendre l’exécution complète du
_pipeline_. Dès qu’un _pipeline_ se termine avec succès, votre site est
automatiquement mis en ligne — aucune action manuelle supplémentaire n’est
nécessaire.

Voici un exemple complet de configuration minimale :

<details>
<summary>Exemple de fichier <code>.gitlab-ci.yml</code></summary>

```yml
stages:
  - lint
  - build
  - deploy

grammaire_et_orthographe:
  stage: lint
  image: python:3.12
  before_script:
    - python -m pip install git+https://gitlab.in2p3.fr/sonny.lion/grammalint.git
  script:
    - python -m grammalint -i recettes/**/*.md

pages:
  stage: build
  image: registry.gitlab.com/<nom_du_projet>/astro-template:latest
  before_script:
    - npm install
  script:
    - npx astro build
  artifacts:
    paths:
      - dist
  pages:
    publish: dist
```

</details>


### Visualiser le site publié

Une fois le _pipeline_ exécuté avec succès, accédez à la section **Deploy >
Pages** de votre projet GitLab. Vous y trouverez l’URL du site hébergé,
généralement de la forme :

```text
https://<votre-projet>-<votre-groupe>-<hash>.pages.in2p3.fr/
```

Cliquez sur ce lien pour visualiser votre livre de recettes en ligne.


## Conclusion

Dans ce TP, vous avez vu comment utiliser _GitLab Pages_ pour automatiser la
**génération et la publication** d’un site web statique à partir de fichiers
_Markdown_. Vous avez appris à :

- Définir un _pipeline_ complet intégrant les étapes `lint`, `build` et `deploy` ;
- Mettre en place une vérification linguistique automatique avec _Grammalecte_ ;
- Générer un site web statique grâce au générateur _Astro_ ;
- Déployer automatiquement ce site via _GitLab Pages_ et le consulter en ligne.

Vous disposez désormais d’un processus complet de **vérification, génération et
déploiement continu** pour notre livre de recettes collaboratif. Il ne vous
reste plus qu’à enrichir le contenu et à faire évoluer le site au fil des
contributions de votre brigade.


---

## Exercices

Nous vous invitons à réfléchir aux questions suivantes pour approfondir votre
compréhension de l’intégration et du déploiement continus avec _GitLab_ :

1. Que se passe-t-il si la vérification grammaticale échoue ? Le site est-il
   tout de même publié ?
2. Combien de _jobs_ sont exécutés lors du _pipeline_, et combien en avez-vous
   définis ? Qu’en est-il de l’étape de déploiement ?
3. Que se passe-t-il si vous ajoutez une nouvelle recette dans une branche
   secondaire ? Le site est-il mis à jour immédiatement ? Et si plusieurs
   personnes travaillent sur des branches différentes ?

---

## Informations complémentaires

### Contrôler les déploiements

Par défaut, _GitLab Pages_ déploie le site **après chaque _pipeline_ réussi**,
quelle que soit la branche. Cela peut conduire à la publication de versions en
cours de développement.

Pour éviter cela, vous pouvez limiter le déploiement à la branche principale
`main` en ajoutant une [règle](https://docs.gitlab.com/ci/yaml/#rules) à un ou
plusieurs _jobs_ :

```yml
mon_job_de_deploiement:
  rules:
    - if: $CI_COMMIT_BRANCH == "main"
```

Ainsi :

- seules les modifications fusionnées dans `main` seront déployées ;
- les _builds_ issus de branches secondaires seront simplement validées, sans
  publication.
