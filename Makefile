SRCS_PRES:=$(wildcard *.odp)
RENDUS_PRES:=$(SRCS_PRES:Pres%.odp=TP/src/Pres%.pdf)
SRCS_TPS:=TP/book.toml $(wildcard TP/src/*) $(wildcard TP/src/demos/*) $(wildcard TP/src/images/*) ${RENDUS_PRES}
RENDUS_TPS:=TP/book

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
	rm TP/src/*.pdf
	rm -rf TP/book

TP/book: ${SRCS_TPS}
	cd TP && rm -rf book && mdbook build

TP/src/Pres%.pdf: Pres%.odp
	loffice --convert-to pdf --outdir TP/src $<
