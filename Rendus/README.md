# Supports stagiaires de la formation git

Ce dossier contient des documents prêts à l'emploi pour les participants à la
formation git. On y trouve les éléments suivants :

- Les planches théoriques présentées au début de chaque séquence
- Les dépôts git utilisés pour les démonstrations d'outils interactifs
- Les énoncés des travaux pratiques
- Des sauvegardes de l'état attendu à la fin de chaque TP, pouvant être
  utilisées pour revenir en terrain connu en cas de retard ou de problème
- Deux scripts pour pratiquer l'utilisation de `git bisect`.
  * `generate_bisect_repo.sh` est appelé avec un paramètre de taille entre 2 et
    15 et génère automatiquement un dépôt git "bisect" où quelque chose a mal
    tourné à un certain point de l'historique, cet événement étant simulé par
    l'apparition de "Bad commits" dans le contenu du dépôt. Le dépôt contient
    également un commit inclassable (ni bon ni mauvais du point de vue du
    critère habituel).
  * `bisect_runner.sh` est un exemple de script permettant d'utiliser
    `git bisect run` dans le dépôt ci-dessus.

En raison d'une limite à la taille de fichiers mis en ligne sur le Gitlab IN2P3,
l'image de la machine virtuelle utilisée pour les travaux pratique ne peut plus
être stockée au sein de ce dépôt, même via LFS. Vous la retrouverez à l'addresse
https://box.in2p3.fr/index.php/s/aKFtraYLxRgZTQY .

**Attention :** L'édition 2022 de la formation git ayant été effectuée
directement sur des machines Linux physiques, la machine virtuelle ci-dessus
n'est actuellement pas à jour par rapport à la dernière version du TP. Si vous
souhaitez travailler avec elle, je vous conseille d'utiliser
[la version 2021 des supports](https://gitlab.in2p3.fr/grasland/formation-git/-/tree/2021/Rendus).
