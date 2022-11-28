# Configuration de la VM

## Configuration côté VirtualBox

- **Firmware BIOS :** Au 26/11/2021, VirtualBox n’exporte pas correctement la
  configuration UEFI lors de l’export du fichier OVA, ce qui rend l’image non
  bootable (ou plutôt difficilement bootable) après réimport.
- **2 cœurs CPU :** Supporté par la grande majorité des machines hôtes
  actuelles, et permet un GUI plus fluide dans la VM.
- **4 Go de RAM :** 512 Mo suffirait pour une stricte utilisation d’un terminal
  + gitg + meld, mais 4 Go permet un surf web confortable dans la VM tout
  en restant supporté par la grande majorité des machines hôtes actuelles (les
  PCs avec moins de 8 Go de RAM deviennent rares).
- **7 Go de disque :** Ne pas oublier, dans le budget disque, l'espace
  nécessaire aux paquets RPM téléchargés pendant l'installation, ainsi que les
  512Mo de la partition de démarrage UEFI.
- **Presse-papier partagé :** Permet d’avoir un lecteur PDF sur l’hôte et de
  copier coller les lignes de commande du TP dans la VM.
- **128 Mo de mémoire vidéo :** J’ai déjà eu des problèmes graphiques avec le
  réglage par défaut de 16 Mo, et 128 Mo est supporté par tous les
  hôtes que j’ai croisés.
- **Interface utilisateur :** Enlever tout ce qui n’a aucune chance de servir
  durant la formation pour éviter d’impressionner les gens qui n’ont pas
  l’habitude de VirtualBox et diminuer le risque de fausse manip.

## Configuration de l’OS

Je suis parti sur openSUSE, car c’est la distribution avec laquelle j’ai le
plus d’expérience. La forme à _release_ fixe (Leap) est appropriée pour une
machine virtuelle « jetable » comme celle-ci.

J’ai fait une configuration à base de bureau Xfce, car c’est un bon compromis
entre taille de la VM, niveau de fonctionnalité, familiarité pour ceux qui
n’utilisent pas Linux quotidiennement, et qualité du support offert par la
distribution pour l’environnement de bureau.

Le TP1 contient la liste des logiciels à ne pas oublier durant l’installation.
Vérifier aussi que les paquets invités de VirtualBox (`virtualbox-guest-*`) sont
bien installés dans la VM.

J’ai aussi configuré l’environnement de bureau pour qu’il soit aussi focalisé
sur la formation que possible, notamment en désactivant les fonctionnalités
d’économiseur d’écran (redondantes avec le PC hôte) et en désactivant les
notifications de mise à jour système.

Faire un `sudo usermod -aG vboxsf formation-git` pour que les dossiers partagés
de VirtualBox fonctionnent.

Ne pas oublier de faire un `zypper clean -a` après la mise à jour finale pour
diminuer le poids de la VM sur le disque (et donc au téléchargement…). Je
conseille aussi un `rm ~/.bash_history` pour ne pas perturber les gens avec ma
sorcellerie préparatoire.

J’ai également ajouté des signets au navigateur web pour `github.com`,
les supports de la formation git, et le dépôt DDHC. Et puis j’enlève le lien
pocket, je bascule sur la page d'accueil de Firefox, et j’enlève les liens
sponsorisés de celle-ci.

## Une fois la VM prête

Ne pas oublier de refaire les TPs sur celle-ci pour vérifier qu’ils marchent
toujours sur la nouvelle version de git, sans nouveaux warnings.

Si un nouveau warning apparaît, amender le texte du TP pour le mentionner et
dire quoi faire lorsqu’il survient.

Et enfin, pour une « propreté » optimale de l’environnement de TP, ne pas oublier
de vider l’historique bash après avoir configuré la VM.

Exporter la VM et mettre à jour le fichier VM-Formation-Git.ova de box.in2p3.fr.
Vérifier que le lien dans le dossier des rendus continue à fonctionner.
