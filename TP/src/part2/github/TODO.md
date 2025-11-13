# Dépôt ouvert sur GitHub

## Travail distribué avec le _GitHub flow_

TODO: Finir l'intégration

### Soumission au dépôt officiel

Une fois que vous avez mis des changements en ligne sous la forme d’une branche
sur votre _fork_, vous pouvez demander l’intégration de ces changements au dépôt
officiel avec une fonctionnalité des forges git modernes, la _pull request_.
Cette fonctionnalité est également appelée _merge request_ par GitLab, mais
comme nous utilisons GitHub dans ce TP, nous nous en tiendrons à sa terminologie
afin d’éviter toute confusion.

Comme son nom l’indique, une _pull request_ invite les mainteneurs du dépôt
officiel à intégrer vos changements au projet en fusionnant les nouveautés de
votre branche dans un historique officiel (généralement la branche `main`).

Cette possibilité vous sera généralement directement offerte par l’affichage
d’une URL dans la console lorsque vous poussez la branche sur votre _fork_,
ainsi que par un bandeau dans l’interface web de votre _fork_ sur GitHub pendant
quelque temps après le _push_. Mais si vous avez ignoré tous ces raccourcis,
vous pouvez toujours créer « manuellement » une _pull request_ de la façon suivante.

Allez sur l’interface web de votre _fork_ et affichez la liste des branches avec
le lien « N branches » en haut à gauche, un peu en dessous du nom du dépôt :

![Lien donnant accès à la liste des
branches](../../images/github-branch-list-button.png)

Ensuite, cliquez sur le bouton « New Pull Request » associé à la branche que
vous voulez soumettre au dépôt officiel pour initier le processus de soumission
:

![Bouton « New pull request » dans la liste des
branches](../../images/github-new-pull-request-button.png)

Après avoir fait tout ça, vous vous retrouverez sur la même interface de
création de _pull request_ que vous auriez eu si vous aviez utilisé un des
raccourcis initialement :

![Interface de création d’une pull
request](../../images/github-create-pull-request.png)

De haut en bas, cette interface contient…

- En haut, une section à laquelle vous n’aurez presque jamais besoin de toucher
  qui vous permet de spécifier quelle branche de votre _fork_ (ou d’un autre
  dépôt) vous voulez fusionner dans quelle branche du dépôt officiel.
- Ensuite, un formulaire pour donner un nom à votre _pull request_ ainsi qu’une
  description plus détaillée si besoin. Cette description peut être formatée
  avec [le dialecte local de
  Markdown](https://docs.github.com/fr/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax).
- En bas de ce formulaire, une case à cocher « Allow edits by maintainers » qui
  permet aux mainteneurs du dépôt d’ajouter des changements à votre branche (ça
  permet de fluidifier un peu le processus de passage en revue d’une
  contribution en faisant directement les modifications mineures plutôt que de
  vous demander de les faire vous-même).
- Près de cette case à cocher, un bouton « Create pull request » qui termine la
  saisie et crée la _pull request_, avec sur le côté droit une option un peu
  trop bien cachée (flèche descendante) pour créer la _pull request_ en mode
  brouillon. Cela signifie que vous informez les mainteneurs que vous aurez
  bientôt des changements à intégrer et leur permettez d’y jeter un œil, mais
  ne souhaitez pas qu’ils soient intégrés tout de suite, car vous n’avez pas fini
  le travail.
- En dessous de tout ça, pour information, une visualisation des changements
  apportés par votre branche : liste des commits et différences par rapport à la
  branche de destination.

Pour les mainteneurs, une _pull request_ se présentera ensuite sous la forme du
titre et de la description que vous avez choisi, d’une visualisation des
changements proposés, et d’une interface permettant d’en discuter (pour proposer des modifications avant intégration par exemple).

Il est aussi possible pour un mainteneur de définir une batterie de tests
automatisés que toute _pull request_ doit passer avant d’être acceptée par le
projet. On parle alors d’intégration continue.

Si des changements sont demandés par un mainteneur, vous pouvez ajouter ceux-ci
à votre branche locale via de nouveaux commits et de les pousser sur votre
_fork_ avec un simple `git push`. La _pull request_ associée sera alors mise à
jour automatiquement.

Une fois la _pull request_ fusionnée, vous pourrez supprimer la branche de
développement associée de vos dépôts locaux et distants…

```bash
{{#include ../../5-reseau-forges.sh:delete-dev-branch-github}}
```

…puis recommencer un autre développement depuis la branche `main` quand vous
voudrez en reprenant le cheminement indiqué ci-dessus à partir du début.


## À vous de jouer !

À ce stade, vous en savez assez pour commencer à vous amuser avec cette pauvre
Déclaration des Droits de l’Homme.

Peut-être avez-vous toujours rêvé de paraphraser Olympe de Gouges en réécrivant
entièrement le texte au féminin (« Déclaration des Droits de la Femme et de
la Citoyenne ») ? Peut-être souhaitez-vous y ajouter l’article
manquant qui résoudra enfin le débat séculaire entre pain au chocolat et
chocolatine ? Ou bien peut-être est-il temps d’amender l’article 15 qui
autorise chaque citoyen à demander des comptes aux agents publics ?

Modifiez le texte comme vous le souhaitez, en n’hésitant pas à créer des commits
en cours de route pour vous permettre de revenir facilement en arrière. Puis,
quand vous aurez fini, poussez votre branche finale sur votre _fork_, et
soumettez une _pull request_ au dépôt officiel pour terminer ce TP.

Ensuite, vous pourrez aller lire la [conclusion
commune](../conclusion-commune.md). Si vous êtes en avance, n'hésitez pas à
aller voir aussi la variante [« GitLab fermé »](../gitlab/1-intro.md) du TP, qui
vous permettra de pratiquer sur une autre forge couramment utilisée (GitLab),
avec une méthode de travail plus adaptée pour des projets impliquant des
informations confidentielles.
