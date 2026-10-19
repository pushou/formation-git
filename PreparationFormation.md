# Préparation de la formation

## Dès que possible, avant l'été

- Choisir un créneau en 2e moitié d'année
- Réserver le bâtiment 203 pour ce créneau + 1/2 jour de test/config salle
  * Peu avant sinon des problèmes risquent d'apparaître après le test
  * Mais assez de temps pour faire régler les soucis infra/exploit éventuels
  * ~15j avant est un bon compromis en pratique ?
- Vérifier programme sur Descriptif.md, mettre à jour si besoin
- Transmettre créneau + màj descriptif éventuelle à l'IFSeM pour ouverture des
  inscriptions


## 1-2 mois avant formation

- Commencer à corriger un max d'issues gitlab des années précédentes
- Faire un ticket exploitation IJCLab pour config OS et comptes
  * Si les machines ont été réinstallées depuis l'an dernier (typiquement lors
    d'un changement de LTS Ubuntu) il faut...
      1. Demander à l'exploit de refaire la configuration
        - Installations : `bash-completion git meld nano vim emacs gedit wget unzip`
          + SourceGit via dépôt debian ou AppImage
        - Partition /scratch sur disque local pour démo IO-intensive
      2. S'il y a lieu, changer la [version d'Ubuntu utilisée en CI](Dockerfile)
         et passer en revue les changements de sortie git qui se traduiront par
         des échecs CI (on veut le savoir quand la nouvelle version de git émet
         des warnings qui n'étaient pas là avant, etc).
  * Dans tous les cas, prévoir 20 comptes utilisateurs pour les stagiaires et
    deux pour Sonny et moi
    - Nommage : formation-git-N avec N de 1 à 22
    - Peuvent être supprimés dès le lendemain de la formation, cf plus loin
    - Se répartir rapidement les comptes prof, idéalement changer leurs mdps
      (mais aux dernières nouvelles ce n'était pas possible :( A rediscuter avec
      l'exploit).


## 1 mois avant fermeture des inscriptions

- Faire un point sur les inscriptions avec l'IFSeM
- Faire de la pub sur LoOPS et forum IJCLab, cf MailPub.md pour squelette


## Après fermeture des inscriptions

- Sélectionner les candidats si besoin
  * Bien préciser à l'IFSeM qu'on fournit 20 postes informatiques
- Prévenir le CESFO en leur envoyant la liste des inscrits + Hadrien pour 2026
  (n'a plus de carte de cantine), leur demander qui n'est pas éligible au
  remboursement employeur + tarif extérieur
- Préparer une mailing list avec les stagiaires (peut être un simple groupe de
  contacts dans le client mail des profs, vu le faible nombre de profs)
- Leur envoyer un mail de bienvenue
  * Accès au bâtiment 203 : coordonnées GPS, chemin depuis accueil 200, indiquer
    qu'on fera un balisage papier si la météo le permet
  * Rappeler qu'on fournit les PCs
  * Mentionner que l'IFSeM ne paie plus le café => Machine à CB au B200
  * CESFO : si pas badge...
    - Attestation employeur via RH (attention bulletin de salaire pas OK)
    - Prévoir argent liquide ou chéquier
    - Prévenir ceux qui ne seront pas au tarif employeur séparément
  * Créer compte GitHub + prévoir identifiants
  * Test eduGAIN (cf début partie 2, les pointer dessus ?) + prévoir
    identifiants
  * Appel à suggestion pour temps à la carte


## Demi-journée test/config salle

- Vérifier toilettes
  * Lavabo, chasse d'eau
  * Remplissage savon, PQ, essuie-mains
- Vérifier chauffages
  * Nombreuses DEL de statut des radiateurs grillées, donc les mettre en
    arrivant pour sentir le chaud en partant
  * Le thermomètre du capteur de CO2 peut aussi aider
- Vérifier vidéoprojecteurs et pointeur PC prof
  * Projeter quelques slides pour vérifier rendu couleurs, vérifier réglages
    si c'est trop illisible (luminosité !)
- Vérifier ouverture/fermeture volets et fenêtres
- Tester chaque PC de la salle avec le compte utilisateur associé
  (formation-git-N pour machine ld-ensN) et configurer chaque compte
  * Couper le son
  * Contrôler version Ubuntu, màj CI si besoin
  * Réduire les icônes dock à explorateur + firefox + terminal (à ajouter)
  * Vérifier fonctionnement de ces trois applis
  * Pour Firefox...
    - Valider le spam de bienvenue
    - Enlever les icônes pocket/sync inutiles + merdes écran d'accueil
    - Désactiver la traduction dans about:config
    - Paramétrer pour désactiver tout enregistrement d'info perso (sauf PC
      prof où on garde les cookies de session mais on change le mdp)
    - Mettre supports, source et dépôts TPs GitHub/GitLab en bookmark
  * Sur le PC prof, augmenter timeout extinction écran / logout
  * A la fin, fermer la session mais garder le PC allumé pour le SSH


## Quand supports finalisés

- Faire une passe hunspell/grammalecte
- Faire test automatique sur compte prof via SSH (cf CI)
- Reconfigurer compte prof (mail, username, editor, default branch...)
- Remise à zéro contenu et PR/MR dépôts livre de recette GitHub et GitLab +
  supprimer dépôts dans groupe Git kitchen ?
- Mettre copie locale des supports sur bureau compte prof (via artefacts CI)
- Préparer un slide d'accueil, le mettre sur le bureau du compte prof
  * Utilisez les PC de la salle, ils sont pré-configurés
  * Votre compte est formation-git-N avec N le numéro de PC (cf étiquette
    ld-ensN ou voisins)
  * Pour obtenir votre mdp ...
  * Les supports sont sur <https://grasland.pages.in2p3.fr/formation-git>


## La veille/le vendredi avant

- Installer balisage si la météo le permet (flèches dans pochettes plastiques +
  scotch transparent)
- Allumer radiateurs en eco (seulement possible si la formation ne démarre pas
  le lundi, sinon tant pis on allumera le jour même et ça prendra du temps)
- Alarmes matin pour passage en confort
- Alarmes soir pour passage en eco, sauf dernier soir hors-gel et nettoyage
- Imprimer supports papier actualisés ou récupérés de l'année précédente (cf
  [Démos.odt](Démos.odt), [Planning.ods](Planning.ods), et [Quiz.odt](Quiz.odt)
  en 4 pages par feuille double face)
- Connecter comptes GitHub et GitLab sur PC prof pour gagner du temps ?
  Seulement si le problème du mdp qu'on ne peut pas changer est résolu...


## Le dernier jour de la formation

- Vérifier que la salle est propre et que personne n'a rien oublié
- Déconnecter ou redémarrer les PCs
- Eteindre les écrans, les lumières, le vidéoprojecteur
- Mettre radiateur en hors-gel
- Fermer les volets
- Nettoyer tableaux et autres supports "sales"
- Vider ce qu'on peut de la partition /scratch de la machine prof


## Peu après la formation

- Vider ce qu'on peut de la partition /scratch des autres machines
- Ping exploit pour suppression des comptes utilisateur + scratch si besoin
- Supprimer les clés SSH enregistrées sur GitHub, GitLab
