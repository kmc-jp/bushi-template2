FROM ghcr.io/kmc-jp/arch-texlive-ja:latest

RUN pacman -Sy --noconfirm && \
	pacman -S --noconfirm ruby pandoc adobe-source-sans-fonts

RUN tlmgr update --self
RUN tlmgr install adfsymbols ulem lualatex-math

WORKDIR /workdir

CMD [ "ruby", "build.rb" ]
