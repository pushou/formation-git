#!/bin/bash
#
# Ce script contient l'ensemble des commandes exécutées par les utilisateurs
# durant le TP3, ce qui permet de rejouer facilement ces commandes pour...
#
# - Vérifier l'absence de nouvelles erreurs, de nouveaux conseils git, etc. en
#   comparant la sortie au fichier de référence .ref.
# - Régénérer facilement l'archive de rattrapage de fin de TP3 (et autres TPs)
#
# Tout ça peut être fait via un simple "make" dans un environnement utilisateur
# fraîchement initialisé.
#
set -euxo pipefail
IFS=$'\n\t'


function test_this_manually() {
###### ANCHOR: restore-from-zip
cd ~/Desktop \
&& rm -rf TP3.zip ArchivesTPs/TP2 \
&& mkdir -p ArchivesTPs/TP2 \
&& if [[ -e MonDepot ]]; then mv MonDepot ArchivesTPs/TP2; fi \
&& wget https://grasland.pages.in2p3.fr/formation-git/TP3.zip \
&& unzip TP3.zip \
&& rm TP3.zip
###### ANCHOR_END: restore-from-zip
}
unset -f test_this_manually


###### ANCHOR: init
mkdir ~/Desktop/MesBranches
cd ~/Desktop/MesBranches
git init
###### ANCHOR_END: init

###### ANCHOR: initial-commit
echo 'Bonjour !' > HelloWorld.txt
printf 'Première partie\n\n\n\nDeuxième partie\n' > Contenu.txt
git add HelloWorld.txt Contenu.txt
git commit -m 'Commit initial'
###### ANCHOR_END: initial-commit

###### ANCHOR: initial-tag
git tag initial
###### ANCHOR_END: initial-tag


###### ANCHOR: parallel-branch
git branch univers-parallele
###### ANCHOR_END: parallel-branch

###### ANCHOR: branch-list
git branch --list
###### ANCHOR_END: branch-list

###### ANCHOR: parallel-checkout
git checkout univers-parallele
###### ANCHOR_END: parallel-checkout

###### ANCHOR: status-after-parallel-checkout
git status
###### ANCHOR_END: status-after-parallel-checkout


###### ANCHOR: first-parallel-commit
echo 'Hi there!' > HelloWorld.txt
echo 'Troisième partie' >> Contenu.txt
git add HelloWorld.txt Contenu.txt
git commit -m 'Premier jeu de modifications'
###### ANCHOR_END: first-parallel-commit

###### ANCHOR: checkout-after-parallel-commit
git checkout main
###### ANCHOR_END: checkout-after-parallel-commit

###### ANCHOR: cat-after-checkout
cat HelloWorld.txt
###### ANCHOR_END: cat-after-checkout

###### ANCHOR: edit-first-line
echo 'Partie 1 : Le commencement' > Contenu.txt.new
tail --lines=+2 Contenu.txt >> Contenu.txt.new
mv Contenu.txt.new Contenu.txt
###### ANCHOR_END: edit-first-line

###### ANCHOR: add-new-file
echo 'Nouveau fichier' > AutreContenu.txt
###### ANCHOR_END: add-new-file

###### ANCHOR: first-main-commit
git add --all
git commit -m 'Deuxième jeu de modifications'
###### ANCHOR_END: first-main-commit


###### ANCHOR: diff-initial-main-parallel
git diff initial main
git diff initial univers-parallele
git diff main univers-parallele
###### ANCHOR_END: diff-initial-main-parallel


###### ANCHOR: status-before-merge
git status
###### ANCHOR_END: status-before-merge

function test_this_manually() {
###### ANCHOR: merge-parallel
# Cette commande ouvrira un éditeur de message de commit
git merge univers-parallele
###### ANCHOR_END: merge-parallel
}
unset -f test_this_manually
git merge -m "Une fusion sans histoires" univers-parallele

###### ANCHOR: diff-after-merge
git diff main~
git diff initial
git diff univers-parallele
###### ANCHOR_END: diff-after-merge


###### ANCHOR: fast-forward-merge
git checkout univers-parallele
git merge main
###### ANCHOR_END: fast-forward-merge

# shellcheck disable=SC1083
###### ANCHOR: cancel-merge-using-reflog
git reset --hard @{1}
###### ANCHOR_END: cancel-merge-using-reflog

function test_this_manually() {
###### ANCHOR: merge-main-wo-ff
# Cette commande ouvrira un éditeur de message de commit
git merge --no-ff main
###### ANCHOR_END: merge-main-wo-ff
}
unset -f test_this_manually
git merge --no-ff -m "Une autre fusion sans histoires" main


