# Configuration de la VM

## Configuration côté VirtualBox

- **2 coeurs CPU :** Supporté par la grande majorité des machines hôtes
  actuelles, et permet un GUI plus fluide dans la VM.
- **2 Go de RAM :** 512 Mo suffirait pour une stricte utilisation d'un terminal
  + gitg + meld, mais 2 Go permet un surf web plus confortable dans la VM tout
  en restant supporté par la grande majorité des machines hôtes actuelles (les
  PCs avec moins de 4 Go de RAM sont rares aujourd'hui).
- **6 Go de disque :** Un système installé ne prend que 4.1 Go, donc en principe
  5 Go devrait suffire, mais en pratique l'installeur openSUSE ne supprime pas
  les paquets RPM avant la fin de l'installation et il faut donc plus de place
  au niveau de l'image disque VirtualBox.
- **Presse-papier partagé :** Permet d'avoir un lecteur PDF sur l'hôte et de
  copier coller les lignes de commande du TP dans la VM.
- **64 Mo de mémoire vidéo :** J'ai déjà eu des problèmes graphiques avec le
  réglage par défaut de 16 Mo, et 64 Mo est empiriquement supporté par tous les
  hôtes que j'ai croisés.
- **Interface utilisateur :** Enlever tout ce qui n'a aucune chance de servir
  durant la formation pour éviter d'impressionner les gens qui n'ont pas
  l'habitude de VBox et diminuer le risque de fausse manip.

## Configuration de l'OS

Je suis parti sur openSUSE car c'est la distrib avec laquelle j'ai le plus
d'expérience. La forme à release fixe (Leap) est appropriée pour une machine
virtuelle "jetable" comme celle-ci.

J'ai fait une configuration à base de bureau Xfce car c'est un bon compromis
entre taille de la VM, niveau de fonctionnalité, familiarité pour ceux qui
n'utilisent pas Linux quotidiennement, et qualité du support offert par la
distribution pour l'environnement de bureau.

Le TP1 contient la liste des logiciels à ne pas oublier durant l'installation.
Vérifier aussi que les paquets invités de VirtualBox (`virtualbox-guest-*`) sont
bien installés dans la VM.

J'ai aussi configuré l'environnement de bureau pour qu'il soit aussi focalisé
sur la formation que possible, notamment en désactivant les fonctionalités
d'économiseur d'écran (redondantes avec le PC hôte) et en désactivant les
notifications de mise à jour système.

J'ai également ajouté des signets au navigateur web pour `gitlab.in2p3.fr` et
les supports de la formation git.