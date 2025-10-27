# Accès web et SSH

## Se connecter à l'instance GitLab de l'IN2P3

Lorsque vous vous rendez à l'URL <https://gitlab.in2p3.fr> pour la première fois
sur une machine[^private-browsing], vous allez vous retrouver face à l’invite de connexion de
GitLab :

![Invite de connexion GitLab](../../../images/gitlab-login.png)

Nous allons utiliser ici la méthode de connexion « CC-IN2P3 Single Sign-On ».
Pour y accéder, cliquez sur le bouton correspondant en-dessous du bouton bleu
« Sign in ». Vous vous retrouverez alors face à l’invite de connexion du centre
de calcul de l’IN2P3 (CC-IN2P3) :

![Invite de connexion CC-IN2P3](../../../images/gitlab-login-ccin2p3.png)

La méthode proposée à gauche ne convient que pour les personnes qui ont un
compte local au centre de calcul, ce qui ne sera pas le cas de beaucoup d’entre
vous. Heureusement, l'instance GitLab du CC-IN2P3 accepte aussi la
connexion via des comptes informatiques des laboratoires de recherche du monde
entier grâce à la fédération eduGAIN.

Pour y accéder, cliquez sur le bouton « EDUGAIN » à droite de l’invite. Cela
vous conduira à une nouvelle page où vous pouvez choisir une institution
académique auprès de laquelle vous possédez un compte informatique.

<center>

