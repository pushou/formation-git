# Ce makefile peut être utilisé sur une session de stagiaire vierge pour
# vérifier le bon fonctionnement de TP et régénérer les archives de rattrapage.

# Fichiers d'entrée et de sorties
SCRIPTS:=$(wildcard *.sh)
NEW_OUTPUT:=$(SCRIPTS:.sh=.out)
NORMALIZED_OUTPUT:=$(NEW_OUTPUT:.out=.out.norm)
REF_OUTPUT:=$(NORMALIZED_OUTPUT:.out.norm=.out.norm.ref)
OUTPUT_DIFF:=$(NEW_OUTPUT:.out=.out.diff)
ARCHIVES:=TP2.zip TP3.zip TP4.zip

# Recettes principales
.PHONY: all clean

all: $(NEW_OUTPUT) $(NORMALIZED_OUTPUT) $(OUTPUT_DIFF) $(ARCHIVES)
	@printf "\n*** Remember to run 'hunspell <file>' and 'grammalecte-cli -on idrule liga -roff typo_tiret_début_ligne esp_début_ligne majuscule_début_paragraphe -owe -iff xyz.md' from time to time ***\n\n"

clean:
	@rm -f $(NEW_OUTPUT) $(NORMALIZED_OUTPUT) $(OUTPUT_DIFF) $(ARCHIVES)

# Exécution monitorée d'un script
%.out: %.sh
	@rm -f $@
	@echo "=== Will now run $< and save output to $@"
	@./$< 2>&1 | tee $@

# Comparaison de la sortie à la référence
%.out.norm: %.out
	@echo "=== Will now normalize $< and save output to $@"
	@normalize-git-output $< > $@
#
%.out.diff: %.out.norm
	@if [ -e $<.ref ]; then \
		diff -Nu $<.ref $< > $@; \
		if [ -s $@ ]; then \
			echo "=== Please inspect difference between $< and reference $<.ref:" && \
			diff -Nu --color $<.ref $<; \
			echo "=== Difference was saved to $@"; \
		fi; \
	else \
		echo "=== No reference found for $<." && \
		echo "=== Please review $< and run 'cp $< $<.ref' if it seems correct"; \
	fi

# Sauvegarde d'un zip de rattrapage
%.zip:
	@rm -f $@
	@(cd ~/Desktop && zip -qr $@ *) && mv ~/Desktop/$@ .

# Ordre d'exécution des TPs et leurs corrigés
TP2.zip: 1-premiers-pas.out
1-premiers-pas-corrige.out: TP2.zip
#
2-historique-lineaire.out: 1-premiers-pas-corrige.out
TP3.zip: 2-historique-lineaire.out
2-historique-lineaire-corrige.out: TP3.zip
#
3-manipulation-branches.out: 2-historique-lineaire-corrige.out
TP4.zip: 3-manipulation-branches.out
3-manipulation-branches-corrige.out: TP4.zip
#
4-depots-distribues.out: 3-manipulation-branches-corrige.out
4-depots-distribues-corrige.out: 4-depots-distribues.out
#
5-reseau-forges.out: 4-depots-distribues-corrige.out
