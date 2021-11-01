FROM ghcr.io/paperist/texlive-ja:debian

RUN apt-get update \
	&& apt-get install -y \
	ruby \
	fontconfig \
	fonts-noto-cjk-extra fonts-noto-color-emoji \
	xz-utils \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/local/share/fonts/ \
  && cd /tmp \
  && wget https://github.com/adobe-fonts/source-sans/releases/download/3.046R/TTF-source-sans-3.046R.zip -O /tmp/sourceSans.zip \
	&& unzip /tmp/sourceSans.zip \
	&& wget https://github.com/adobe-fonts/source-code-pro/releases/download/2.038R-ro%2F1.058R-it%2F1.018R-VAR/TTF-source-code-pro-2.038R-ro-1.058R-it.zip -O /tmp/sourceCourde.zip \
	&& unzip /tmp/sourceCourde.zip -d /tmp/TTF \
	&& mv /tmp/TTF/*.ttf /usr/local/share/fonts/ \
	&& wget https://github.com/adobe-fonts/source-han-sans/releases/download/2.004R/SourceHanSansJP.zip -O /tmp/SourceHanSansJP.zip \
	&& unzip /tmp/SourceHanSansJP.zip \
	&& mv /tmp/SubsetOTF/JP/*.otf /usr/local/share/fonts/ \
	&& fc-cache \
	&& rm -rf /tmp/*

RUN cd /tmp \
	&& wget https://github.com/jgm/pandoc/releases/download/2.16/pandoc-2.16-1-amd64.deb -O pandoc.deb \
	&& dpkg -i pandoc.deb \
	&& rm -rf /tmp/*

RUN cd /tmp \
	&& wget https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.12.0d/pandoc-crossref-Linux.tar.xz -O pandoc-crossref-Linux.tar.xz \
	&& tar xf pandoc-crossref-Linux.tar.xz \
	&& chmod +x pandoc-crossref \
	&& mv pandoc-crossref /usr/local/bin \
	&& rm -rf /tmp/*

RUN tlmgr update --self
RUN tlmgr install adfsymbols ulem lualatex-math

WORKDIR /workdir

CMD [ "ruby", "build.rb" ]
