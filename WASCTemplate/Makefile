SHELL := /bin/bash
filename=main


all: 
	python ./scripts/section_list.py
	pdflatex ${filename}.tex ${filename}.pdf
	pdflatex ${filename}.tex ${filename}.pdf
	pdflatex ${filename}.tex ${filename}.pdf

pdf: psX
	ps2pdf ${filename}.ps

pdf-print: ps
	ps2pdf -ColorConversionStrategy=/LeaveColorUnchanged -dPDFSETTINGS=/printer ${filename}.ps

text: html
	html2text -width 100 -style pretty ${filename}/${filename}.html | sed -n '/./,$$p' | head -n-2 >${filename}.txt

html:
	python ./scripts/section_list.py
	@latex2html -split +0 -info "Ths is the info" -no_navigation ${filename}
	htlatex ${filename}

ps: dvi
	dvips -t letter ${filename}.dvi

dvi:
	latex ${filename}
	bibtex ${filename}||true
	latex ${filename}
	latex ${filename}

read:
	evince ${filename}.pdf

aread: 
	acroread ${filename}.pdf

.PHONY : clean
clean:
	rm -f *.{ps,pdf,log,aux,out,dvi,bbl,blg,4tc,4ct,css,idv,lg,html,xref,tmp} sections.tex
	rm -f sections/*.*
	rm -f sections/*/*.{ps,pdf,log,aux,out,dvi,bbl,blg}
test:
	echo "hey"

edit:
	emacs . &

.SILENT: clean read 
