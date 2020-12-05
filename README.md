# bushi-2020winter

2020年冬に出すで出す部誌のリポジトリ

# 部誌の記事公開について

今回部誌に寄せていただいた記事は、無償公開し得ることに同意したものとして扱わせていただきます。

----

# タイプセットする方法
```
$ ruby build.rb
```

- TeXLive, ruby, pandoc(ver. 2)のインストールが必要です

# 記事を書く人へ
記事はMarkdown形式で書いてください。

記法は[こちら](https://pandoc-doc-ja.readthedocs.io/ja/latest/users-guide.html#pandocs-markdown)参照。

## 記事の追加方法
`kiji`ディレクトリ以下にMarkdownファイルを放り込んで、`bushi.tex`に`\include{拡張子抜きのファイル名}`を追加してやったあとビルドすると記事が追加されます。

記事が描けたらPull Requestしてください。

##  一番上の見出しは `#` にしてください
みほん

```
\chapterauthor[tuda]{tuda}

# 校正大会に関して（校正前に必ず読むこと）

～本文～
```
