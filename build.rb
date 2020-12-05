#!/usr/bin/env ruby
require 'fileutils'
# pandocのオプションを設定
PANDOC='pandoc -f markdown+east_asian_line_breaks -t latex -N --pdf-engine=lualatex --filter pandoc-citeproc --top-level-division=part --table-of-contents --toc-depth=3'

# クラスファイルを生成
system("lualatex luakmcbook.ins")

# MarkdownをTeXに変換
Dir.glob('kiji/**/*') do |file|
  if FileTest.file? file then
    outfile = file.sub(/^kiji\//, '').sub(/\//, '-').sub(/.md$/, '.tex')
    system("#{PANDOC} -o out/#{outfile} #{file}")
  end
end

# 全体をPDFに変換
FileUtils.cp("bushi.tex", "out/bushi.tex")
FileUtils.cd("out") do
  system("latexmk -lualatex bushi.tex")
end

