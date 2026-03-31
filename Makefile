SHELL    := /bin/bash
OUTDIR   = out
SRC      = main.tex *.tex
BIB      = publications.bib

.PHONY: all cv cover teaching clean

all: $(OUTDIR)/cv.pdf

out:
	mkdir -p $(OUTDIR)

$(OUTDIR)/cv.pdf: $(SRC) $(BIB) | out
	pdflatex -output-directory=$(OUTDIR) main.tex
	if ! diff -q \
	    <(sort $(OUTDIR)/bu[0-9]*.aux 2>/dev/null | grep '\\citation') \
	    <(sort $(OUTDIR)/*.bbl.cites 2>/dev/null) > /dev/null 2>&1; then \
	    touch $(OUTDIR)/bu.aux; \
	    for f in $(OUTDIR)/bu[0-9]*.aux; do bibtex "$$f"; done; \
	    sort $(OUTDIR)/bu[0-9]*.aux 2>/dev/null | grep '\\citation' > $(OUTDIR)/main.bbl.cites; \
	    cp $(OUTDIR)/main.aux $(OUTDIR)/main.aux.bak; \
	    pdflatex -output-directory=$(OUTDIR) main.tex; \
	    diff -q $(OUTDIR)/main.aux $(OUTDIR)/main.aux.bak > /dev/null 2>&1 || \
	        pdflatex -output-directory=$(OUTDIR) main.tex; \
	fi
	mv $(OUTDIR)/main.pdf $(OUTDIR)/cv.pdf

cv: $(OUTDIR)/cv.pdf

clean:
	rm -rf $(OUTDIR)