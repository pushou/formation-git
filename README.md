# Formation git

## Présentation

Ce dépôt git contient tous les supports d’une formation à l’outil de gestion de
version git, soit les éléments suivants :

- Des planches permettant d’introduire les sujets théoriques
- Des TPs permettant de manipuler l’outil, de façon guidée puis autonome
- Une check-list pour la présentation des outils interactifs utilisés en TP
- Des « quiz » pour jauger le niveau de compréhension de la salle et réviser les
  notions acquises, sur le modèle de l’émission « Questions pour un champion »
- Un plan pour l’organisation temporelle de la formation sur deux jours
- Un makefile permettant le rendu automatisé des supports stagiaires en PDF

Le mode d’organisation prévu est de commencer par présenter un jeu de planches,
effectuer la démonstration du ou des outils interactifs qui seront manipulés en
TP, puis laisser les stagiaires suivre les TPs de façon autonome, à leur rythme,
en appelant le formateur lorsqu’ils ont besoin d’aide. Puis, quand les
stagiaires ont tous terminé ou le budget temps est écoulé, on passe aux planches
suivantes, et ainsi de suite.

Cette organisation permet de s’adapter aux écarts de niveau des apprenants. En
effet, le seul prérequis demandé est une bonne connaissance du shell Unix, mais
dans un groupe typique on trouvera de tout, du débutant complet de la gestion de
version à l’utilisateur amateur de git en passant par l’habitué de SVN.

La formation est prévue pour un format de 2 jours. Il est probablement possible
de la faire tenir sur un format 1.5 jours, mais je pense que 1 jour serait trop
court (les branches + les _remotes_ / forges le même jour, c’est trop).

## Aspects techniques

Le makefile inclus permet d’automatiser le rendu PDF des présentations et le
rendu HTML des TPs. Pour l’utiliser, vous devez avoir installé la suite
bureautique LibreOffice (l’écriture a été effectuée avec la version 7.0) et le
générateur de sites statiques [mdBook](https://rust-lang.github.io/mdBook/).

Notez que LibreOffice n’accepte pas de s’exécuter en deux exemplaires
simultanément. Il faut donc fermer toutes les instances de l’application
graphique avant d’utiliser le makefile, et s’abstenir de lancer celui-ci en
parallèle (option `-j`) pour le rendu des présentations.

La salle de formation doit comporter un vidéoprojecteur, équipement désormais
assez standard, mais il faut surtout procéder à l’avance l'installation d'un
environnement de TP les postes stagiaires. Si vous utilisez la VM de l'édition
2021, notez que VirtualBox n’offre que des garanties faibles de compatibilité
entre versions, la VM de 2021 a été générée avec VirtualBox 6.1.

## Impression des documents formateur

En plus des planches et des énoncés de TP, ce dépôt contient deux documents à
destination du formateur, dont l’impression utilise un format un peu particulier
que je n’ai pas réussi à automatiser dans le makefile.

Le fichier `Démos.odt` contient un aide-mémoire pour les démonstrations d’outils
utilisés pendant les TP. Cet aide mémoire est au format A5 paysage,
personnellement je l’imprime en A4 avec deux pages A5 par feuille, et
éventuellement du recto verso.

Le fichier `Quiz.odt` contient des supports de quiz au format A6, conçus pour
une impression à 4 pages par feuille en recto verso. Dans cette configuration,
l’une des faces vous dit à quel TP chaque quiz fait référence, et l’autre face
vous donne les questions du quiz.

Par ailleurs, le fichier `Planning.ods`, qui décrit une organisation temporelle
possible (mise en place en 2020, la pratique dira si elle restera) utilise un
format A4 tout à fait standard, mais je n’ai pas envie que son rendu PDF se
retrouve avec les documents accessibles au stagiaire. Quand j’aurai réglé le
problème ci-dessus, je pense que je centraliserai le rendu des documents
formateur dans un dossier à part de celui des rendus « stagiaires ».

## Licence

Ce matériau est mis à disposition selon les termes de la [Licence Creative
Commons Attribution – Partage dans les Mêmes Conditions 4.0 International](
https://creativecommons.org/licenses/by-sa/4.0/).

Pour résumer, cette licence dit que vous êtes autorisés en faire à peu près ce
que vous voulez, y compris monter votre propre version modifiée de la formation,
du moment que…

1. Vous indiquez clairement que votre version est basée sur ce travail.
2. Vos versions modifiées sont aussi distribuées sous licence CC-BY-SA 4.0.