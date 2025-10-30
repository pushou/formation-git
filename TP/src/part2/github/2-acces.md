# Accès SSH

Dans ce parcours, il n'y a pas besoin de formalité particulière pour lire le
contenu des dépôts de recettes de cuisine comme c'est le cas dans le parcours
« GitLab fermé », c'est un des avantages de travailler sur un dépôt en accès
libre.

En revanche, dès que vous allez vouloir soumettre des contributions aux dépôts,
un accès en écriture devient nécessaire, et cela implique deux prérequis :

- Créer un compte GitHub et vous y connecter. Si vous avez suivi les
  instructions du mail de bienvenue, normalement votre compte est déjà créé et
  il ne reste plus qu'à vous y connecter avec le bouton « Sign In » en haut à
  droite de l'interface web de GitHub.
- Ajouter la clé SSH publique de votre machine à votre compte GitHub pour que
  votre client git local soit autorisé à pousser des commits sur un dépôt
  GitHub. C'est l'objet de ce chapitre.

Vous pouvez accéder à l’interface pour ajouter une clé SSH en vous rendant sur
l’URL <https://github.com/settings/ssh/new>, après vous être connecté à votre
compte. Pour accéder à cette interface sans ce lien direct, il faut cliquer sur
votre avatar en haut à droite de l’interface de GitHub, puis sur « Settings »
dans le menu qui s’affiche, « SSH and GPG keys » dans la barre latérale à gauche
de la nouvelle page qui s’ouvre, et enfin le bouton « New SSH key » vert en haut
à droite.

Dans tous les cas, vous vous retrouverez face au formulaire « Add new SSH Key » :

![Formulaire « Add new SSH Key » de
GitHub](../../images/github-add-new-ssh-key.png)

Dans ce formulaire, vous êtes invité à saisir les informations suivantes :

- **Title :** Un nom de votre choix qui vous permettra de distinguer cette clé
  SSH de vos autres clés SSH. Nous vous conseillons d’utiliser un nom qui
  clarifie qu’elle est temporaire et liée à cette formation, par exemple
  « Formation Git ».
- **Key type :** La façon dont vous souhaitez utiliser la clé SSH que vous êtes
  en train d’ajouter à votre compte GitHub. Pour vous connecter à GitHub en SSH
  avec git, prenez le choix par défaut « Authentication Key ».
- **Key :** Collez ici la clé publique que vous avez générée précédemment. Pour
  cela, vous pouvez l’afficher avec `cat` dans votre terminal…

  ```bash
  {{#include ../../5-reseau-forges.sh:show-pubkey}}
  ```

  …puis la copier (avec un clic droit ou Ctrl+Maj+C) et la coller dans
  l'interface de GitHub.

Ensuite, plus qu’à valider, et vous serez prêt à échanger des commits avec la
forge GitHub !
