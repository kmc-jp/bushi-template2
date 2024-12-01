all: pdf

kijis := $(shell find kiji -name '*.md')
texs := $(patsubst kiji/%,out/%,$(kijis:.md=.tex))
images := $(shell find kiji -name '*.jpg' -or -name '*.jpeg' -or -name '*.png' -or -name '*.pdf')
outdirs := $(sort $(dir $(texs)) $(dir $(patsubst kiji/%,out/%,$(images))))

CP := cp -f
MKDIR := mkdir -p
RM := rm -fr
PWD := $(shell pwd)

BUILD_IMAGE_TAG := latest

PANDOC := pandoc -f markdown+east_asian_line_breaks -t latex -N --pdf-engine=lualatex --top-level-division=chapter --table-of-contents --toc-depth=3
RUN_AT := docker run --mount type=bind,source="$(PWD)",target=/workdir ghcr.io/kmc-jp/bushi-build-image:$(BUILD_IMAGE_TAG)

$(outdirs):
	$(MKDIR) $@

outimages: $(outdirs) $(images)
	$(foreach image,$(images),$(CP) $(image) $(patsubst kiji/%,out/%,$(image));)

pdf: $(outdirs) outimages $(texs) out/bushi.tex out/luakmcbook.cls covers
	cd out && latexmk -lualatex bushi.tex

out/%.tex: kiji/%.md
	$(PANDOC) -o $@ $^

out/luakmcbook.cls: out/luakmcbook.dtx out/luakmcbook.ins
	lualatex luakmcbook.ins

out/bushi.tex: bushi.tex
	$(CP) $< $@
out/luakmcbook.dtx: luakmcbook.dtx
	$(CP) $< $@
out/luakmcbook.ins: luakmcbook.ins
	$(CP) $< $@

covers: $(wildcard cover/*)
	$(MKDIR) out/cover
	$(CP) $^ out/

docker:
	$(RUN_AT) make
.PHONY: docker

clean:
	$(RM) out/*
.PHONY: clean
