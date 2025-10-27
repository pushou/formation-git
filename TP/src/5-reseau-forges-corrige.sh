#!/bin/bash
#
# Ce script contient les commandes du corrigé de l'exercice du TP5, ce qui
# permet de rejouer facilement ces commandes pour vérifier l'absence de
# nouvelles erreurs, de nouveaux conseils git, etc. en comparant la sortie à un
# fichier de référence .ref généré précédemment.
#
# Tout ça peut être fait via un simple "make" dans un environnement utilisateur
# fraîchement initialisé.
#
set -euxo pipefail
IFS=$'\n\t'

###### ANCHOR: goto-repo
cd ~/Desktop/recettes
###### ANCHOR_END: goto-repo

###### ANCHOR: show-remote-details
git remote -v
###### ANCHOR_END: show-remote-details

###### ANCHOR: checkout-main
git checkout main
###### ANCHOR_END: checkout-main

###### ANCHOR: create-and-checkout-branch
git checkout -b copyright
###### ANCHOR_END: create-and-checkout-branch

###### ANCHOR: commit-something
echo -e '\n(C) 1789, Être Suprême Inc.' >> README.md
git add README.md
git commit -m "Ajout d'une notice de copyright"
###### ANCHOR_END: commit-something

function test_this_manually() {
###### ANCHOR: push-and-set-upstream
git push --set-upstream origin copyright
###### ANCHOR_END: push-and-set-upstream
}
unset -f test_this_manually

###### ANCHOR: commit-more-things
echo 'AAAAAAH' >> README.md
git add README.md
git commit -m 'Panique à bord !'
echo 'QQQQQQH' >> README.md
git add README.md
git commit -m 'Panique à bord en QWERTY !'
###### ANCHOR_END: commit-more-things

function test_this_manually() {
###### ANCHOR: push-shortcut
git push
###### ANCHOR_END: push-shortcut
}
unset -f test_this_manually

###### ANCHOR: update-main
git checkout main
git pull --ff-only
###### ANCHOR_END: update-main

###### ANCHOR: delete-local-branch
git branch -D copyright
###### ANCHOR_END: delete-local-branch

function test_this_manually() {
###### ANCHOR: recover-from-remote
git checkout copyright
###### ANCHOR_END: recover-from-remote
}
unset -f test_this_manually
