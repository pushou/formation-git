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
cd ~/Desktop/
# Remplacez URLDuFork par l'URL de votre fork
git clone URLDuFork
###### ANCHOR_END: clone-from-github
}
unset -f test_this_manually
cd ~
git clone https://github.com/francine-dupont/ddhc.git


###### ANCHOR: goto-repo-and-show-remote
cd ddhc/
git remote -v
###### ANCHOR_END: goto-repo-and-show-remote

###### ANCHOR: add-upstream-remote
git remote add upstream https://github.com/HadrienG2/ddhc.git
git fetch upstream
###### ANCHOR_END: add-upstream-remote


###### ANCHOR: set-upstream-master
git checkout master
git branch --set-upstream-to=upstream/master
###### ANCHOR_END: set-upstream-master

###### ANCHOR: pull-master
git checkout master
git pull --ff-only
###### ANCHOR_END: pull-master

###### ANCHOR: config-pull-ff-only
git config pull.ff only
###### ANCHOR_END: config-pull-ff-only


###### ANCHOR: create-dev-branch
git checkout master
# Vous pouvez appeler votre branche de développement comme vous voulez, mais il
# faudra adapter les commandes suivantes du TP en fonction du nom choisi
git checkout -b changements
###### ANCHOR_END: create-dev-branch

###### ANCHOR: commit-on-dev-branch
# Remplacez cette commande d'édition par une édition du fichier de votre choix.
# N'hésitez pas à éditer le fichier avec votre éditeur de texte favori.
echo -e "\nCeci n'est pas un pied de page" >> README.md
git add README.md

# Vous pouvez bien sûr adapter le message de commit aussi
git commit -m "Ajout d'un pied de page rebelle"
###### ANCHOR_END: commit-on-dev-branch

###### ANCHOR: update-master-and-merge
git checkout master
git pull --ff-only
git checkout changements
git merge master
###### ANCHOR_END: update-master-and-merge

# I'd love to test this too but credentials are hard
function test_this_manually() {
###### ANCHOR: push-set-upstream
git push --set-upstream origin changements
###### ANCHOR_END: push-set-upstream

###### ANCHOR: delete-dev-branch
git checkout master
git push --delete origin changements
git branch -D changements
###### ANCHOR_END: delete-dev-branch
}
unset -f test_this_manually
