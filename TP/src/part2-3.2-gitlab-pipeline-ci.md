# Créer et inspecter un pipeline GitLab CI — Vérification d’orthographe avec Grammalecte

Dans cette étape, vous allez mettre en place une intégration continue sur GitLab qui vérifie automatiquement l’orthographe et certaines règles typographiques de vos recettes rédigées en Markdown à l’aide de [Grammalecte](https://grammalecte.net/).

### Objectifs

* Ajouter un fichier de pipeline `.gitlab-ci.yml` dans votre dépôt.
* Installer et exécuter Grammalecte en CI pour analyser `recettes/**/*.md` (c’est-à-dire tous les fichiers Markdown du dossier `recettes/` et de ses sous-dossiers).
* Faire échouer le pipeline si des erreurs sont détectées.
* Visualiser le pipeline et consulter les rapports dans l’interface GitLab.

---

## Pré-requis

* Un dépôt GitLab fonctionnel (votre carnet de recettes individuel, puis votre livre collaboratif).
* Au moins une recette en Markdown dans le dossier `recettes/` (ex. : `recettes/crepes-classiques.md`).

---

## Étape 0 — Préparation

Avant de commencer, assurez-vous d’avoir synchronisé l’ensemble de votre travail avec le dépôt distant sur GitLab.
Créez ensuite une branche dédiée à cet exercice, par exemple :

```bash
git checkout -b ci-grammalecte
```

---

## Étape 1 — Créer le fichier `.gitlab-ci.yml`

À la racine de votre dépôt, créez un fichier nommé `.gitlab-ci.yml`.
Ce fichier décrit les différentes étapes que GitLab exécutera automatiquement sur ses *runners*.
Il vous permettra d’automatiser diverses tâches, ici la vérification orthographique et grammaticale.

Dans un premier temps, nous allons définir une seule étape appelée `lint`, chargée de vérifier la qualité du texte.

<details>
<summary>Exemple de structure minimale</summary>

```yml
stages:
  - lint
```

</details>

Notre étape `lint` contiendra un seul *job*, nommé `grammaire_et_orthographe`, qui analysera le contenu des recettes.
Comme Grammalecte est un package Python, nous utiliserons une image Docker basée sur Python.

<details>
<summary>Définition du job</summary>

```yml
grammaire_et_orthographe:
  stage: lint
  image: python:3.12
```

</details>

Il faut maintenant installer l’utilitaire qui effectuera la vérification.
La commande d’installation est la suivante :

```bash
python -m pip install git@gitlab.in2p3.fr:sonny.lion/grammalint.git
```

Nous plaçons cette commande dans un bloc `before_script`, ce qui permet de séparer proprement l’installation de l’exécution du code (c’est surtout une question de clarté).

<details>
<summary>Ajout de la phase d’installation</summary>

```yml
grammaire_et_orthographe:
  stage: lint
  image: python:3.12
  before_script:
    - python -m pip install git@gitlab.in2p3.fr:sonny.lion/grammalint.git
```

</details>

Nous pouvons enfin ajouter la commande qui lance la vérification d’un fichier Markdown.
Par exemple, pour vérifier une recette donnée :

```bash
python -m grammalint -i recettes/crepes-classiques.md
```

Pour analyser automatiquement tous les fichiers Markdown du dossier `recettes/`, on peut écrire :

```bash
python -m grammalint -i recettes/**/*.md
```

Ce qui donne au final :

<details>
<summary>Pipeline complet</summary>

```yml
stages:
  - lint

grammaire_et_orthographe:
  stage: lint
  image: python:3.12
  before_script:
    - python -m pip install git@gitlab.in2p3.fr:sonny.lion/grammalint.git
  script:
    - python -m grammalint -i recettes/**/*.md
```

</details>

---

## Étape 2 — Commit, push et inspection du pipeline

1. Ajoutez le fichier au dépôt, validez et poussez vos changements :

   ```bash
   git add .gitlab-ci.yml
   git commit -m "CI: vérification d’orthographe avec Grammalecte"
   git push origin ci-grammalecte
   ```

2. Ouvrez une *Merge Request* (si ce n’est pas déjà fait) et consultez l’onglet **CI/CD → Pipelines** de votre projet GitLab.

3. Ouvrez le job `grammaire_et_orthographe` pour visualiser la sortie détaillée.
   Les erreurs sont listées par fichier avec un extrait contextuel et une explication.

