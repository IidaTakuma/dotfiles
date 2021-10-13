#!/usr/bin/env bash

BASE_DIR=$(dirname $0)
DOTFILES_DIR=$BASE_DIR/../../

# 未定義の変数があったら途中で終了
set -u

# dorfilesのルートディレクトリに移動
cd $DOTFILES_DIR
echo $(pwd)

# dotfilesディレクトリにあるドット始まり2文字以上の名前ファイルにシンボリックリンクを貼る
for f in .??*; do
    [ "$f" = ".git" ] && continue

    ln -snfv ${PWD}/"$f" ~/
done
