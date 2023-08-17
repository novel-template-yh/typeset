% a6_titlepage.cls

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{a6_titlepage}

\LoadClass[
    lualatex,                       % lualatexを使う
    yoko,                           % 横書き
    book,                           % 本
    paper=A6,                       % 紙の大きさは文庫本断ち切り
    fontsize=8.0pt,                 % 基本フォントサイズは8.0pt
    jafontsize=8.0pt,               % 日本語フォントサイズは8.0pt
]{jlreq}
