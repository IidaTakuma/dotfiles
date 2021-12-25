#!/bin/bash

set -u

# 実行中のシェルスクリプトのあるディレクトリに移動
BASE_DIR=$(dirname $0)
cd $BASE_DIR

for f in .??*; do # ワイルドカード / .?[任意の1文字]?[任意の1文字]*[任意の0文字以上の文字列]
    [ "$f" = ".git" ] && continue
    [ "$f" = ".vscode"] && continue
    [ "$f" = ".DS_Store" ] && continue
    ln -snfv ${PWD}/"$f" ~
done
