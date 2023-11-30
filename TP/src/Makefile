# Ce makefile peut être utilisé sur une session de stagiaire vierge pour
# vérifier le bon fonctionnement de TP et régénérer les archives de rattrapage.

# Fichiers d'entrée et de sorties
SCRIPTS:=$(wildcard *.sh)
NEW_OUTPUT:=$(SCRIPTS:.sh=.out)
REF_OUTPUT:=$(NEW_OUTPUT:.out=.out.ref)
OUTPUT_DIFF:=$(NEW_OUTPUT:.out=.out.diff)
ARCHIVES:=TP2.zip TP3.zip TP4.zip

# Recettes principales
.PHONY: all clean

all: $(NEW_OUTPUT) $(OUTPUT_DIFF) $(ARCHIVES)
	@printf "\n*** Remember to run 'hunspell <file>' and 'grammalecte-cli -roff typo_tiret_début_ligne esp_début_ligne -owe -iff xyz.md' from time to time ***\n\n"

clean:
	@rm -f $(NEW_OUTPUT) $(OUTPUT_DIFF) $(ARCHIVES)

# Exécution monitorée d'un script
%.out: %.sh
	@rm -f $@
	@echo "=== Will now run $< and save output to $@"
	@./$< 2>&1 | tee $@

# Comparaison de la sortie à la référence
%.out.diff: %.out
	@export DIFF=$$(diff -Nu $<.ref $< | tee $@) && \
	if [ -e $<.ref ]; then \
		echo "=== Please inspect difference between $< and reference $<.ref:" && \
		diff -Nu --color $<.ref $< && \
		echo "=== Difference was saved to $@"; \
	else \
		echo "=== No reference found for $<." && \
		echo "=== Please review $< and run 'cp $< $<.ref' if it seems correct"; \
	fi

# Sauvegarde d'un zip de rattrapage
%.zip:
	@rm -f $@
	@(cd ~/Desktop && zip -qr $@ *) && mv ~/Desktop/$@ .

# Ordre d'exécution des TPs et leurs corrigés
TP2.zip: premiers-pas.out
premiers-pas-corrige.out: TP2.zip
#
historique-lineaire.out: premiers-pas-corrige.out
TP3.zip: historique-lineaire.out
historique-lineaire-corrige.out: TP3.zip
#
manipulation-branches.out: historique-lineaire-corrige.out
TP4.zip: manipulation-branches.out
manipulation-branches-corrige.out: TP4.zip
#
depots-distribues.out: manipulation-branches-corrige.out
depots-distribues-corrige.out: depots-distribues.out
#
reseau-forges.out: depots-distribues-corrige.out
reseau-forges-corrige.out: reseau-forges.out
