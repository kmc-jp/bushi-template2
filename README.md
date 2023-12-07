# bushi-template

Xで出す部誌のリポジトリ

* [記事を追加する方法](#記事を書く人へ)

# 部誌の記事公開について

今回部誌に寄せていただいた記事は、無償公開し得ることに同意したものとして扱わせていただきます。

----

# タイプセットする方法
dockerだと
```
docker run --mount type=bind,source="$(pwd)",target=/workdir ghcr.io/kmc-jp/bushi-build-image:latest make
```

そうでない時は単に
```
$ ruby build.rb
```

- TeXLive, ruby, pandoc(ver. 2)のインストールが必要です

## CIによるタイプセット
レポジトリにpushすると、CIによりタイプセットが行なわれて、pdfが自動で生成されます。
正常にタイプセットできた場合、GitHub Actionsのrun結果のページを開くと、
artifactにbushi.pdfという項目があります。
[![Image from Gyazo](https://i.gyazo.com/9cc637c1b1db1eff9e169585df6fcaca.png)](https://gyazo.com/9cc637c1b1db1eff9e169585df6fcaca)

これは、.github/workflows/build.yamlにて行なっています。

## dockerのimageの更新方法
.github/workflows/image.yaml でimageを作成しています。
`image/` から始まるtagをpushすると自動で作成されます。

forkした先でtagをpushしても動作するとは思いますが、
ややこしいので https://github.com/kmc-jp/bushi-template2 へのtagのpushで作成して欲しいです。

https://github.com/kmc-jp/bushi-template2/pkgs/container/bushi-build-image にimageのリストがあります。

## 記事のタグ
.github/workflows/release.yaml で `rel/` から始まるタグがpushされた際にreleaseを作成しています。
こちらは、imageとは異なり、fork先のレポジトリでリリース版を作成する時とかに使うことを想定しています。

# 記事を書く人へ
* 記事はMarkdown記法で書いてください。
* **[校正規約](https://github.com/kmc-jp/bushi-template2/blob/master/kiji/kousei.md)を読んでください。**
* [Markdownの記法の詳細](https://pandoc-doc-ja.readthedocs.io/ja/latest/users-guide.html#pandocs-markdown)も参照。

## 記事の追加方法
* `kiji`ディレクトリ以下にMarkdownファイルを置いてください。
* `bushi.tex`に`\include{拡張子抜きのファイル名}`を追加して、ビルドすると記事が追加されます。
* 記事が描けたらPull Requestしてください。

ディレクトリ構造
```
- bushi.tex
- /kiji
  - /good-page # 作る
     - good-page.md # 書く
     - /images # 画像を使うなら
        - good-image.png
```

##  記事の書き出しは次のようにしてください

```
\chapterauthor[名前]{名前}

# 記事のタイトル

本文
```

## 簡単にわかるMarkdown記法


* `# 記事タイトル` （記事内に1つ）
* `## サブ見出し` `### サブサブ見出し`
* **強調** `**強調**`
* URLは`\url`を使って脚注に入れるのをおすすめします。
  * `\footnote{\url{https://example.com}}`
* その他のわからんについては、TeXを組む必要もあるので、相談してください。

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

画像の配置や段落の配置などのこだわりは入稿の手前で行うので、あまりこだわらないでください。
