#!/bin/bash
#
# Ce script contient l'ensemble des commandes exécutées par les utilisateurs
# durant le TP4, ce qui permet de rejouer facilement ces commandes pour...
# 
# - Vérifier l'absence de nouvelles erreurs, de nouveaux conseils git, etc. en
#   comparant la sortie au fichier de référence .ref.
# - Régénérer facilement l'archive de rattrapage de fin de TP4 (et autres TPs)
#
# Tout ça peut être fait via un simple "make" dans un environnement utilisateur
# fraîchement initialisé.
#
set -euxo pipefail
IFS=$'\n\t'


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


# WIP