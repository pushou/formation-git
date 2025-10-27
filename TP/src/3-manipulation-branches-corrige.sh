#!/bin/bash
#
# Ce script contient les commandes du corrigé de l'exercice du TP3, ce qui
# permet de rejouer facilement ces commandes pour vérifier l'absence de
# nouvelles erreurs, de nouveaux conseils git, etc. en comparant la sortie à un
# fichier de référence .ref généré précédemment.
#
# Tout ça peut être fait via un simple "make" dans un environnement utilisateur
# fraîchement initialisé.
#
set -euxo pipefail
IFS=$'\n\t'

###### ANCHOR: copy-repo
cp -r ~/Desktop/MonDepot ~/Desktop/Exercice3
cd ~/Desktop/Exercice3
###### ANCHOR_END: copy-repo

###### ANCHOR: checkout-parent
git checkout HEAD~
###### ANCHOR_END: checkout-parent

###### ANCHOR: create-branch
git branch nouvelle-branche
###### ANCHOR_END: create-branch

###### ANCHOR: switch-to-branch
git checkout nouvelle-branche
###### ANCHOR_END: switch-to-branch

###### ANCHOR: first-commit
echo 'Un fichier' > LeFichier.txt
git add LeFichier.txt
git commit -m "Ajout d'un fichier"
###### ANCHOR_END: first-commit

function test_this_manually() {
###### ANCHOR: visualize-with-gitg
gitg &
###### ANCHOR_END: visualize-with-gitg

###### ANCHOR: auto-merge-main
git merge main
###### ANCHOR_END: auto-merge-main
}
unset -f test_this_manually
git merge -m 'Fusion du main dans le dev' main

###### ANCHOR: edit-on-secondary-branch
echo 'v1' > LeFichier.txt
git add LeFichier.txt
git commit -m 'Première version'
###### ANCHOR_END: edit-on-secondary-branch

###### ANCHOR: conflicting-edit-on-main-branch
git checkout main
echo 'v2' > LeFichier.txt
git add LeFichier.txt
git commit -m 'Deuxième version'
###### ANCHOR_END: conflicting-edit-on-main-branch

set +e
###### ANCHOR: conflicting-secondary-merge
git merge nouvelle-branche
###### ANCHOR_END: conflicting-secondary-merge
set -e

function test_this_manually() {
###### ANCHOR: resolve-conflict-with-meld
meld .
###### ANCHOR_END: resolve-conflict-with-meld
}
unset -f test_this_manually
echo 'v1.5' > LeFichier.txt
git add LeFichier.txt

function test_this_manually() {
###### ANCHOR: commit-conflict-resolution
git merge --continue
###### ANCHOR_END: commit-conflict-resolution
}
unset -f test_this_manually
git commit -m 'Coupage de poire en deux'

cd ~
rm -rf ~/Desktop/Exercice3
