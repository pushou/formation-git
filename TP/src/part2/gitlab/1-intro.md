# Parcours « GitLab fermé »

Dans ce parcours, nous vous proposons d'utiliser la forge GitLab, et plus
précisément [une instance de celle-ci](https://gitlab.in2p3.fr/) qui est
hébergée par le centre de calcul de l'IN2P3.

Parmi les nombreuses instances de GitLab hébergées au sein de la communauté
académique[^gitlab], nous avons choisi celle de l'IN2P3 en raison de sa
politique d'accès inhabituellement généreuse. Contrairement à la plupart des
autres instances de GitLab qui ont un périmètre d'accès très restreint (une
université, un institut, un laboratoire...), elle est en effet facilement
accessible à la plupart des personnels académiques du monde via la [fédération
d'identité eduGAIN](https://technical.edugain.org/status), ce qui en fait un
outil précieux pour les collaborations interdisciplinaires et internationales.
De plus, son hébergement sur sol français la rend pleinement compatible avec les
politiques de gestion de données institutionnelles, y compris lorsqu'on manipule
des données confidentielles.

Dans cet esprit, nous allons utiliser pour cette forge sur un mode de
collaboration fermé où seule l'équipe projet a accès au dépôt git commun. Ce
mode de travail est adapté pour des projets manipulant des données
confidentielles tels que des comptes-rendus de réunions ou des résultats de
recherches non publiés. Et notre projet d'exemple pour illustrer ce type de
collaboration sera l'édition de livres de recettes de cuisine, dont on sait à
quel point ils peuvent être un secret professionnel jalousement gardé !

Pour introduire les concepts en douceur, nous allons procéder en plusieurs temps
:

- Dans un premier temps, nous allons [effectuer la configuration
  requise](2-acces.md) pour que vous puissiez accéder au groupe GitLab privé des
  cuisiniers, et pour que vous puissiez pousser des commits depuis votre machine
  locale vers les dépôts git hébergés au sein de ce groupe.
- Ces accès vous permettront de [contribuer à un dépôt déjà
  existant](3-contribution.md) géré par un des formateurs, et ainsi d'acquérir
  une première expérience des mécanismes de collaboration fournis par GitLab
  dont la fameuse _Merge Request_.
- Il sera ensuite temps pour vous de prendre les commandes et devenir chef
  cuisinier en [créant votre propre dépôt de
  recettes](4-depot-personnel/2-creation-depot.md), ce qui vous permettra de
  [mettre en place une intégration
  continue](4-depot-personnel/3-integration-continue.md) pour vérifier
  automatiquement certains aspects de son contenu.
- Il ne restera alors plus qu'à boucler la boucle en travaillant à nouveau en
  équipe, cette fois au sein de [dépôts sous votre
  contrôle](5-travail-equipe/2-projet-commun.md). En plus de vous donner une
  expérience plus directe du rôle de mainteneur, ce sera aussi l'occasion pour
  vous d'aller plus loin avec l'intégration continue en découvrant le
  [déploiement continu](5-travail-equipe/3-deploiement-continu.md).

[^gitlab]: Rien qu'au sein de la communauté académique française on recense
           aujourd'hui [81 forges
           auto-hébergées](https://hal-lara.archives-ouvertes.fr/hal-04098702/document)
           dont la plupart sont des instances de GitLab, à quoi s'ajoutent
           d'autres instances hébergées par nos partenaires de recherches
           internationaux comme le [CERN](https://gitlab.cern.ch/),
           [DESY](https://gitlab.desy.de)... La difficile interopérabilité entre
           ces nombreuses instances de GitLab et la pertinence de dupliquer à ce
           point nos efforts d'administration système restent à ce jour un
           problème pour les générations futures.
