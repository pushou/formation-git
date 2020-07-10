# Formation git

## Présentation

Ce dépôt git contient le matériau complet d'une formation à l'outil de gestion
de version git, composé des éléments suivants :

- Des planches permettant d'introduire les sujets théoriques
- Des TPs permettant de manipuler l'outil, de façon guidée puis autonome
- Une checklist pour la présentation des outils interactifs utilisés en TP
- Des "quiz" pour jauger le niveau de compréhension de la salle et réviser les
  notions acquises, sur le modèle de l'émission "Questions pour un champion"
- Un script permettant le rendu automatisé des supports stagiaires en PDF
- Une machine virtuelle au sein de laquelle les TPs seront effectués

Le mode d'organisation prévu est de commencer par présenter un jeu de planches,
effectuer la démonstration du ou des outils interactifs qui seront manipulés en
TP, puis laisser les stagiaires suivre les TPs de façon autonome, à leur rythme,
en appelant le formateur lorsqu'ils ont besoin d'aide. Puis, quand les
stagiaires ont terminé, on passe aux planches suivantes, et ainsi de suite.

Cette organisation permet de s'adapter aux écarts de niveau des apprenants. En
effet, le seul prérequis demandé est une bonne connaissance du shell Unix, mais
dans un groupe typique on trouvera de tout, du débutant complet de la gestion de
version à l'utilisateur amateur de git en passant par l'habitué de SVN.

La formation est prévue pour un format de 2 jours.

## Aspects techniques

Comme il contient de nombreux gros fichiers binaires, ce dépôt utilise
l'extension git LFS (Large File Storage). Pour en effectuer un clone complet,
incluant les fichiers binaires, vous devrez installer cette extension.
Vous trouverez plus d'informations sur https://git-lfs.github.com/ .

Des problèmes de compatibilité ont été signalés avec la version 2.5.2 de git
LFS. L'utilisation de git LFS >= 2.6.0 est donc fortement recommandée.

Le script `rendu_pdf.sh` permet d'automatiser le rendu PDF des TPs et des
planches. Pour l'utiliser, vous devez avoir installé l'outil de conversion de
document `pandoc`, une distribution LaTeX comportant l'outil `pdflatex`, et la
suite bureautique LibreOffice (l'écriture a été effectuée avec la version 7.0).

Notez que l'outil de conversion de documents en ligne de commande de LibreOffice
ne peut pas s'exécuter en même temps que l'application graphique. Il faut donc
fermer toutes les instances de celle-ci avant de pouvoir effectuer des rendus
des présentations.

La salle de formation doit comporter un vidéoprojecteur, équipement désormais
assez standard, mais il faut surtout procéder à l'avance à une installation de
la VM fournie sur tous les postes stagiaires. Notez que VirtualBox n'offre que
des garanties faibles de compatibilité entre versions, la VM utilisée ici a été
générée avec VirtualBox 6.0.

## Impression des documents formateur

En plus des planches et des énoncés de TP, ce dépôt contient deux documents à
destination du formateur, dont l'impression utilise un format un peu particulier
que je n'ai pas réussi à automatiser dans le script `rendu_pdf.sh`.

Le fichier `Démos.odt` contient un aide-mémoire pour les démonstrations d'outils
utilisés pendant les TP. Cet aide mémoire est au format A5 paysage,
personnellement je l'imprime en A4 avec deux pages A5 par feuille, et
éventuellement du recto verso.

Le fichier `Quiz.odt` contient des supports de quiz au format A6, conçus pour
une impression à 4 pages par feuille en recto verso. Dans cette configuration,
l'une des faces vous dit à quel TP chaque quiz fait référence, et l'autre face
vous donne les questions du quiz.

## Licence

Ce matériau est mis à disposition selon les termes de la [Licence Creative
Commons Attribution - Partage dans les Mêmes Conditions 4.0 International](
https://creativecommons.org/licenses/by-sa/4.0/).

Pour résumer, cette licence dit que vous êtes autorisés en faire à peu près ce
que vous voulez, y compris monter votre propre version modifiée de la formation,
du moment que...

1. Vous indiquez clairement que votre version est basée sur ce travail.
2. Vos versions modifiées sont aussi distribuées sous licence CC BY-SA 4.0.