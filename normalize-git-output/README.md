# Normalisation des sorties de TP

Normalement, les sorties des commandes de TP varient d'une exécution à l'autre
car il y a plusieurs paramètres non-reproductibles présents dans les sorties:
_timestamps_ et _hashes_ git qui en dépendent, génération aléatoire de _token_
gitlab et de clé SSH...

Ce programme Rust fait le ménage dans tout ça et produit des fichiers qui
devraient être reproductibles d'une exécution à l'autre. Toute différence qui
émerge est donc le fruit d'une véritable différence dans le comportement du TP,
issue par exemple d'une mise à jour système.
