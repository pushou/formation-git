# Ce makefile peut être utilisé sur une session de stagiaire vierge pour
# vérifier le bon fonctionnement de TP et régénérer les archives de rattrapage.

# Input and output file names
SCRIPTS:=$(wildcard *.sh)
NEW_OUTPUT:=$(SCRIPTS:.sh=.out)
REF_OUTPUT:=$(NEW_OUTPUT:.out=.out.ref)
OUTPUT_DIFF:=$(NEW_OUTPUT:.out=.out.diff)
ARCHIVES:=TP2.zip TP3.zip TP4.zip

.PHONY: all clean

all: $(NEW_OUTPUT) $(OUTPUT_DIFF) $(ARCHIVES)
	@printf "\n*** Remember to run 'hunspell <file>' and 'grammalecte-cli -roff typo_tiret_début_ligne esp_début_ligne -owe -iff xyz.md' from time to time ***\n\n"

clean:
	@rm -f $(NEW_OUTPUT) $(OUTPUT_DIFF) $(ARCHIVES)

%.out: %.sh
	@rm -f $@
	@echo "=== Will now run $< and save output to $@"
	@./$< 2>&1 | tee $@

%.out.diff: %.out
	@DIFF=$(diff -Nu $<.ref $< | tee $@) && \
	if [ -e $<.ref ]; then \
		if [ ! -z "${DIFF}" ]; then \
			echo "=== Please inspect difference between $< and reference $<.ref:" && \
			diff -Nu --color $<.ref $< && \
			echo "=== Difference was saved to $@"; \
		fi; \
	else \
		echo "=== No reference found for $<." && \
		echo "=== Please review $< and run 'cp $< $<.ref' if it seems correct"; \
	fi

%.zip:
	@rm -f $@
	@(cd ~/Desktop && zip -qr $@ *) && mv ~/Desktop/$@ .

TP2.zip: premiers-pas.out
premiers-pas-corrige.out: TP2.zip

historique-lineaire.out: premiers-pas-corrige.out
TP3.zip: historique-lineaire.out
historique-lineaire-corrige.out: TP3.zip

manipulation-branches.out: historique-lineaire-corrige.out
TP4.zip: manipulation-branches.out

depots-distribues.out: TP4.zip

reseau-forges.out: TP4.zip

# TODO: Keep dependencies up to date
