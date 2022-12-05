SRCS_TPS:=$(wildcard TP*.md)
RENDUS_TPS:=$(SRCS_TPS:TP%.md=Rendus/TP%.pdf)
SRCS_PRES:=$(wildcard *.odp)
RENDUS_PRES:=$(SRCS_PRES:Pres%.odp=Rendus/Pres%.pdf)

.PHONY: all clean

all: ${RENDUS_TPS} ${RENDUS_PRES}
	@printf "\n*** Remember to run 'hunspell <file>' and 'grammalecte-cli -roff typo_tiret_début_ligne esp_début_ligne -owe -iff xyz.md' from time to time ***\n\n"

clean:
	rm Rendus/*.pdf

Rendus/TP%.pdf: TP%.md Images/*.png
	pandoc -f markdown -t latex -o "$@" "$<"

Rendus/Pres%.pdf: Pres%.odp
	loimpress --convert-to pdf --outdir Rendus $<