###### ANCHOR: conflicting-commits
git checkout main
echo 'Annexe' >> Contenu.txt
git add Contenu.txt
git commit -m 'Ajoutons une annexe'
git checkout univers-parallele
echo 'Bibliographie' >> Contenu.txt
git add Contenu.txt
git commit -m 'Ajoutons une bibliographie'
###### ANCHOR_END: conflicting-commits

set +e
###### ANCHOR: conflicting-merge
# Cette fusion ne peut être complètement automatisée en raison d'un conflit
git merge main
###### ANCHOR_END: conflicting-merge
set -e

###### ANCHOR: conflicting-status
git status
###### ANCHOR_END: conflicting-status

###### ANCHOR: conflicting-file
cat Contenu.txt
###### ANCHOR_END: conflicting-file

###### ANCHOR: conflicting-diff
git diff
###### ANCHOR_END: conflicting-diff


###### ANCHOR: abort-merge
###### ANCHOR: abort-merge-only
git merge --abort
###### ANCHOR_END: abort-merge-only
git status
###### ANCHOR_END: abort-merge

function test_this_manually() {
###### ANCHOR: conflict-vs-meld
git merge main
###### ANCHOR: use-meld
meld .
###### ANCHOR_END: use-meld
###### ANCHOR_END: conflict-vs-meld
}
unset -f test_this_manually
#
# In scripted mode, we do what one would do using meld, but automatically ;)
set +e; git merge main; set -e
head --lines=-5 Contenu.txt > Contenu.txt.new
echo 'Annexe' >> Contenu.txt.new
echo 'Bibliographie' >> Contenu.txt.new
mv Contenu.txt.new Contenu.txt
git add Contenu.txt

###### ANCHOR: status-after-meld
git status
###### ANCHOR_END: status-after-meld

function test_this_manually() {
###### ANCHOR: merge-continue
git merge --continue
###### ANCHOR_END: merge-continue
}
unset -f test_this_manually
git commit -m 'Un merge qui se termine après quelques conflits'


function test_this_manually() {
###### ANCHOR: cheatsheet-create-branch
# Remplacez NouvelleBranche par le nom de la branche que vous voulez créer
git branch NouvelleBranche
###### ANCHOR_END: cheatsheet-create-branch

###### ANCHOR: cheatsheet-checkout-new-branch
git checkout -b NouvelleBranche
###### ANCHOR_END: cheatsheet-checkout-new-branch

###### ANCHOR: cheatsheet-checkout-existing-branch
# Remplacez BrancheAVisiter par le nom de la branche où vous voulez basculer
git checkout BrancheAVisiter
###### ANCHOR_END: cheatsheet-checkout-existing-branch

###### ANCHOR: cheatsheet-delete-branch
# Remplacez BrancheASupprimer par le nom de la branche que vous voulez supprimer
git branch --delete BrancheASupprimer
###### ANCHOR_END: cheatsheet-delete-branch

###### ANCHOR: cheatsheet-merge-normal
# Remplacez BrancheAFusionner par le nom de la branche que vous voulez fusionner
git merge BrancheAFusionner
###### ANCHOR_END: cheatsheet-merge-normal

###### ANCHOR: cheatsheet-merge-ff-only
git merge --ff-only BrancheAFusionner
###### ANCHOR_END: cheatsheet-merge-ff-only

###### ANCHOR: cheatsheet-merge-no-ff
git merge --no-ff BrancheAFusionner
###### ANCHOR_END: cheatsheet-merge-no-ff

###### ANCHOR: cheatsheet-merge-continue
# Les deux commandes qui suivent sont équivalentes dans le contexte d'une
# résolution de conflits de fusion, la première est juste plus explicite
git merge --continue
git commit
###### ANCHOR_END: cheatsheet-merge-continue


###### ANCHOR: cherry-pick-basic
# Remplacez ListeDeCommits par des identifiants de commits que vous voulez
# récupérez (hashes, branche~N, etc) séparés par des espaces
git cherry-pick ListeDeCommits
###### ANCHOR_END: cherry-pick-basic

###### ANCHOR: cherry-pick-range
# Remplacez Commit1 et CommitN par le premier et le dernier commit que vous
# voulez récupérer au sein d'une branche d'historique
git cherry-pick Commit1..CommitN
###### ANCHOR_END: cherry-pick-range


###### ANCHOR: show-reflog
# Afficher l'historique des positions de HEAD
git reflog
# Afficher l'historique des positions de la branche main
git reflog main
# Afficher l'historique des positions de toutes les branches, étiquettes...
git reflog --all
###### ANCHOR_END: show-reflog
}
unset -f test_this_manually