![Choix d'identité eduGAIN](../../../images/gitlab-login-edugain.png)

</center>

Par exemple, l'auteur de cet énoncé de TP possède un compte informatique au CNRS
(JANUS) et à l'Université Paris-Saclay, il peut donc sélectionner l'une de ces
deux options.

À cette étape, il faut faire attention à deux choses :

- Il est possible de chercher le nom de votre institution en tapant une partie
  de ce dernier, mais le moteur de recherche n’est pas très perfectionné et le
  morceau de nom doit correspondre exactement. Par exemple, si vous tapez
  « Paris Saclay », il ne trouvera pas l'université Paris-Saclay car il manque
  un tiret entre les deux mots…
- Quand vous pouvez vous connecter avec différentes institutions, vous devriez
  toujours utiliser la même à chaque fois. En effet, GitLab utilise l’adresse
  e‑mail pour identifier les utilisateurs. Donc si vous vous connectez avec
  différentes institutions, vous avez différentes adresses e‑mail, et donc vous
  n’êtes pas la même personne du point de vue de GitLab. Vous vous retrouverez
  donc connecté à un compte GitLab différent, où vos dépôts ne sont pas
  disponibles…[^multi-email]

[^multi-email]: Il est possible d'éviter ce problème, pour cela ajoutez toutes
                vos adresses e‑mail institutionnelles à un seul et même profil
                GitLab : [User Settings >
                Emails](https://gitlab.in2p3.fr/-/profile/emails), puis « Add
                new email » pour chaque adresse et validez leur vérification.
                GitLab associera alors ces adresses au même compte.

Quoi qu'il en soit, une fois que vous aurez choisi votre institution, vous vous
retrouverez sur l’invite de connexion de cette dernière. Ici, nous ne pouvons
pas vous donner des instructions précises car ça dépend de votre employeur, mais
voici par exemple la page de connexion Janus du CNRS :

<center>

![Choix d'identité eduGAIN](../../../images/gitlab-login-janus.png)

</center>

Enfin, une fois cette étape terminée, un compte GitLab sera créé automatiquement
pour vous si vous ne vous êtes jamais connecté à l’instance GitLab de
l’IN2P3 avec cette institution, puis vous vous retrouverez face à la page
d'accueil de GitLab, qui ressemble à ceci :

![Page d'accueil de GitLab](../../../images/gitlab-home.png)

[^private-browsing]: Pour plus de sécurité, vos comptes utilisateur sur les machines de TP
  partagées sont configurés pour oublier les connexions actives à chaque
  fois que vous fermez Firefox. Donc si vous êtes du genre à fermer le
  navigateur web dès que vous ne l'utilisez pas, vous pourriez vous
  retrouver face à cette invite de nombreuses fois pendant le TP. Si cela
  s'avère trop gênant, n'hésitez pas à changer ce réglage dans les
  préférences de Firefox.

## Enregistrement de la clé publique SSH

Nous allons maintenant transmettre la clé SSH publique que nous avons générée à
l’instance GitLab de l’IN2P3, afin qu’elle nous reconnaisse lorsqu'on se
connecte en SSH depuis git.

Vous pouvez accéder à l’interface pour ajouter une clé SSH en vous rendant sur
l’URL <https://gitlab.in2p3.fr/-/user_settings/ssh_keys>. Ou, si vous souhaitez
le faire sans lien direct, vous pouvez vous y rendre en cliquant sur votre
avatar en haut à droite du panneau latéral à gauche de l’interface de GitLab,
puis sur « Preferences » dans le menu qui s’affiche, « SSH Keys » dans la barre
latérale à gauche de la nouvelle page qui s’ouvre.

D'une façon où d’une autre, vous vous retrouverez face à la page suivante, où
vous pouvez cliquer sur le bouton « Add new key » en haut à droite pour ajouter
une nouvelle clé SSH :

![Interface de gestion des clés SSH de GitLab](../../../images/gitlab-ssh-keys.png)

Ceci fait, vous vous retrouverez face au formulaire d'ajout de clé SSH :

![Invite d'ajout de clé SSH de GitLab](../../../images/gitlab-ssh-add-key.png)

Voici les informations dont vous aurez besoin pour le remplir :

- **Key :** Collez ici la clé publique SSH que vous avez générée précédemment.
  Pour cela, vous pouvez l’afficher avec `cat` dans votre terminal…

  ```bash
  {{#include ../../5-reseau-forges.sh:show-pubkey}}
  ```

  …puis la copier (avec un clic droit ou Ctrl+Maj+C) et la coller dans
  l’interface de GitLab.

- **Title :** Un nom de votre choix qui vous permettra de distinguer cette clé
  SSH de vos autres clés SSH. Nous vous conseillons d’utiliser un nom qui
  clarifie qu’elle est temporaire et liée à cette formation, par exemple
  « Formation Git ».
- **Usage type :** La façon dont vous souhaitez utiliser la clé SSH que vous
  êtes en train d’ajouter à votre compte GitLab. Pour vous connecter à GitLab en
  SSH avec git, le choix « Authentication » est suffisant.
- **Expiration date :** Une date limite à partir de laquelle la clé SSH ne sera
  plus utilisable. La clé que nous sommes en train de saisir est spécifique à
  votre ordinateur de TP et ne servira que pendant la formation. Vous pouvez
  donc fixer une date proche de la fin de la session.

Ensuite, plus qu’à valider avec le bouton bleu « Add key », et vous serez prêt à
échanger des commits avec l’instance GitLab de l’IN2P3 !

## Obtenir l'accès au groupe du TP

Le groupe « Git Kitchen » est un groupe fermé disponible à l'adresse suivante [https://gitlab.in2p3.fr/git-kitchen](https://gitlab.in2p3.fr/git-kitchen), mais pour l’instant vous ne pouvez pas y accéder.

Pour vous y donner accès, nous aurons besoin de connaître le nom de votre compte
utilisateur. Vous pouvez le découvrir en cliquant sur votre avatar en haut à
droite du panneau latéral à gauche de l’interface de GitLab. Il apparaît en haut
du menu qui s'affiche, précédé d'un arobase `@` :

<center>

![Affichage du nom d'utilisateur dans GitLab](../../../images/gitlab-username.png)

</center>

Dès que vous nous l'aurez transmis, nous pourrons vous donner un accès de niveau
« Developer » au groupe. Ce niveau d’accès vous permettra entre autres de voir
le groupe et ce qu'il contient. En particulier, vous pourrez accéder au contenu
du dépôt [Recettes](https://gitlab.in2p3.fr/git-kitchen/recettes) et y pousser
des branches de développement, mais pas de modifier directement le contenu de la
branche `main`.

Pour cela, vous devrez passer par une procédure de validation de notre part, la
_merge request_, que nous allons explorer dans [l'étape suivante de ce
TP](3-contribution.md).
