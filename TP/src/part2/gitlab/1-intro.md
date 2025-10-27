# Parcours « GitLab fermé »

Dans ce parcours, nous allons nous intéresser à la forge GitLab, et plus
précisément à [l'instance de celle-ci](https://gitlab.in2p3.fr/) qui est
hébergée par le centre de calcul de l'IN2P3.

Nous allons utiliser cette forge sur un mode de collaboration fermé où seule
l'équipe projet a accès au dépôt git. Ce mode de travail est adapté pour des
projets manipulant des données confidentielles tels que des comptes-rendus de
réunions ou des résultats de recherches non publiés. Ici, nous l'utiliserons
pour gérer des livres de recettes de cuisine, dont on sait à quel point ils
peuvent être un secret professionnel jalousement gardé !

Pour introduire les concepts en douceur, nous allons procéder en plusieurs temps
:

- Dans un premier temps, nous allons [effectuer la configuration
  requise](2-acces.md) pour que vous ayez accès au groupe GitLab privé des
  cuisiniers qui suivent ce parcours, et puissiez pousser des commits depuis
  votre machine locale vers des dépôts git hébergés au sein de ce groupe.
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
  contrôle](5-travail-equipe/2-gestion-projet.md). En plus de vous donner une
  expérience plus directe du rôle de mainteneur, ce sera aussi l'occasion pour
  vous d'aller plus loin avec l'intégration continue en découvrant le
  [déploiement continu](5-travail-equipe/3-deploiement-continu.md).
