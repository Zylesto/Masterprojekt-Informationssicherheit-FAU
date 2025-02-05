NAME := report

all: $(NAME).pdf
.PHONY: clean debug

$(NAME).pdf: $(NAME).tex references.bib
	latexmk -lualatex -silent -interaction=nonstopmode $(NAME).tex

debug:
	latexmk -lualatex $(NAME).tex

clean:
	latexmk -bibtex-cond -c
	rm -rf auto/
	rm -rf *.bbl *.nav *.snm *.run.xml *.synctex.gz

distclean:
	latexmk -bibtex-cond -C
	rm -rf auto/
	rm -rf *.bbl *.nav *.snm *.run.xml *.synctex.gz
