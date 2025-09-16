#!/bin/bash
#
# Ce script contient l'ensemble des commandes exécutées par les utilisateurs
# durant le TP4, ce qui permet de rejouer facilement ces commandes pour vérifier
# l'absence de nouvelles erreurs, de nouveaux conseils git, etc. en comparant la
# sortie à un fichier de référence .ref généré précédemment.
#
# Tout ça peut être fait via un simple "make" dans un environnement utilisateur
# fraîchement initialisé.
#
set -euxo pipefail
IFS=$'\n\t'


function test_this_manually() {
###### ANCHOR: restore-from-zip
cd ~/Desktop \
&& rm -rf TP4.zip ArchivesTPs/TP3 \
&& mkdir -p ArchivesTPs/TP3 \
&& if [[ -e MonDepot ]]; then mv MonDepot ArchivesTPs/TP3; fi \
&& if [[ -e MesBranches ]]; then mv MesBranches ArchivesTPs/TP3; fi \
&& wget https://grasland.pages.in2p3.fr/formation-git/TP4.zip \
&& unzip TP4.zip \
&& rm TP4.zip
###### ANCHOR_END: restore-from-zip
}
unset -f test_this_manually


###### ANCHOR: clone
cd ~/Desktop
git clone MesBranches MonClone
cd MonClone
###### ANCHOR_END: clone

###### ANCHOR: status-after-clone
git status
###### ANCHOR_END: status-after-clone

###### ANCHOR: remote
git remote
###### ANCHOR_END: remote

###### ANCHOR: remote-verbose
git remote -v
###### ANCHOR_END: remote-verbose

###### ANCHOR: remote-show
git remote show origin
###### ANCHOR_END: remote-show


###### ANCHOR: first-remote-commit
cd ../MesBranches
echo 'Nouveau dans votre ville !' > ToutNouveau.txt
git add ToutNouveau.txt
git commit -m "Ajout d'un nouveau fichier"
###### ANCHOR_END: first-remote-commit

set +e
###### ANCHOR: no-file-change-in-clone
cd ../MonClone
# Cette commande échouera car le fichier n'existe pas
cat ToutNouveau.txt
###### ANCHOR_END: no-file-change-in-clone
set -e

###### ANCHOR: no-branch-change-in-clone
git diff origin/univers-parallele
###### ANCHOR_END: no-branch-change-in-clone

###### ANCHOR: first-fetch
git fetch origin
###### ANCHOR_END: first-fetch

set +e
###### ANCHOR: file-still-missing
# Cette commande continue d'échouer car le fichier n'existe toujours pas
cat ToutNouveau.txt
###### ANCHOR_END: file-still-missing
set -e

###### ANCHOR: branch-changed-in-clone
git diff origin/univers-parallele
###### ANCHOR_END: branch-changed-in-clone

###### ANCHOR: fast-forward-parallel-merge
git merge --ff-only origin/univers-parallele
# Le fichier arrive enfin dans le répertoire de travail (et la branche active)
cat ToutNouveau.txt
###### ANCHOR_END: fast-forward-parallel-merge


###### ANCHOR: first-pull
cd ../MesBranches
echo 'Demandez le programme !' >> ToutNouveau.txt
git add ToutNouveau.txt
git commit -m 'Du contenu supplémentaire'

cd ../MonClone
git pull origin univers-parallele
cat ToutNouveau.txt
###### ANCHOR_END: first-pull


###### ANCHOR: status-after-pull
git status
###### ANCHOR_END: status-after-pull

###### ANCHOR: checkout-nonexistent-main
git checkout main
###### ANCHOR_END: checkout-nonexistent-main

###### ANCHOR: very-verbose-branch
git branch --list -vv
###### ANCHOR_END: very-verbose-branch


###### ANCHOR: push-remote-branch
git push origin main
###### ANCHOR_END: push-remote-branch

###### ANCHOR: push-remote
echo 'Hallo !' > HelloWorld.txt
git add HelloWorld.txt
git commit -m 'Traduction allemande'
git push origin
###### ANCHOR_END: push-remote

###### ANCHOR: log-after-first-pushes
cd ../MesBranches
git log main
###### ANCHOR_END: log-after-first-pushes

###### ANCHOR: push-shorthand
cd ../MonClone
echo 'Konnichi-wa !' > HelloWorld.txt
git add --all
git commit -m 'Traduction japonaise'
###### ANCHOR: push-shorthand-only
git push
###### ANCHOR_END: push-shorthand-only
###### ANCHOR_END: push-shorthand

###### ANCHOR: push-auto-setup-remote
git config --global push.autoSetupRemote true
###### ANCHOR_END: push-auto-setup-remote


###### ANCHOR: new-clone-and-add-remote
git clone ../MesBranches ../MonAutreClone
git remote add autre ../MonAutreClone
git remote -v
###### ANCHOR_END: new-clone-and-add-remote

###### ANCHOR: fetch-all
git fetch --all
###### ANCHOR_END: fetch-all


###### ANCHOR: divergence-before-pull
# Création d'un commit sur la branche main de MonAutreClone...
cd ../MonAutreClone
git checkout main
echo '1' > Compteur.txt
git add Compteur.txt
git commit -m "Ajout d'un compteur"

