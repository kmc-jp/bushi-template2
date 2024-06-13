all: pdf

kijis := $(wildcard kiji/*.md)
texs := $(addprefix out/,$(notdir $(kijis:.md=.tex)))

CP := cp -f
MKDIR := mkdir -p
RM := rm -fr
ERB := erb
PWD := $(shell pwd)

BUILD_IMAGE_TAG := latest

PANDOC := pandoc -f markdown+east_asian_line_breaks -t latex -N --pdf-engine=lualatex --top-level-division=chapter --table-of-contents --toc-depth=3
RUN_AT := docker run --mount type=bind,source="$(PWD)",target=/workdir ghcr.io/kmc-jp/bushi-build-image:$(BUILD_IMAGE_TAG)

pdf: $(texs) out/bushi.tex out/luakmcbook.cls covers
	cd out && latexmk -lualatex bushi.tex

out/%.tex: kiji/%.md
	$(PANDOC) -o $@ $^

out/luakmcbook.cls: out/luakmcbook.dtx out/luakmcbook.ins
	lualatex luakmcbook.ins

out/bushi.tex: bushi.tex out/build_at.tex
	$(CP) $< $@
out/luakmcbook.dtx: luakmcbook.dtx
	$(CP) $< $@
out/luakmcbook.ins: luakmcbook.ins
	$(CP) $< $@

out/build_at.tex: build_at.tex.erb
	$(ERB) $< > $@

covers: $(wildcard cover/*)
	$(MKDIR) out/cover
	$(CP) $^ out/

docker:
	$(RUN_AT) make
.PHONY: docker

clean:
	$(RM) out/*
.PHONY: clean
