# Supports stagiaires de la formation git

Ce dossier contient des documents prêts à l'emploi pour les participants à la
formation git. On y trouve les éléments suivants :

- Les planches théoriques présentées au début de chaque séquence
- Les dépôts git utilisés pour les démonstrations d'outils interactifs
- Des sauvegardes de l'état attendu à la fin de chaque TP, pouvant être
  utilisées pour revenir en terrain connu en cas de retard ou de problème
- Deux scripts pour pratiquer l'utilisation de `git bisect`.
  * `generate_bisect_repo.sh` est appelé avec un paramètre de taille entre 2 et
    15 et génère automatiquement un dépôt git "bisect" où quelque chose a mal
    tourné à un certain point de l'historique, cet événement étant simulé par
    l'apparition de "Bad commits" dans le contenu du dépôt. Le dépôt contient
    également un commit inclassable (ni bon ni mauvais du point de vue du
    critère habituel).
  * `bisect_runner.sh` est un exemple de script permettant d'utiliser `git
    bisect run` dans le dépôt ci-dessus.

Les énoncés de travaux pratique, qui étaient précédemment dans ce dossier, sont
désormais mis en ligne sous forme de site statique. Vous les trouverez à
l'adresse <https://grasland.pages.in2p3.fr/formation-git/>.
