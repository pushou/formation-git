#!/bin/bash
#
# Ce script contient les commandes du corrigé de l'exercice du TP4, ce qui
# permet de rejouer facilement ces commandes pour vérifier l'absence de
# nouvelles erreurs, de nouveaux conseils git, etc. en comparant la sortie à un
# fichier de référence .ref généré précédemment.
#
# Tout ça peut être fait via un simple "make" dans un environnement utilisateur
# fraîchement initialisé.
#
set -euxo pipefail
IFS=$'\n\t'

###### ANCHOR: clone-repo
git clone ~/Desktop/MonDepot ~/Desktop/Exercice4
###### ANCHOR_END: clone-repo

###### ANCHOR: ls-origin
cd ~/Desktop/MonDepot/
ls -al
###### ANCHOR_END: ls-origin

###### ANCHOR: ls-clone
cd ../Exercice4/
ls -al
###### ANCHOR_END: ls-clone

function test_this_manually() {
###### ANCHOR: visualize-and-switch-to-origin
gitg &
cd ../MonDepot
gitg &
###### ANCHOR_END: visualize-and-switch-to-origin
}
unset -f test_this_manually
cd ../MonDepot

###### ANCHOR: create-and-fill-branch
git checkout -b test
echo 'Le contenu' > AutreContenu.txt
git add AutreContenu.txt
git commit -m 'Un commit de test'
echo 'Plus de contenu' >> AutreContenu.txt
git add AutreContenu.txt
git commit -m 'Un autre commit de test'
###### ANCHOR_END: create-and-fill-branch

###### ANCHOR: goto-clone-and-fetch
cd ../Exercice4
git fetch origin
###### ANCHOR_END: goto-clone-and-fetch

###### ANCHOR: remote-branch-checkout-shortcut
git checkout test
###### ANCHOR_END: remote-branch-checkout-shortcut

###### ANCHOR: add-more-commits-to-branch
echo "Renouvelons l'offre" > NouveauFichier.txt
git add NouveauFichier.txt
git commit -m "Ajout d'un fichier"
echo 'Renouvelons la demande' >> NouveauFichier.txt
git add NouveauFichier.txt
git commit -m "Complétion d'un fichier"
###### ANCHOR_END: add-more-commits-to-branch

###### ANCHOR: goto-origin-and-make-clone-remote
cd ../MonDepot
git remote add copieur ~/Desktop/Exercice4
###### ANCHOR_END: goto-origin-and-make-clone-remote

###### ANCHOR: pull-branch-from-clone
git pull copieur test
###### ANCHOR_END: pull-branch-from-clone

###### ANCHOR: checkout-main-and-add-commits
git checkout main
echo 'Je ne sais quoi inventer' > Incertitude.txt
git add Incertitude.txt
git commit -m 'Méditation'
echo 'Je ne sais quoi penser' >> Incertitude.txt
git add Incertitude.txt
git commit -m 'Moment philosophique'
###### ANCHOR_END: checkout-main-and-add-commits

###### ANCHOR: push-branch-to-clone
git push copieur test
###### ANCHOR_END: push-branch-to-clone

###### ANCHOR: merge-origin-main-to-clone-test
cd ../Exercice4
git fetch origin
git merge origin/main
###### ANCHOR_END: merge-origin-main-to-clone-test

cd ~
rm -rf ~/Desktop/Exercice4
