# Ce makefile peut être utilisé sur une session de stagiaire vierge pour
# vérifier le bon fonctionnement de TP et régénérer les archives de rattrapage.

# Input and output file names
SCRIPTS:=$(wildcard *.sh)
NEW_OUTPUT:=$(SCRIPTS:.sh=.out)
REF_OUTPUT:=$(NEW_OUTPUT:.out=.out.ref)
OUTPUT_DIFF:=$(NEW_OUTPUT:.out=.out.diff)
ARCHIVES:=TP2.zip TP3.zip TP4.zip TP5.zip

.PHONY: all clean

all: $(NEW_OUTPUT) $(OUTPUT_DIFF) $(ARCHIVES)

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
			echo "=== Found difference between $< and reference $<.ref" && \
			diff -Nu --color $<.ref $< && \
			echo "=== Difference was saved to $@"; \
		fi; \
	else \
		echo "=== No reference found for $<" && \
		echo "=== Please review $< and run 'cp $< $<.ref' if it seems correct"; \
	fi

%.zip:
	@rm -f $@
	@(cd ~/Desktop && zip -qr $@ *) && mv ~/Desktop/$@ .

TP2.zip: premiers-pas.out

historique-lineaire.out: TP2.zip

TP3.zip: historique-lineaire.out

manipulation-branches.out: TP3.zip

TP4.zip: manipulation-branches.out

# TODO: Add dependency rules TP4.out: TP4.zip, TP5.zip: TP4.out etc
