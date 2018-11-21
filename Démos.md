Pour la démo de nano (TP1), il faut montrer :

- L'ouverture d'un fichier
- Les raccourcis clavier en bas
- La procédure pour fermer un fichier modifié avec ou sans enregistrement

Pour la première démo de gitg (TP2), il faut montrer :

- Le mode de lancement (dans le dépôt ou graphiquement)
- L'organisation générale de l'interface
    * Bandeau de commandes en haut, menu, préférences
    * Panneau des branches (rapidement, montrer juste "Tous les commits")
    * Vue du graphe de commits
    * Vue d'un commit: auteur, description, hash et diff
- Le comportement dans le shell (prise de contrôle, warnings stupides)
- Le rafraîchissement de l'interface (manuel via Ctrl+R)
- Les menus contextuels

Pour la deuxième démo de gitg (TP3), il faut montrer :

- Le panneau des branches plus en détail (vue des différentes branches)
- Intérêt de l'affichage "Tous les commits"
- Fusion compatible -> master + rafraîchissement
- Affichage des deux parents des commits de merge
- Fusion conflit -> master qui échoue : transition vers démo de meld

Pour la démo de meld (TP3), il faut montrer :

- Le mode de lancement sur un dossier
- L'interface de vue des fichiers et ses codes visuels (couleurs, rayures)
- L'interface de vue d'un diff et ses codes visuels:
    * Convention gauche/droite
    * Sens des annotations de marge
    * Codes couleur (vert = nouveau, bleu = différent, rouge = conflit)
    * "Ajout des deux côtés" avec ctrl+clic
- Les pièges de l'outil:
    * Nécessité de le pointer sur un dossier
    * Nécessité de fermer l'onglet actif avant de fermer le programme

Pour la troisième démo de gitg (TP4), il faut montrer :

- La gestion des remotes
    * Affichage de celles-ci dans l'interface (à gauche, au milieu...)
    * Nécessité de fetch/push, voire menu contextuel associé

Pour la démo de GitHub (TP5), il faut montrer :

- Un dépôt un peu riche (ex: https://github.com/spack/spack )
- La visualisation du dépôt
    * Arborescence des fichiers + coloration
    * Historique des versions
    * Sélection de branches
    * Section "releases"
- La gestion de tickets
- La création de forks
- Les pull requests (démo avec francine-dupont)
    * Soumission
    * Conversation
    * Différences et commentaires
    * Intégration continue (on revient sur spack/spack)