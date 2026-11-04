# Parcours « GitHub ouvert »

Dans ce parcours, nous vous proposons d'utiliser la forge
[GitHub](https://github.com/).

L'utilisation de cette forge, hébergée par Microsoft sur le sol étasunien et
dont les dépôts sont aujourd'hui utilisés pour l'entraînement de grands modèles
de langage (LLMs) commerciaux sans grand égard pour le consentement des auteurs,
fait souvent débat au sein de la communauté académique. Mais force est de
constater qu'elle reste incontournable lorsqu'on a besoin...

- De collaborer avec des personnes n'appartenant pas à la communauté académique,
  pour qui l'accès aux forges institutionnelles reste souvent trop laborieux.
  Cela inclut notamment la majorité des projets _open source_ qui ne sont pas
  issus de la communauté académique que vous utilisez et auxquels vous pourriez
  vouloir contribuer.
- De tirer partie des importantes ressources fournies par Microsoft pour
  l'intégration continue des projets _open source_[^open-source]. Celles ci
  incluent par exemple l'accès à des _runners_ prêts à l'emploi pour tester ses
  logiciels sous Windows et macOS, une [très grande
  bibliothèque](https://github.com/marketplace?type=actions) de briques prêtes à
  l'emploi (« actions ») pour effectuer des tâches courantes, et un excellent
  [service](https://github.com/dependabot) pour maintenir à jour les dépendances
  de ses logiciels et être notifié de leurs failles de sécurité.

Dans cet esprit, nous allons utiliser cette forge sur un mode de collaboration
ouvert, où le contenu du dépôt est accessible en lecture seule au monde entier
et chacun peut librement y proposer des changements. Ce mode de collaboration
est adapté pour la diffusion et le développement des projets _open source_. Ici,
notre objectif sera de diffuser au plus grand nombre des livres de cuisine
collaboratifs où chacun peut ajouter une recette, suggérer un ajustement des
proportions, une substitution lorsqu'un ingrédient n'est pas disponible, etc.

Pour introduire les concepts en douceur, nous allons procéder en plusieurs temps
:

- Dans un premier temps, nous allons [effectuer la configuration
  requise](2-acces.md) pour que vous puissiez pousser des commits depuis votre
  machine locale vers les dépôts git hébergés sur GitHub.
- Ces accès vous permettront de [contribuer à un dépôt déjà
  existant](3-contribution.md) géré par un des formateurs, et ainsi d'acquérir
  une première expérience du mode de collaboration par _fork_ et _pull request_.
- Il sera ensuite temps pour vous de prendre les commandes et devenir chef
  cuisinier en [créant votre propre livre de
  cuisine](4-depot-personnel/2-creation-depot.md), ce qui vous permettra de
  [mettre en place une intégration
  continue](4-depot-personnel/3-integration-continue.md) pour vérifier
  automatiquement certains aspects de son contenu.
- Il ne restera alors plus qu'à boucler la boucle en travaillant à nouveau en
  équipe, cette fois au sein de [dépôts sous votre
  contrôle](5-travail-equipe/2-projet-commun.md). En plus de vous donner une
  expérience plus directe du rôle de mainteneur, ce sera aussi l'occasion pour
  vous d'aller plus loin avec l'intégration continue en découvrant le
  [déploiement continu](5-travail-equipe/3-deploiement-continu.md).

[^open-source]: Historiquement, GitHub avait un modèle économique _freemium_ où
                la plupart des fonctionnalités étaient offertes gratuitement aux
                projets _open source_, mais plusieurs fonctionnalités
                importantes devenaient payantes quand on passait son dépôt en
                accès restreint. Cela reste la règle pour les fonctionnalités
                historiques comme les _runners_ d'intégration continue, mais ces
                dernières années la mode des LLMs a fait glisser le modèle
                économique de GitHub dans une direction où un nombre croissant
                de services « Copilot » sont payants pour toute utilisation non
                triviale alors que leur entraînement est majoritairement
                alimenté par minage des dépôts hébergés sur GitHub...
