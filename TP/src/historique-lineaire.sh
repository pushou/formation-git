#!/bin/bash
#
# Ce script contient l'ensemble des commandes exécutées par les utilisateurs
# durant le TP2, ce qui permet de rejouer facilement ces commandes pour...
# 
# - Vérifier l'absence de nouvelles erreurs, de nouveaux conseils git, etc. en
#   comparant la sortie au fichier de référence .ref.
# - Régénérer facilement l'archive de rattrapage de fin de TP2 (et autres TPs)
#
# Tout ça peut être fait via un simple "make" dans un environnement utilisateur
# fraîchement initialisé.
#
set -euxo pipefail
IFS=$'\n\t'

function test_this_manually() {
###### ANCHOR: first-interactive-commit
cd ~/Desktop/MonDepot
###### ANCHOR: cheatsheet-commit
git commit
###### ANCHOR_END: cheatsheet-commit
###### ANCHOR_END: first-interactive-commit
}
unset -f test_this_manually
cd ~/Desktop/MonDepot
###### ANCHOR: cheatsheet-commit-message
git commit -m "Mon premier commit"
###### ANCHOR_END: cheatsheet-commit-message


###### ANCHOR: status-after-commit
git status
###### ANCHOR_END: status-after-commit

###### ANCHOR: change-then-status
echo 'Un premier changement' > MonDossier/Contenu.txt
echo 'Un nouveau fichier' > AutreContenu.txt
git status
###### ANCHOR_END: change-then-status

###### ANCHOR: diff-after-change
git diff
###### ANCHOR_END: diff-after-change


###### ANCHOR: changes-and-diffs
git add MonDossier
git diff
echo 'Un second changement' >> MonDossier/Contenu.txt
git diff
###### ANCHOR_END: changes-and-diffs

###### ANCHOR: workdir-vs-head
git diff HEAD
###### ANCHOR_END: workdir-vs-head

###### ANCHOR: index-vs-head
git diff --cached
###### ANCHOR_END: index-vs-head

###### ANCHOR: diff-target-only
git add AutreContenu.txt
git commit -m 'Une deuxième version'
echo 'Un ajout de contenu' >> AutreContenu.txt
git diff
####### ANCHOR: diff-folder
git diff MonDossier/
####### ANCHOR_END: diff-folder
####### ANCHOR_END: diff-target-only


###### ANCHOR: add-all-directory
rm MonDossier/Contenu.txt
git add --all MonDossier/
git status
git commit -m 'Nous sommes sur une bonne lancée !'
###### ANCHOR_END: add-all-directory


###### ANCHOR: git-log
git log
###### ANCHOR_END: git-log

function test_this_manually() {
###### ANCHOR: gitg-foreground
gitg
###### ANCHOR_END: gitg-foreground

###### ANCHOR: gitg-background
gitg &
###### ANCHOR_END: gitg-background
}
unset -f test_this_manually


###### ANCHOR: diff-workdir-vs-head-parent
git diff HEAD~
###### ANCHOR_END: diff-workdir-vs-head-parent

###### ANCHOR: diff-head-vs-head-parent
git diff HEAD~ HEAD
###### ANCHOR_END: diff-head-vs-head-parent


###### ANCHOR: tag-basic
git tag important
git tag papa HEAD~
git tag maman important~
git tag ancetre HEAD~2
###### ANCHOR_END: tag-basic

###### ANCHOR: tag-annotate-interactive
git tag --annotate -m "Ma super v1" v1.0 HEAD~
###### ANCHOR_END: tag-annotate-interactive

###### ANCHOR: show-annotated-tag
git show v1.0
###### ANCHOR_END: show-annotated-tag

###### ANCHOR: tag-list
git tag --list
###### ANCHOR_END: tag-list

###### ANCHOR: tag-delete
git tag --delete v1.0 important maman papa ancetre
###### ANCHOR_END: tag-delete


###### ANCHOR: status-before-checkout
git status
###### ANCHOR_END: status-before-checkout

###### ANCHOR: commit-before-checkout
git add --all
git commit -m 'La version ultime'
git status
###### ANCHOR_END: commit-before-checkout

###### ANCHOR: checkout-head-parent
git checkout HEAD~
###### ANCHOR_END: checkout-head-parent

###### ANCHOR: checkout-back-main
git checkout main
###### ANCHOR_END: checkout-back-main


###### ANCHOR: status-before-revert
git status
###### ANCHOR_END: status-before-revert

###### ANCHOR: revert-head
git revert HEAD
###### ANCHOR_END: revert-head


function test_this_manually() {
###### ANCHOR: cheatsheet-add
# Remplacez FichiersEtDossiers par la liste des fichiers et dossiers que vous
# voulez ajouter ou mettre à jour dans le prochain commit
git add FichiersEtDossiers
###### ANCHOR_END: cheatsheet-add

###### ANCHOR: cheatsheet-add-all
# L'ajout de --all permet de prendre en compte les suppressions, vous pouvez
# aussi ne pas préciser de fichiers/dossiers cibles pour ajouter l'ensemble des
# changements du répertoire de travail à l'index.
git add --all FichiersEtDossiers
###### ANCHOR_END: cheatsheet-add-all

###### ANCHOR: cheatsheet-diff-commits
git diff A B
###### ANCHOR_END: cheatsheet-diff-commits



}
unset -f test_this_manually
