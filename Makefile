SRCS_TPS:=TP/book.toml $(wildcard TP/src/*) $(wildcard TP/src/images/*)
RENDUS_TPS:=TP/book
SRCS_PRES:=$(wildcard *.odp)
RENDUS_PRES:=$(SRCS_PRES:Pres%.odp=Rendus/Pres%.pdf)

.PHONY: all clean

all: ${RENDUS_TPS} ${RENDUS_PRES}
	@printf "\n*** Une fois les énoncés de TPs finalisés, pensez à vérifier le \
	bon fonctionnement des commandes sur la plate-forme de TP.\n\
	*** Pour ça, lancez make dans TP/src sur une session utilisateur vierge mais \
	possédant un ~/Desktop.\n\
	*** Cela vérifiera que tout fonctionne et régénérera les archives TPx.zip \
	pour les rattrapages.\n\
	*** Vous pourrez ensuite faire le ménage avec un petit \
	'rm -rf ~/.gitconfig ~/Desktop/*'.\n\n"

clean:
	rm Rendus/*.pdf
	rm -rf TP/book

TP/book: ${SRCS_TPS}
	cd TP && rm -rf book && mdbook build

Rendus/Pres%.pdf: Pres%.odp
	loimpress --convert-to pdf --outdir Rendus $<
