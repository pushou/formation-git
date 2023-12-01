# Supports de travaux pratiques

Les supports de travaux pratiques prennent la forme d'un site statique dont le
source est en Markdown et le rendu HTML est effectué par
[mdBook](https://rust-lang.github.io/mdBook/).

A l'exception de l'annexe "Sujets bonus" qui est plus une documentation de
référence qu'un TP, les commandes shell ne sont pas directement écrites dans le
fichier Markdown mais extraites dans des scripts shell à part, ce qui permet...

- De lancer des correcteurs orthographiques, grammaticaux et typographiques sur
  le texte markdown du TP en ayant moins de suggestions bizarres au niveau des
  commandes shell.
- D'exécuter une partie des commandes shell de façon automatisée et rapide sur
  les machines de TP avant la formation afin de vérifier rapidement qu'elles
  n'ont pas de nouvelles sorties ou d'erreurs inattendues.
- De régénérer facilement les archives représentant l'état attendu des
  différents dépôts au début des TP 2, 3 et 4.

Ces deux dernières opérations sont automatisées via un Makefile situé dans le
dossier `src`. Il suffit de taper "make" dans un compte utilisateur utilisateur
fraîchement initialisé mais muni d'un dossier `~/Desktop` pour vérifier que le
TP se passe comme prévu et régénérer les archives de rattrapage.
