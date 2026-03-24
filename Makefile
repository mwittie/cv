OUTDIR   = out
SRC      = main.tex publications.tex
BIB      = publications.bib

.PHONY: all cv cover teaching clean

all: $(OUTDIR)/cv.pdf

out:
	mkdir -p $(OUTDIR)

$(OUTDIR)/cv.pdf: $(SRC) $(BIB) | out
	touch $(OUTDIR)/bu.aux
	pdflatex -output-directory=$(OUTDIR) $(SRC)
	for f in $(OUTDIR)/bu[0-9]*.aux; do bibtex "$$f"; done
	pdflatex -output-directory=$(OUTDIR) $(SRC)
	pdflatex -output-directory=$(OUTDIR) $(SRC)
	mv $(OUTDIR)/main.pdf $(OUTDIR)/cv.pdf

cv: $(OUTDIR)/cv.pdf

clean:
	rm -rf $(OUTDIR)