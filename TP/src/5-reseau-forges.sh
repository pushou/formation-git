#!/bin/bash
#
# Ce script contient l'ensemble des commandes exécutées par les utilisateurs
# durant le TP5, ce qui permet de rejouer facilement ces commandes pour vérifier
# l'absence de nouvelles erreurs, de nouveaux conseils git, etc. en comparant la
# sortie à un fichier de référence .ref généré précédemment.
#
# Tout ça peut être fait via un simple "make" dans un environnement utilisateur
# fraîchement initialisé.
#
set -euxo pipefail
IFS=$'\n\t'


function test_this_manually() {
###### ANCHOR: ssh-keygen
# Ce programme va vous poser plusieurs questions, voir la suite du texte du TP
ssh-keygen -t ed25519 -C "formation-git"
###### ANCHOR_END: ssh-keygen
}
unset -f test_this_manually
ssh-keygen -q -t ed25519 -f "${HOME}/.ssh/id_ed25519" -N '' -C "formation-git"

###### ANCHOR: show-pubkey
cat ~/.ssh/id_ed25519.pub
###### ANCHOR_END: show-pubkey

function test_this_manually() {
###### ANCHOR: clone-from-github
cd ~/Desktop
# Remplacez URLDuFork par l'URL de votre fork
git clone URLDuFork
###### ANCHOR_END: clone-from-github

###### ANCHOR: clone-from-gitlab
cd ~/Desktop
# Même URL que le "Clone with SSH" de GitLab
git clone git@gitlab.in2p3.fr:git-kitchen/recettes.git
###### ANCHOR_END: clone-from-gitlab
}
unset -f test_this_manually
cd ~/Desktop
git clone https://github.com/HadrienG2/ddhc.git


###### ANCHOR: goto-repo-and-show-remote
cd ddhc/
git remote -v
###### ANCHOR_END: goto-repo-and-show-remote

###### ANCHOR: add-upstream-remote
git remote add upstream https://github.com/HadrienG2/ddhc.git
git fetch upstream
###### ANCHOR_END: add-upstream-remote


###### ANCHOR: set-upstream-main
git checkout main
git branch --set-upstream-to=upstream/main
###### ANCHOR_END: set-upstream-main

# TODO: Bring back once github and gitlab are back in sync
function test_this_manually() {
###### ANCHOR: pull-main-gitlab
cd ~/Desktop/recettes
###### ANCHOR: pull-main-github
git checkout main
git pull --ff-only
###### ANCHOR_END: pull-main-github
###### ANCHOR_END: pull-main-gitlab
}
unset -f test_this_manually

###### ANCHOR: config-pull-ff-only
git config pull.ff only
###### ANCHOR_END: config-pull-ff-only


###### ANCHOR: create-dev-branch-github
git checkout main
# Vous pouvez appeler votre branche de développement comme vous voulez, mais il
# faudra adapter les commandes suivantes du TP en fonction du nom choisi
git checkout -b NomDeBranche
###### ANCHOR_END: create-dev-branch-github

function test_this_manually() {
###### ANCHOR: create-dev-branch-gitlab
git checkout main
# Choisissez un nom de branche original pour éviter toute collision avec vos
# collègues qui travaillent au sein du même dépôt. Attention, le nom devra être
# modifié dans toutes les commandes suivantes du chapitre.
git checkout -b NomDeBranche
###### ANCHOR_END: create-dev-branch-gitlab
}
unset -f test_this_manually

###### ANCHOR: commit-on-dev-branch
# Remplacez cette commande d'édition par une édition du fichier de votre choix.
# N'hésitez pas à éditer le fichier avec votre éditeur de texte favori.
echo -e "\nCeci n'est pas un pied de page" >> README.md
git add README.md

# Vous pouvez bien sûr adapter le message de commit aussi
git commit -m "Ajout d'un pied de page rebelle"
###### ANCHOR_END: commit-on-dev-branch

###### ANCHOR: update-main-and-merge
git checkout main
git pull --ff-only
git checkout NomDeBranche
git merge main
###### ANCHOR_END: update-main-and-merge

# I'd love to test this too but credentials are hard
function test_this_manually() {
###### ANCHOR: push-set-upstream
git push --set-upstream origin NomDeBranche
###### ANCHOR_END: push-set-upstream

###### ANCHOR: delete-dev-branch-github
git push --delete origin NomDeBranche
###### ANCHOR: delete-dev-branch-gitlab
git checkout main
git branch -D NomDeBranche
###### ANCHOR_END: delete-dev-branch-gitlab
###### ANCHOR_END: delete-dev-branch-github
}
unset -f test_this_manually
