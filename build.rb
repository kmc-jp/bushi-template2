#!/usr/bin/env ruby
require 'fileutils'
# pandocのオプションを設定
PANDOC='pandoc -f markdown+east_asian_line_breaks -t latex -N --pdf-engine=lualatex --top-level-division=chapter --table-of-contents --toc-depth=3'

# kijiの中身を雑にoutにコピー（ディレクトリつくるのめんどいので）
Dir.glob('kiji/*') do |file|
  FileUtils.cp_r(file, 'out')
end

# クラスファイルを生成
system("lualatex luakmcbook.ins")

# latexmkrcをコピー
#FileUtils.cp_r('latexmkrc', './out/latexmkrc')

# MarkdownをTeXに変換
Dir.glob('kiji/**/*') do |file|
  if FileTest.file? file then
    outfile = file.sub(/^kiji\//, '').sub(/.md$/, '.tex')
    system("#{PANDOC} -o out/#{outfile} #{file}")
    puts $? if $?
  end
end

# 全体をPDFに変換
FileUtils.cp("bushi.tex", "out/bushi.tex")
FileUtils.cd("out") do
  system("latexmk -lualatex bushi.tex")
  puts $? if $?
end

