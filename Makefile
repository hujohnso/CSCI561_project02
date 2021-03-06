TEXFILES=$(wildcard *.tex)
PDFFILES=$(patsubst %.tex,%.pdf,$(TEXFILES))
DOTFILES=$(wildcard graphics/*.dot)
PNGFILES=$(patsubst %.dot,%.png,$(DOTFILES))

all: $(PDFFILES)

graphics:
	mkdir graphics

%.pdf: %.tex $(PNGFILES) | graphics
	xelatex -shell-escape $<

graphics/%.png: graphics/%.dot
	dot -Tpng $< -o $@
