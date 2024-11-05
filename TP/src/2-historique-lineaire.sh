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
###### ANCHOR: restore-from-zip
cd ~/Desktop \
&& rm -rf TP2.zip ArchivesTPs/TP1 \
&& mkdir -p ArchivesTPs/TP1 \
&& if [[ -e MonDepot ]]; then mv MonDepot ArchivesTPs/TP1; fi \
&& wget https://grasland.pages.in2p3.fr/formation-git/TP2.zip \
&& unzip TP2.zip \
&& rm TP2.zip
###### ANCHOR_END: restore-from-zip

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

###### ANCHOR: checkout-back-master
git checkout master
###### ANCHOR_END: checkout-back-master


###### ANCHOR: status-before-revert
git status
###### ANCHOR_END: status-before-revert


function test_this_manually() {
###### ANCHOR: revert-head
git revert HEAD
###### ANCHOR_END: revert-head
}
unset -f test_this_manually
git diff HEAD HEAD~ | patch -p1
git add --all
git commit -m "Revert latest commit"


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

###### ANCHOR: cheatsheet-tag
# Remplacez "MonEtiquette" par le nom de votre choix
git tag MonEtiquette
###### ANCHOR_END: cheatsheet-tag

###### ANCHOR: cheatsheet-tag-with-commit
# Remplacez "MonEtiquette" par le nom de votre choix et "CommitCible" par le
# commit de votre choix, par exemple "HEAD~" pour le parent du commit actif.
git tag MonEtiquette CommitCible
###### ANCHOR_END: cheatsheet-tag-with-commit

###### ANCHOR: cheatsheet-tag-annotate
# Remplacez "MonEtiquette" par le nom de votre choix et "CommitCible" par le
# commit de votre choix (ou enlevez ce paramètre pour cibler le commit actif).
#
# Cette commande ouvre un éditeur de texte pour vous permettre de saisir la
# description, utilisez "-m" pour la saisir directement dans la commande.
git tag --annotate MonEtiquette CommitCible
###### ANCHOR_END: cheatsheet-tag-annotate

###### ANCHOR: cheatsheet-tag-delete
# Vous pouvez spécifier autant de noms d'étiquettes que vous voulez en paramètre
# de cette commande, elles seront toutes supprimées d'un coup.
git tag --delete Etiquette1 Etiquette2 Etiquette3
###### ANCHOR_END: cheatsheet-tag-delete

###### ANCHOR: cheatsheet-show
# Remplacez "CommitCible" par un identifiant du commit dont vous voulez afficher
# les propriétés : un nom d'étiquette, de branche, HEAD~N, un hash de commit...
git show CommitCible
###### ANCHOR_END: cheatsheet-show

###### ANCHOR: cheatsheet-checkout
# Remplacez "CommitCible" par un identifiant du commit
git checkout CommitCible
###### ANCHOR_END: cheatsheet-checkout

###### ANCHOR: cheatsheet-revert
# Vous pouvez spécifier autant de commits que vous voulez en paramètre de
# cette commande, les annulations seront effectuées dans l'ordre indiqué.
#
# Pour éviter des conflits, il faut généralement lister les commits à annuler
# du plus récent au plus ancien, mais voir aussi la commande suivante.
#
# Contrairement aux autres commandes qui créent des commits,
git revert Commit3 Commit2 Commit1
###### ANCHOR_END: cheatsheet-revert

###### ANCHOR: cheatsheet-revert-range
# Attention, si le commit A n'est pas un ancêtre de B, ou plus généralement
# si vous passez en paramètre de git revert un commit qui n'est pas un parent
# du commit actif, le comportement sera un peu contre-intuitif.
#
# L'explication précise dépasse hélas le cadre de ce chapitre.
git revert A..B
###### ANCHOR_END: cheatsheet-revert-range
}
unset -f test_this_manually


git tag before-commit-amend
###### ANCHOR: commit-amend
echo 'Du nouveau !' > NouveauContenu.txt
git add NouveauContenu.txt
git commit --amend -m 'Une version avec plus de contenu'
###### ANCHOR_END: commit-amend
git reset --hard before-commit-amend
git tag -d before-commit-amend


###### ANCHOR: stash
echo 'Demandez le programme !' >> AutreContenu.txt
# Avant : Changements visibles au sein du répertoire de travail
git status
git stash
# Après : Changements mis de côté, le répertoire de travail est propre
git status
###### ANCHOR_END: stash

###### ANCHOR: stash-list
git stash list
###### ANCHOR_END: stash-list

###### ANCHOR: stash-pop
git stash pop
###### ANCHOR_END: stash-pop
git checkout HEAD AutreContenu.txt
