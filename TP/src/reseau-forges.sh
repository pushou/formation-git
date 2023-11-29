#!/bin/bash
#
# Ce script contient l'ensemble des commandes exécutées par les utilisateurs
# durant le TP5, ce qui permet de rejouer facilement ces commandes pour...
# 
# - Vérifier l'absence de nouvelles erreurs, de nouveaux conseils git, etc. en
#   comparant la sortie au fichier de référence .ref.
# - Régénérer facilement l'archive de rattrapage de fin de TP5 (et autres TPs)
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
git clone https://github.com/francine-dupont/ddhc.git


###### ANCHOR: goto-repo-and-show-remote
cd ddhc/
git remote -v
###### ANCHOR_END: goto-repo-and-show-remote

###### ANCHOR: add-upstream-remote
git remote add upstream https://github.com/HadrienG2/ddhc.git
git fetch upstream
###### ANCHOR_END: add-upstream-remote


# WIP: Désactiver la commande push, ne peut pas marcher faute de credentials
