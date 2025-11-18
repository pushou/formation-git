# Conclusion commune

Dans cette seconde partie, nous avons passé en revue et pratiqué les éléments essentiels du travail avec une forge logicielle, aussi bien pour ceux d'entre vous qui ont choisi le parcours GitHub que ceux qui ont choisi le parcours GitLab. Dans les deux cas, vous avez essentiellement exploré les mêmes concepts.

D'abord, vous avez configuré l’authentification via SSH et mis en place les _remotes_ nécessaires pour connecter votre dépôt local à un ou deux dépôts distants. Puis vous avez appliqué le _GitHub flow_ pour contribuer à vos différents livres de cuisine et collaborer avec vos collègues cuisiniers. Pour ça vous avez respecté ces quatre grands principes qui sont : se maintenir à jour, développer dans une branche dédiée, publier cette branche, puis proposer son intégration dans `main` via une _Pull Request_ ou une _Merge Request_.

Durant ce processus, vous avez pu vous familiariser avec le concept des revues de code, tant en tant qu’auteur qu’en tant que relecteur, et vous avez peut-être même rencontré des situations de conflits lors des fusions. Nous en profitons pour rappeler que ces conflits sont normaux et font partie intégrante du travail collaboratif avec Git. Cependant, pour éviter que ces conflits ne surviennent trop régulièrement, il est recommandé de bien segmenter son travail en petites unités sur un sujet ciblé et une période de temps restreinte.

Enfin, vous avez mis en pratique les mécanismes d’intégration et de déploiement continu _CI/CD_, tantôt avec les _GitHub Actions_, tantôt avec _GitLab CI/CD_. Cela vous a permis d’automatiser des tâches répétitives, comme la vérification du contenu de vos recettes (_linting_) et la génération et la publication de celles-ci sous forme de pages web.

## Spécificité du parcours GitHub ouvert

Dans le parcours GitHub, vous avez travaillé en suivant le modèle le plus répandu pour les projets _open source_, à savoir le système de _fork_. Avec ce modèle, vous n’aviez pas moins de trois dépôts Git avec lesquels interagir : le dépôt officiel (_upstream_), votre _fork_ personnel (_origin_) et votre dépôt local sur votre machine. Cette méthode est assez lourde, mais elle est très efficace pour gérer les contributions externes et permet de limiter les risques de contribution malveillante sur le dépôt principal.

## Spécificité du parcours GitLab fermé

Dans le parcours GitLab, vous avez utilisé l'instance IN2P3 qui nécessite un compte académique pour l'authentification via _eduGAIN_. La politique du Centre de Calcul de l'IN2P3 limitant les _forks_, chacun travaille directement sur le dépôt officiel, en créant des branches dédiées pour chaque nouvelle fonctionnalité ou correction. Le processus est plus simple que dans le modèle de _fork_, mais il repose sur la confiance entre les contributeurs et nécessite une gestion rigoureuse des droits d'accès pour limiter les modifications indésirables. Il est cependant impossible d'empêcher totalement les contributions malveillantes dès lors que les contributeurs ont un accès suffisant en écriture au dépôt, prenez donc garde à qui vous accordez ces droits !

## Ouverture : autres forges

Au-delà de GitHub et du GitLab de l'IN2P3, il existe une myriade d'instances GitLab académiques ainsi que _gitlab.com_. De plus, il existe d'autres solutions basées sur Git, comme Forgejo ou Gitea.

Le choix d’une forge dépend souvent de considérations d’hébergement, de souveraineté des données et de politiques d’accès, qui peuvent faciliter ou au contraire compliquer les contributions extérieures. Attention au choix que vous ferez, car si la migration d’un dépôt Git reste simple, le transfert des tickets, des demandes de fusion ou des pipelines de _CI/CD_ d'un système à l'autre est bien plus délicat, d'autant que les fonctionnalités ne sont pas toujours équivalentes entre les différentes plateformes.

Ne négligez pas non plus l'accès à des ressources pour la _CI/CD_: si vous n'avez pas les moyens de maintenir vos propres _runners_, les plateformes "clés en main" diffèrent beaucoup les unes des autres au niveau de la quantité et du type de ressources qui sont disponibles gratuitement.

Enfin, si vous avez dans l'idée d'héberger votre propre forge,
prenez garde à bien évaluer les besoins en maintenance et en sécurité que cela implique. En effet, une forge mal maintenue peut rapidement devenir un point d'entrée pour un attaquant malveillant et nécessite donc des moyens humains importants, sans même parler des ressources matérielles pour stocker les dépôts et les besoins considérables d'un service de _CI/CD_.

### Autres méthodes de travail

Dans ce TP, nous nous sommes intéressés au _GitHub flow_, une des méthodes de travail les plus simples et les plus utilisées avec Git. Mais c’est loin d’être la seule. On peut mentionner comme autres méthodes classiques…

- Le _Git flow_, une variante plus complexe où l’on maintient plusieurs branches spéciales au sein du dépôt commun :

  - On distingue `main`, qui représente les développements publiés, de `develop`, qui contient des développements expérimentaux. Les nouveaux développements sont fusionnés dans `develop`.
  - Avant de sortir une nouvelle version, on crée une branche dédiée (_release branch_) partant de `develop`, qui ne reçoit plus de nouvelles fonctionnalités mais peut encore recevoir des correctifs. Lorsqu’on est satisfait de l’état de cette branche, on la fusionne dans `main` et crée une étiquette pour la nouvelle version officielle.
  - En cas de problème urgent dans `main`, on peut créer une branche `hotfix` issue de `main`, dédiée à la résolution de ce problème et vouée à être immédiatement fusionnée dans `main` à la fin.

- Le _GitLab flow_ est basé sur le _GitHub flow_, mais il y ajoute des branches supplémentaires de longue durée de vie pour gérer le déploiement de services web en production.

  - Une branche `production` qui reflète le code qui est effectivement déployé en production, ce qui permet de suivre d'éventuelles contraintes de déploiement imposées par le projet (ex : seulement à certaines heures, certains jours) sans freiner le développement.
  - Éventuellement, d'autres branches représentant des environnements de test intermédiaires avec différents niveaux de stabilité (ex : `staging`, `pre-prod`…)
  - Pour les projets qui publient des versions stables dont plusieurs sont sujettes à correctifs à un instant T, des _release branches_ de longue durée de vie vont servir à accumuler l'ensemble des correctifs appliqués à une certaine version.

Voici un article très complet sur ce sujet qui part des principes fondamentaux pour expliquer comment différentes méthodes de travail en découlent :
[https://martinfowler.com/articles/branching-patterns.html](https://martinfowler.com/articles/branching-patterns.html).

## Exercices avancés

Pour aller plus loin, nous avons plusieurs sujets à la carte. Nous vous proposons de commencer par expérimenter les _hooks_ Git à l'aide de l'outil _pre-commit_.

TODO : écrire l'annexe sur les _hooks_ Git (et y inclure _pre-commit_)