# ...que l'on pousse sur la branche main de MesBranches
git push

# Création d'un autre commit sur la branche main de MonClone
cd ../MonClone
echo 'Prost !' > HelloWorld.txt
git add HelloWorld.txt
git commit -m 'Disons bonjour plus joyeusement'
###### ANCHOR_END: divergence-before-pull

function test_this_manually() {
###### ANCHOR: pull-merges-divergence
# Cette commande vous invitera à saisir une description pour le commit de fusion
###### ANCHOR: implicit-pull
git pull
###### ANCHOR_END: implicit-pull
###### ANCHOR_END: pull-merges-divergence
}
unset -f test_this_manually
git fetch --all
git merge -m "Une fusion inattendue" origin/main

set +e
###### ANCHOR: push-rejects-divergence
git reset --hard @{1}
# Cette commande échouera, on ne peut pas pousser une branche divergente
git push autre
###### ANCHOR_END: push-rejects-divergence
set -e


set +e
###### ANCHOR: pull-conflict
echo '2' > Compteur.txt
git add Compteur.txt
git commit -m 'Un autre commit qui modifie Compteur.txt'
# Conflit de fusion car Compteur.txt est modifié des deux côtés de la divergence
git pull
###### ANCHOR_END: pull-conflict
set -e

###### ANCHOR: config-pull-ff-only
git config --global pull.ff only
###### ANCHOR_END: config-pull-ff-only



function test_this_manually() {
###### ANCHOR: cheatsheet-clone
# Remplacez CheminDistant par le chemin sur disque ou l'URL du dépôt à cloner.
# DossierDestination est optionnel et permet de nommer le dossier qui sera créé
# pour contenir le clone, par défaut il aura le même nom que le dépôt source.
git clone CheminDistant DossierDestination
###### ANCHOR_END: cheatsheet-clone

###### ANCHOR: cheatsheet-remote-show
# Remplacez NomRemote par le nom de la remote sur laquelle vous voulez afficher
# des informations détaillées.
git remote show NomRemote
###### ANCHOR_END: cheatsheet-remote-show

###### ANCHOR: cheatsheet-remote-add
# Remplacez NomRemote par le nom que vous voulez donner à la nouvelle remote et
# CheminDistant par le chemin sur disque ou l'URL du dépôt à ajouter en remote.
git remote add NomRemote CheminDistant
###### ANCHOR_END: cheatsheet-remote-add

###### ANCHOR: cheatsheet-fetch-remote
# Remplacez NomRemote par le nom de la remote dont vous voulez télécharger les
# commits et mettre à jour les branches locales
git fetch NomRemote
###### ANCHOR_END: cheatsheet-fetch-remote

###### ANCHOR: cheatsheet-explicit-pull
# Remplacez NomRemote par le nom d'une remote et NomBranche par le nom local
# d'une branche sur cette remote (ex: main, pas NomRemote/main).
git pull NomRemote NomBranche
###### ANCHOR_END: cheatsheet-explicit-pull

###### ANCHOR: cheatsheet-implicit-pull-ff-only
git pull --ff-only
###### ANCHOR_END: cheatsheet-implicit-pull-ff-only

###### ANCHOR: cheatsheet-explicit-push
# Remplacez NomRemote par le nom d'une remote et ListeDeNoms par une liste de
# noms de branches et étiquettes séparés par des espaces.
git push NomRemote ListeDeNoms
###### ANCHOR_END: cheatsheet-explicit-push

###### ANCHOR: cheatsheet-push-set-upstream
# Remplacez NomRemote par le nom d'une remote et NomBranche par le nom d'une
# branche dont vous voulez créer ou mettre à jour une copie sur cette remote.
git push --set-upstream NomRemote NomBranche
###### ANCHOR_END: cheatsheet-push-set-upstream

###### ANCHOR: cheatsheet-push-by-remote
# Remplacez NomRemote par le nom d'une remote
git push NomRemote
###### ANCHOR_END: cheatsheet-push-by-remote


###### ANCHOR: force-push
git push --force
###### ANCHOR_END: force-push


###### ANCHOR: push-delete
# Remplacez NomRemote par le nom d'une remote et NomBranche par le nom d'une
# branche ou étiquette que vous voulez détruire sur cette remote.
git push --delete NomRemote NomBranche
###### ANCHOR_END: push-delete

###### ANCHOR: push-delete-legacy
git push --delete NomRemote :NomBranche
###### ANCHOR_END: push-delete-legacy

###### ANCHOR: fetch-prune
git fetch --prune
###### ANCHOR_END: fetch-prune

###### ANCHOR: config-fetch-prune
git config --global fetch.prune true
###### ANCHOR_END: config-fetch-prune


###### ANCHOR: push-tag
# Remplacez NomRemote par le nom d'une remote et NomEtiquette par le nom d'une
# étiquette que vous voulez mettre en ligne sur cette remote.
git push NomRemote NomEtiquette
###### ANCHOR_END: push-tag
}
unset -f test_this_manually
