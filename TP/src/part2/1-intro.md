# Réseau et forges

<a href="Pres5-Reseau.pdf" target="blank">Retrouvez ici les supports de la
présentation.</a>


## Introduction

Dans cette seconde partie consacrée aux forges et au travail collaboratif avec
Git, nous vous proposons un exercice d'édition collective autour d'un de nos
trésors nationaux : le patrimoine gastronomique français.

Pourquoi la cuisine, me direz-vous ? Parce que les recettes constituent un
terrain de jeu parfait pour s'initier à la gestion de version en équipe. Elles
sont universelles, évolutives, et soulèvent inévitablement des débats passionnés
: faut-il vraiment mettre de la crème dans la carbonara ? La quiche lorraine
supporte-t-elle une touche de fromage ? Et l'éternel duel pain au chocolat
contre chocolatine ne mériterait-il pas d'être enfin tranché par un commit ?

Bref, les recettes réunissent tous les ingrédients d'un bon support pédagogique
: elles sont simples à manipuler, riches en discussions possibles, et rappellent
avec humour que si la France aime débattre de tout, elle prend sa table très au
sérieux.

Reste à voir comment tout cela va s'organiser… mais d'abord, un petit point
technique.


## Génération de clés SSH

Il ne suffit pas de pouvoir vous connecter à l’interface web d’une forge pour
pouvoir échanger librement des _commits_ avec. Vous devez également fournir à
votre utilitaire git local un moyen de confirmer votre identité auprès du
serveur, lors de certaines opérations sensibles comme écrire des _commits_ dans
un dépôt ou lire les _commits_ d’un dépôt privé. On parle d’authentification.

Il existe plusieurs moyens de faire cela. Dans ce TP nous utiliserons
l’authentification SSH, qui est la plus utilisée. Mais vous pouvez consulter la
section « Informations complémentaires » pour plus d’informations sur
l’authentification HTTPS, qui est parfois utilisée comme alternative.

SSH est basé sur le chiffrement à clé publique, qui utilise deux clés de
chiffrement :

- La **clé privée** est une information secrète qui sert à vous authentifier.
  Elle ne doit être transmise à personne, car toute personne qui la possède peut
  se faire passer pour vous.
- La **clé publique** doit être transmise aux services auprès desquels vous
  souhaitez vous authentifier au moyen de votre clé privée. Elle permet de
  vérifier que vous possédez la clé privée, mais pas d’usurper votre identité
  auprès d’autres services connaissant la clé publique.

Votre compte utilisateur sur les machines de TP ne possède pas encore de clés
SSH, mais vous pouvez facilement générer une paire clé privée + clé publique
avec la commande suivante :

```bash
{{#include ../5-reseau-forges.sh:ssh-keygen}}
```

`ssh-keygen` va vous poser une série de questions :

- L’endroit où vous souhaitez stocker vos clés. Nous vous recommandons
  d’utiliser l’emplacement par défaut en appuyant sur Entrée sans rien saisir,
  cela vous évitera de devoir préciser l’emplacement de la clé à tous les
  utilitaires basés sur SSH plus tard.
- La phrase de passe que vous souhaitez utiliser pour protéger votre clé. Pour
  simplifier la formation, nous vous proposons de ne pas utiliser de phrase de
  passe, ce que vous pouvez faire en appuyant deux fois de suite sur Entrée.

<details><summary>Cliquez ici pour en savoir plus sur les implications en termes
de sécurité</summary><div class="warning">

Sans phrase de passe, votre clé privée est stockée dans votre dossier personnel
sans chiffrement supplémentaire, ce qui est problématique si vous vous retrouvez
dans un des cas suivants :

- Votre ordinateur est volé alors que votre disque dur n’était pas chiffré.
  C'est peu probable au CNRS, où le chiffrement des postes professionnels est
  obligatoire.
- Vous partagez votre ordinateur avec d’autres utilisateurs qui ont accès à
  votre dossier personnel et peuvent y changer les permissions de fichiers pour
  rendre votre clé privée SSH lisible (donc ont probablement des privilèges
  administrateur), mais ne sont malgré tout pas dignes de confiance.
- Vous exécutez accidentellement des logiciels malveillants qui s’empressent
  d’envoyer une copie de votre clé privée à un tiers malveillant. Ce risque
  n'est pas très élevé sur un client Linux, même si il n'est pas nul.

On le voit, les menaces existent, mais ne sont pas très probables. A l'inverse,
les méthodes permettant de protéger votre clé SSH de ce type d’attaque sans se
retrouver à saisir une phrase de passe à chaque utilisation de git sont un peu
complexes et dépendent du système d’exploitation utilisé.

Dans le cadre cette formation, qui est effectuée dans un cadre contraint et pour
une durée limitée, à l’issue de laquelle votre compte utilisateur et sa clé SSH
seront détruits, il me semble donc raisonnable d’accepter le risque de
travailler sans phrase de passe.

</div></details>

Une fois votre paire de clés SSH générée avec `ssh-keygen`, il ne vous reste
plus qu’à afficher votre clé publique, par exemple avec `cat`…

```bash
{{#include ../5-reseau-forges.sh:show-pubkey}}
```

…puis à la copier (avec un clic droit ou Ctrl+Maj+C) et la coller dans
l’interface web de gestion de clé SSH de la forge que vous allez utiliser. Qu'il
est donc temps de choisir.


## Choix de la variante du TP

Pour ce TP, vous devez choisir entre deux parcours :

- Dans le parcours [« GitHub ouvert »](part2/github/2.1-preparation.md), nous
  présentons sur la forge GitHub un mode de collaboration ouvert, où le monde
  entier peut lire le contenu du dépôt git et y proposer des changements via des
  _forks_. C'est une approche adaptée pour des projets _open source_.
- Dans le parcours [« GitLab
  fermé »](part2/gitlab/2-contribuer-a-un-depot-existant/2.0-intro.md), nous
  présentons sur l'instance IN2P3 de la forge GitLab un mode de collaboration
  fermé, où le contenu du dépôt git ne peut être lu et modifié que par l'équipe
  projet. C'est une approche adaptée pour des données confidentielles, comme des
  comptes-rendus de réunion ou des recherches non publiées.

De l'expérience des années précédentes, vous n'aurez sans doute pas le temps de
suivre l'intégralité des deux parcours. Nous vous invitons donc à commencer par
celui qui est le plus proche de votre besoin professionnel, quitte à étudier
l'autre plus tard à la maison s'il vous intéresse aussi.
