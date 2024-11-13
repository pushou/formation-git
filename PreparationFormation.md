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

- Corriger un max d'issues gitlab des années précédentes
- Faire un ticket exploitation IJCLab pour config OS et comptes
    * Configuration OS (si machines réinstallées depuis l'an dernier)
        - Installations : `bash-completion git gitg meld nano vim emacs gedit
          wget unzip`
        - Partition /scratch sur disque local pour démo IO-intensive
    * 20 comptes utilisateurs pour les stagiaires et un pour moi-même
        - Nommage : formation-git-N avec N de 1 à 21
        - Peuvent être supprimés dès le lendemain de la formation
    * Utiliser routine CI pour test


## 1 mois avant fermeture des inscriptions

- Point inscriptions avec IFSeM + lancer commande cafés CROUS
- Faire pub sur LoOPS et forum IJCLab, cf MailPub.md pour squelette


## Après fermeture des inscriptions

- Sélectionner les candidats si besoin
    * Bien préciser à l'IFSeM qu'on fournit les postes informatiques
- Prévenir le CESFO en leur envoyant la liste des inscrits, leur demander qui
  n'est pas éligible au remboursement employeur + tarif extérieur
- Préparer un groupe de contacts global dans Thunderbird
- Leur envoyer un mail de bienvenue
    * Instructions bâtiment 203 : coordonnées GPS, chemin depuis accueil 200,
      balisage papier si la météo le permet
    * CESFO : si pas badge...
        - Attestation employeur via RH (attention bulletin de salaire pas OK)
        - Prévoir argent liquide ou chéquier
        - Prévenir ceux qui ne seront pas au tarif employeur séparément
    * Créer compte GitHub + prévoir identifiants
    * Test eduGAIN (cf début TP5, les pointer dessus ?) + prévoir identifiants
    * Appel à suggestion pour temps à la carte


## Demi-journée test/config salle

- Vérifier toilettes
    * Lavabo, chasse d'eau
    * Remplissage savon, PQ, essuie-mains
- Vérifier chauffages
    * Nombreuses DEL grillées, donc mettre en route tôt pour sentir le chaud
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
        - Mettre supports, source et dépôts DDHC GitHub/GitLab en bookmark
    * Sur le PC prof, augmenter timeout extinction écran / logout
    * A la fin, fermer la session mais garder le PC allumé pour le SSH


## Quand supports finalisés

- Faire une passe hunspell/grammalecte
- Faire test automatique sur compte prof via SSH (cf CI)
- Reconfigurer compte prof (mail, username, editor, default branch...)
- Remise à zéro contenu et PR/MR dépôts DDHC GitHub et GitLab
- Mettre copie locale des supports sur bureau compte prof (via artefacts CI)
- Préparer un slide d'accueil, le mettre sur le bureau du compte prof
    * Utilisez les PC de la salle, ils sont pré-configurés
    * Votre compte est formation-git-N avec N le numéro de PC (cf étiquette
      ld-ensN ou voisins)
    * Pour obtenir votre mdp ...
    * Les supports sont sur https://grasland.pages.in2p3.fr/formation-git


## La veille de la formation

- Installer balisage (flèches dans pochettes plastiques + scotch transparent)
- Allumer radiateurs en eco
- Alarmes matin pour passage en confort
- Alarmes soir pour passage en eco, sauf dernier soir hors-gel et nettoyage
- Imprimer supports papier que j'ai actualisés ou récupérer année précédente
- Connecter GitHub et GitLab sur PC prof pour gagner du temps


## Le dernier jour de la formation

- Vérifier que la salle est propre et que personne n'a rien oublié
- Déconnecter ou redémarrer les PCs
- Eteindre les écrans, les lumières, le vidéoprojecteur
- Mettre radiateur en hors-gel
- Fermer les volets
- Nettoyer tableaux et autres supports "sales"
- Vider ce que je peux de la partition /scratch de ma machine


## Peu après la formation

- Vider ce que je peux de la partition /scratch des autres machines
- Ping exploit pour suppression des comptes utilisateur + scratch si besoin
- Supprimer les clés SSH enregistrées sur GitHub, GitLab
