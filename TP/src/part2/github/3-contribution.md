# Contribuer à un dépôt existant

## Rappel sur les _forks_ et _pull requests_

Dans ce parcours, vous aviez en réalité accès au dépôt GitHub
[« HadrienG2/Recettes »](https://github.com/HadrienG2/Recettes) depuis le début,
avant même de vous connecter à votre compte GitHub, car ce dépôt est en accès
libre. Mais pour des raisons évidentes de sécurité, cet accès est en lecture
seule et ne vous permet pas de modifier directement les fichiers du dépôt.

Maintenant que vous avez un compte GitHub, le mainteneur du dépôt pourrait vous
donner un accès en écriture comme dans le parcours [« Gitlab
fermé »](../gitlab/1-intro.md). Mais il faut comprendre que cela reflète une
grande confiance. En effet, même avec les permissions d'accès en écriture les
plus minimales supportées par GitHub vous avez déjà la possibilité de vandaliser
la quasi-totalité[^protected-branches] des branches du dépôt ! Ce mode d'accès
au dépôt n'est donc pas très adapté quand on souhaite recevoir des contributions
de parfaits inconnus comme c'est l'usage dans la communauté _open-source_.

On préfère dans ce cas un autre mode de fonctionnement, basé sur des copies
privées des dépôts git appelées _forks_. L'idée est la suivante :

- Vous créez une copie du dépôt git auquel vous voulez contribuer qui est
  associée à votre compte utilisateur et sous votre contrôle. Cette copie
  privée, appellée _fork_, est hébergée sur GitHub au même titre que le dépôt
  original, ce qui sera important pour la suite.
- Vous travaillez ensuite au sein de branches que vous poussez à volonté sur
  votre _fork_ jusqu'à obtenir une contribution qui vous semble digne d'être
  intégrée au dépôt original.
- Vous soumettez alors aux mainteneurs du dépôt original cette contribution sous
  la forme d'une _pull request_. Il s'agit d'un mécanisme propre à la forge qui
  notifie les mainteneurs de votre souhait d'intégrer les changements de votre
  fork au dépôt officiel, vous permet de justifier ces changements, et leur
  offre la possibilité de les examiner et d'en discuter avec vous. Ce processus
  de révision manuelle des contributions est généralement complété par un jeu de
  tests automatisés (intégration continue), qui ne saurait bien sûr le
  remplacer.[^ci-isnt-enough]
- Une fois un accord trouvé entre les mainteneurs et vous, et les changements
  éventuellement demandés apportés à votre branche, les mainteneurs n'ont
  ensuite plus qu'à cliquer sur un bouton dans l'interface de GitHub. Vos
  changements seront alors fusionnés au sein du dépôt officiel (typiquement au
  sein de la branche principale `main`), et ils deviendront alors une partie du
  contenu officiel du dépôt et de son historique officiel.

On le voit, le mécanisme des _forks_ offre un canal sécurisé par lequel un
projet peut accepter des contributions de parfaits inconnus, moyennant un
processus de passage en revue des contributions suffisamment rigoureux. Nul
besoin pour ça distribuer à tout va de dangereux accès en écriture. C'est donc
un mécanisme très adapté aux projets _open-source_.

Mais il y a un prix à payer pour cette sécurité et cette ouverture, qui est une
lourdeur plus importante du processus de contribution. En effet, avec les
_forks_, les contributeurs doivent jongler avec pas moins de 3 dépôts git
différents, un sur leur machine et deux sur les serveurs de GitHub :

- Le dépôt local sur leur machine est utilisé pour l'édition directe des
  fichiers.[^web-edition]
- Le dépôt officiel du projet, auquel ils n'ont qu'un accès en lecture seule,
  est utilisé pour se tenir à jour par rapport à l'actualité du projet.
- Leur _fork_ privé, auquel ils ont accès en écriture, est utilisé pour mettre
  en ligne les branches qui seront à terme soumises au dépôt officiel via une
  _pull request_.

Ce jonglage nécessite un peu de pratique pour être maîtrisé, et l'objectif de ce
TP est justement de vous le faire pratiquer jusqu'à que vous soyez plus à l'aise
avant de passer à la suite.

[^ci-isnt-enough]: Si vous avez besoin de vous en convaincre, considérez le fait
                   qu'il est possible de soumettre une _pull request_ qui
                   supprime ou désactive la totalité des tests automatisés
                   effectués par l'intégration continue.

[^protected-branches]: Beaucoup de projets appliquent des règles de protection
                       aux branches « officielles » comme `main` afin de
                       restreindre le nombre de personnes qui y ont accès. Cela
                       réduit le risque associé à une fausse manip, à un
                       utilisateur malveillant, ou à un compte compromis.

[^web-edition]: On peut aussi éditer des fichiers via l'interface web de github,
                mais cette approche rencontre vite ses limites dès qu'on
                souhaite par exemple vérifier rapidement que le code que l'on
                est en train d'éditer fonctionne toujours. Ce n'est donc
                intéressant que pour des modifications très simples comme
                corriger une faute d'orthographe dans un fichier README par
                exemple.


## Création et clonage du _fork_

TODO
