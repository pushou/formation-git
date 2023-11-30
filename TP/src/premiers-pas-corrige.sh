#!/bin/bash
#
# Ce script contient les commandes du corrigé de l'exercice du TP1, ce qui
# permet de rejouer facilement ces commandes pour vérifier l'absence de
# nouvelles erreurs, de nouveaux conseils git, etc. en comparant la sortie à un
# fichier de référence .ref généré précédemment.
#
# Tout ça peut être fait via un simple "make" dans un environnement utilisateur
# fraîchement initialisé.
#
set -euxo pipefail
IFS=$'\n\t'

###### ANCHOR: create-repo
mkdir ~/Desktop/Exercice1
cd ~/Desktop/Exercice1
git init
###### ANCHOR_END: create-repo

###### ANCHOR: ignore-objects
echo '*.o' > .gitignore
###### ANCHOR_END: ignore-objects

###### ANCHOR: create-file
echo 'Blabla' > Test.txt
###### ANCHOR_END: create-file

###### ANCHOR: add-changes-for-commit
git add Test.txt
###### ANCHOR_END: add-changes-for-commit

###### ANCHOR: git-mv-example
git mv Test.txt AutreTest.txt
###### ANCHOR_END: git-mv-example

###### ANCHOR: final-git-status
git status
###### ANCHOR_END: final-git-status
