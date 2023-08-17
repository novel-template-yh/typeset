# README

小説組版用テンプレート。

## Usage

### テンプレートとしてcloneする

```
git clone git@github.com:novel-template-yh/typeset.git
cd typeset/
rm -rf .git
git init
```

### 原稿を追加する

```sh
git submodule add < url to manuscripts >
```

その後、原稿を読み込む。

### makeする

```sh
make all # 組版
make zip # pdfをzip圧縮
```