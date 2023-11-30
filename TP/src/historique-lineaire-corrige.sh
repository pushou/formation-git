#!/bin/bash
#
# Ce script contient les commandes du corrigé de l'exercice du TP2, ce qui
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
mkdir ~/Desktop/Exercice2
cd ~/Desktop/Exercice2
git init
###### ANCHOR_END: create-repo

###### ANCHOR: create-files
echo 'Mon premier fichier' > Fichier1.txt
echo 'Mon deuxième fichier' > Fichier2.txt
echo 'Mon troisième fichier' > Fichier3.txt
###### ANCHOR_END: create-files

###### ANCHOR: add-all-files
git add --all
###### ANCHOR_END: add-all-files

###### ANCHOR: create-first-commit
git commit -m 'Mon premier commit'
###### ANCHOR_END: create-first-commit

###### ANCHOR: edit-two-files
echo 'De plus' >> Fichier1.txt
echo 'En plus' >> Fichier2.txt
###### ANCHOR_END: edit-two-files

###### ANCHOR: commit-only-one-file
git add Fichier1.txt
git commit -m 'Mon deuxième commit'
###### ANCHOR_END: commit-only-one-file

###### ANCHOR: status-after-partial-commit
git status
###### ANCHOR_END: status-after-partial-commit

###### ANCHOR: diff-after-partial-commit
git diff
###### ANCHOR_END: diff-after-partial-commit

###### ANCHOR: commit-the-rest
git commit -am 'Mon troisième commit'
###### ANCHOR_END: commit-the-rest

###### ANCHOR: diff-grandparent-to-parent
git diff HEAD~2 HEAD~
###### ANCHOR_END: diff-grandparent-to-parent

###### ANCHOR: status-before-checkout
git status
###### ANCHOR_END: status-before-checkout

###### ANCHOR: checkout-grandparent
git checkout HEAD~2
###### ANCHOR_END: checkout-grandparent

###### ANCHOR: tag-grandparent
git tag papy
###### ANCHOR_END: tag-grandparent

###### ANCHOR: back-to-master
git checkout master
###### ANCHOR_END: back-to-master
