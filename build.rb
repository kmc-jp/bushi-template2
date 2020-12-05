#!/usr/bin/env ruby

# pandocのオプションを設定
PANDOC='pandoc -f markdown+east_asian_line_breaks -t latex -N --pdf-engine=lualatex --filter pandoc-citeproc --top-level-division=chapter --table-of-contents --toc-depth=3'

# 記事を順番に書く
FILELIST=<<'EOS'
top.md
recent-kmc.md
recent-kmc/kyopro.md
columns.md
kousei.md
EOS

# MarkdownをTeXに変換
files = FILELIST.gsub(/^/, "kiji/").gsub(/\n/, " ")
system("#{PANDOC} -o out/hoge.pdf #{files}")

