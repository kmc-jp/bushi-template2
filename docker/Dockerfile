FROM ghcr.io/paperist/texlive-ja:debian

RUN apt-get update \
	&& apt-get install -y \
	ruby \
	pandoc \
	fonts-noto-cjk-extra fonts-noto-color-emoji \
	&& rm -rf /var/lib/apt/lists/*

RUN tlmgr update --self
RUN tlmgr install adfsymbols ulem lualatex-math

WORKDIR /workdir

CMD [ "ruby", "build.rb" ]
