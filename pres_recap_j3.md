# Récapitulatif Jour 3 
# et Conclusion 
## Formation Git

Hadrien GRASLAND & Sonny LION

---
layout: two-cols-header
---

## GitLab vs GitHub : quelles différences ?

::left::

### Parcours GitLab (IN2P3) - fermé

- Pas de _forks_ (lié à la politique du CC-IN2P3)
- Travail direct sur le dépôt avec branches dédiées
- Requiert la confiance entre contributeurs
- Plus simple mais moins adapté aux contributions externes


::right::

### Parcours GitHub - ouvert

- Modèle classique en _open source_ avec système de _fork_
- 3 dépôts : **upstream** (officiel) + **origin** (fork) + **local**
- Contributions externes via _pull requests_
- Plus lourd mais limite les risques de malveillance

CI/CD : syntaxes différentes mais fonctionnalités similaires (stages/jobs, automatisation, artefacts)

---

<style>
  h3 {
    margin-top: 20px;
  }
</style>

## Création et gestion d'un dépôt sur une forge


### Attention

- Au nom du dépôt
- À sa visibilité (public/privé)
- À la licence choisie
- À qui vous accordez des droits d'accès

### Bonnes pratiques

- Organisation via tickets (_issues_)
- _Merge/pull requests_ et revues
- Protection de `main` (pas de push direct)


<style>
  h3 {
    margin-top: 20px;
  }
</style>

---

## CI/CD avec GitLab ou GitHub

Des syntaxes différentes mais des concepts similaires :

- GitLab CI : `.gitlab-ci.yml` avec stages/jobs/runners
- GitHub Actions : `.github/workflows/` avec workflows/jobs/steps

Qui permettent de :

- Valider/vérifier automatiquement le contenu du dépôt
- Générer des fichiers de sortie (artefacts)
- Publier/déployer automatiquement
- Héberger un site statique avec GitLab Pages / GitHub Pages

---

## GitHub Flow : les 4 principes appliqués

Méthode de travail collaboratif maîtrisée :

1. Se maintenir à jour : `git fetch` / `git pull`
2. Développer dans une **branche dédiée** : `git checkout -b my-feature`
3. Publier la branche : `git push --set-upstream origin my-feature`
4. Proposer l'intégration : ouvrir une _merge/pull request_

Workflow complet : Ticket → Branche → Édition → Push → MR/PR → Revue → Fusion → Nettoyage

---
layout: two-cols-header
---

## Après trois jours de formation...

::left::

Vous savez maintenant :

- Utiliser Git en ligne de commande
- Configurer une clé SSH et gérer des _remotes_
- Organiser le travail avec des _issues_
- Collaborer via _merge/pull requests_ et revues
- Gérer les conflits
- Gérer les permissions et protéger les branches critiques
- Mettre en place une CI/CD basique pour automatiser des tâches

::right::

Quelques bonnes pratiques pour limiter les conflits et fluidifier vos collaborations :

- Petites contributions
- Synchronisation fréquente
- Revue systématique
- Automatisation et normalisation (attention à ne pas trop complexifier !)

---

## Le mot de la fin

Cette formation est « open-source » !

- Source sur https://gitlab.in2p3.fr/grasland/formation-git
- Licence CC-BY-SA = Copiez à votre guise tant que…
  * Vous nous citez (obligation légale en France…)
  * Vous redistribuez vos versions modifiées en CC-BY-SA
