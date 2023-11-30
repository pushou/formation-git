# TODO: Adapter à la nouvelle configuration mdbook
SRCS_TPS:=$(wildcard TP*.md)
RENDUS_TPS:=$(SRCS_TPS:TP%.md=Rendus/TP%.pdf)
SRCS_PRES:=$(wildcard *.odp)
RENDUS_PRES:=$(SRCS_PRES:Pres%.odp=Rendus/Pres%.pdf)

.PHONY: all clean

all: ${RENDUS_TPS} ${RENDUS_PRES}

clean:
	rm Rendus/*.pdf
	rm -rf TP/book

# TODO: Adapter à la nouvelle configuration mdbook
Rendus/TP%.pdf: TP%.md Images/*.png
	pandoc -f markdown -t latex -o "$@" "$<"

Rendus/Pres%.pdf: Pres%.odp
	loimpress --convert-to pdf --outdir Rendus $<
