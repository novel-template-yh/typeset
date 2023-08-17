# Makefile

TITLE=dist_title

.PHONY: cleanup
cleanup:
	sh ./.scripts/cleanup.sh

.PHONY: banish
banish:
	rm $(TITLE).zip

.PHONY: mkdir
mkdir:
	mkdir $(TITLE)
	mkdir $(TITLE)/asset
	mkdir $(TITLE)/main
	touch $(TITLE)/readme.txt
	touch $(TITLE)/asset/asset.txt
	touch $(TITLE)/main/main.txt

.PHONY: all
all:
	make main
	make cover
	make zip

.PHONY: main
main:
	make titlepage.pdf
	make main.pdf
	make colophon.pdf
	make body.pdf
	make body-cropmark.pdf
	make cleanup

.PHONY: cover
cover:
	make front.pdf
	make spine.pdf
	make back.pdf
	make cover.pdf
	make cover-cropmark.pdf

.PHONY: zip
zip:
	make $(TITLE).zip

# main

titlepage.pdf: body/titlepage.tex
	latexmk -cd body/titlepage.tex
	mv body/titlepage.pdf cropmark/titlepage.pdf

main.pdf: body/main.tex
	latexmk -cd body/main.tex
	mv body/main.pdf cropmark/main.pdf

colophon.pdf: body/colophon.tex
	latexmk -cd body/colophon.tex
	mv body/colophon.pdf cropmark/colophon.pdf

body.pdf: cropmark/titlepage.pdf cropmark/main.pdf cropmark/colophon.pdf
	pdfunite cropmark/titlepage.pdf cropmark/main.pdf cropmark/colophon.pdf cropmark/body.pdf
	rm cropmark/titlepage.pdf cropmark/main.pdf cropmark/colophon.pdf

body-cropmark.pdf: cropmark/body-cropmark.tex
	latexmk -cd cropmark/body-cropmark.tex
	mv cropmark/body-cropmark.pdf $(TITLE)/main/body-cropmark.pdf

# cover

front.pdf: cover/front.tex
	latexmk -cd cover/front.tex
	mv cover/front.pdf cropmark/front.pdf

spine.pdf: cover/spine.tex
	latexmk -cd cover/spine.tex
	mv cover/spine.pdf cropmark/spine.pdf

back.pdf: cover/back.tex
	latexmk -cd cover/back.tex
	mv cover/back.pdf cropmark/back.pdf

cover.pdf: cropmark/front.pdf cropmark/spine.pdf cropmark/back.pdf
	pdfjam \
		--nup 3x1 --papersize '{220mm,148mm}' --delta '{-47.5mm 0mm}' \
			cropmark/front.pdf \
			cropmark/spine.pdf \
			cropmark/back.pdf \
		-o cropmark/cover.pdf
	rm cropmark/front.pdf cropmark/spine.pdf cropmark/back.pdf


cover-cropmark.pdf: cropmark/cover-cropmark.tex
	latexmk -cd cropmark/cover-cropmark.tex
	mv cropmark/cover-cropmark.pdf $(TITLE)/main/cover-cropmark.pdf

$(TITLE).zip: $(TITLE)/*
	zip -r $(TITLE).zip $(TITLE)/
