# bushi-template

Xで出す部誌のリポジトリ

# 部誌の記事公開について

今回部誌に寄せていただいた記事は、無償公開し得ることに同意したものとして扱わせていただきます。

----

# タイプセットする方法
dockerだと
```
docker run --mount type=bind,source="$(pwd)",target=/workdir ghcr.io/kmc-jp/bushi-build-image:latest
```

そうでない時は単に
```
$ ruby build.rb
```

- TeXLive, ruby, pandoc(ver. 2)のインストールが必要です

## dockerのimageの更新方法
.github/workflows/image.yaml でimageを作成しています。
`image/` から始まるtagをpushすると自動で作成されます。

forkした先でtagをpushしても動作するとは思いますが、
ややこしいので https://github.com/kmc-jp/bushi-template2 へのtagのpushで作成して欲しいです。

https://github.com/kmc-jp/bushi-template2/pkgs/container/bushi-build-image にimageのリストがあります。

## 記事のタグ
.github/workflows/release.yaml で `kiji/` から始まるタグがpushされた際にreleaseを作成しています。
こちらは、imageとは異なり、fork先のレポジトリでリリース版を作成する時とかに使うことを想定しています。

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

## 画像を足したいときは
自分の記事が`kiji/suzusime/sime.md`なら、`kiji/suzusime/images/hoge.png`に画像を置いて、

bushi.texの

```
% 画像を子ディレクトリから参照したいときは
% \graphicspath{{hoge1/}{hoge2/}} みたいに足していってね
\graphicspath{{./}{recent-kmc/}}
```

のところを

```
% 画像を子ディレクトリから参照したいときは
% \graphicspath{{hoge1/}{hoge2/}} みたいに足していってね
\graphicspath{{./}{recent-kmc/}{suzusime/}}
```

のように書き換えて、記事には

```
![](images/hoge.jpg){ width=50mm }
```

のように書いてください。

