SHELL    := /bin/bash
SRC      = main.tex *.tex
BIB      = publications.bib

.PHONY: all cv clean

all: cv

cv: tmp/main.pdf

tmp/main.pdf: $(SRC) $(BIB)
	latexmk -pdf main.tex

clean:
	rm -rf tmp
