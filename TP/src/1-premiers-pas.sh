#!/bin/bash
#
# Ce script contient l'ensemble des commandes exécutées par les utilisateurs
# durant le TP1, ce qui permet de rejouer facilement ces commandes pour...
#
# - Vérifier l'absence de nouvelles erreurs, de nouveaux conseils git, etc. en
#   comparant la sortie au fichier de référence .ref.
# - Régénérer facilement l'archive de rattrapage de fin de TP1 (et autres TPs)
#
# Tout ça peut être fait via un simple "make" dans un environnement utilisateur
# fraîchement initialisé.
#
set -euxo pipefail
IFS=$'\n\t'


###### ANCHOR: whoami
whoami
###### ANCHOR_END: whoami


###### ANCHOR: config-user
# Remplacez "Francine Dupont" et "fdupont@serveur-imaginaire.fr" par votre nom
# et l'adresse e-mail associée à votre compte GitHub/GitLab dans ce qui suit
git config --global user.name 'Francine Dupont'
git config --global user.email 'fdupont@serveur-imaginaire.fr'
###### ANCHOR_END: config-user

###### ANCHOR: config-editor
git config --global core.editor nano
###### ANCHOR_END: config-editor

###### ANCHOR: config-default-branch
git config --global init.defaultBranch master
###### ANCHOR_END: config-default-branch

###### ANCHOR: config-list
git config --list
###### ANCHOR_END: config-list


###### ANCHOR: init
mkdir ~/Desktop/MonDepot
cd ~/Desktop/MonDepot
###### ANCHOR: init-only
git init
###### ANCHOR_END: init-only
###### ANCHOR_END: init


###### ANCHOR: status
git status
###### ANCHOR_END: status

###### ANCHOR: status-touch
touch MonFichier.txt
git status
###### ANCHOR_END: status-touch

###### ANCHOR: add-only
# Remplacez MonFichier.txt par le fichier/dossier que vous voulez versionner
###### ANCHOR: status-add
git add MonFichier.txt
###### ANCHOR_END: add-only
git status
###### ANCHOR_END: status-add

###### ANCHOR: echo-poubelle-add
echo "[DEBUG] Ce matin, Gregor Samsa s'est réveillé" > Poubelle.log
git add Poubelle.log
git status
###### ANCHOR_END: echo-poubelle-add

###### ANCHOR: reset-only
# Remplacez Poubelle.log par le nom du fichier sur lequel vous avez
# accidentellement appelé "git add"
###### ANCHOR: status-reset
git reset Poubelle.log
###### ANCHOR_END: reset-only
git status
###### ANCHOR_END: status-reset


###### ANCHOR: ignore-status
git status
###### ANCHOR_END: ignore-status

###### ANCHOR: ignore-gitignore-status
###### ANCHOR: ignore-gitignore-docs
# Exécuter à la racine de dépôt, sinon l'effet est limité au sous-dossier actuel
echo '*.log' > .gitignore
###### ANCHOR_END: ignore-gitignore-docs
git status
###### ANCHOR_END: ignore-gitignore-status

###### ANCHOR: ignore-add-gitignore
git add .gitignore
###### ANCHOR_END: ignore-add-gitignore


###### ANCHOR: mv-with-git
git mv MonFichier.txt MonSuperFichier.txt
git status
###### ANCHOR_END: mv-with-git

###### ANCHOR: mv-without-git
mv MonSuperFichier.txt MonIncroyableFichier.txt
git status
###### ANCHOR_END: mv-without-git

###### ANCHOR: mv-add-all-only
###### ANCHOR: mv-add-all
git add --all .
###### ANCHOR_END: mv-add-all-only
git status
###### ANCHOR_END: mv-add-all

set +e
###### ANCHOR: rm-unversioned
# ERREUR: Les changements de MonIncroyableFichier.txt n'ont été enregistrés dans
#         aucune version et seraient donc perdus. git interdit la plupart des
#         opérations destructrices de ce type par défaut.
git rm MonIncroyableFichier.txt
###### ANCHOR_END: rm-unversioned
set -e

###### ANCHOR: rm-unversioned-force
git rm -f MonIncroyableFichier.txt
###### ANCHOR_END: rm-unversioned-force


###### ANCHOR: folder-empty
# Pour git status, les dossiers sans fichiers n'existent pas
mkdir MonDossier
git status

# Dès qu'il y aura un fichier, git status prendra le dossier en compte
echo 'Un semblant de contenu' > MonDossier/Contenu.txt
git status
###### ANCHOR_END: folder-empty

###### ANCHOR: folder-add
git add MonDossier/
git status
###### ANCHOR_END: folder-add

set +e
###### ANCHOR: folder-rm
# ERREUR: Pas de suppression de dossier sans -r
git rm MonDossier/
###### ANCHOR_END: folder-rm
set -e


###### ANCHOR: help-long
# Les deux commandes suivantes font exactement la même chose
man git status
git help status
###### ANCHOR_END: help-long

###### ANCHOR: help-short-docs
# Remplacez "mv" par la commande git qui vous intéresse
###### ANCHOR: help-short
git mv -h
###### ANCHOR_END: help-short-docs
###### ANCHOR_END: help-short


function test_this_manually() {
###### ANCHOR: add-workdir
git add .
###### ANCHOR_END: add-workdir

###### ANCHOR: cheatsheet-rm
# Remplacez MonFichier.txt par le nom du fichier que vous voulez supprimer
#
# Ajoutez -r pour supprimer un dossier et son contenu, et ajoutez -f si vous
# êtes sûr de vouloir supprimer des changements qui n'ont pas été versionnés et
# seront donc définitivement perdus.
git rm MonFichier.txt
###### ANCHOR_END: cheatsheet-rm

###### ANCHOR: cheatsheet-mv
# Remplacez Source.txt et Destination.txt pas les noms du fichier source et le
# nom final désiré, respectivement.
git mv Source.txt Destination.txt
###### ANCHOR_END: cheatsheet-mv
}
unset -f test_this_manually


###### ANCHOR: cheatsheet-help
# Remplacez "status" par la commande git qui vous intéresse
git help status
###### ANCHOR_END: cheatsheet-help


function test_this_manually() {
###### ANCHOR: appendix-config
# Dans les commandes suivantes, remplacez ReglageAChanger par le réglage git
# dont vous voulez modifier la valeur, et la chaîne de caractère qui suit par la
# valeur que vous voulez donner à ce réglage.
#
# Rappelez-vous également que l'utilisation de "git config --system" nécessite
# des privilèges administrateur.
git config --system ReglageAChanger 'Valeur pour tout le système'
git config --global ReglageAChanger 'Valeur spécifique à un utilisateur'
git config ReglageAChanger 'Valeur spécifique à un dépôt git'
###### ANCHOR_END: appendix-config
}
unset -f test_this_manually
