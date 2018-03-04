# Makefile borrowed from github.com/bos/stanford-cs240h
DESTDIR=../../www
MDFILE := $(word 1, $(basename $(wildcard *.md)))
MATHJAXURL='http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML'
L ?= $(MDFILE)
MATH=--mathjax #=$(MATHJAXURL)
#MATH=--mathml
PDOPTS=$(MATH) #--self-contained
#PANDOC=~/.cabal/bin/pandoc $(PDOPTS)
PANDOC=pandoc
PANDOC_WITH_OPTIONS=$(PANDOC) $(PDOPTS)

all: $(L).html $(L)-slides.html
.PHONY: all echo

$(L).html: $(L).md
	@test -f $<
	$(PANDOC_WITH_OPTIONS) -s -t html --mathjax -o $(DESTDIR)/$@ $<

$(L)-slides.html: $(L).md Makefile $(wildcard ./pandoc/slidy/*)
	@test -f $<
	$(PANDOC_WITH_OPTIONS) -s -t slidy -o $(DESTDIR)/$@ $<

echo: 
	echo $(MDFILE)