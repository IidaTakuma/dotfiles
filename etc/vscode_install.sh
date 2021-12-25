#!/bin/sh

set -u

VSCODE_SETTING_DIR="${HOME}/Library/Application Support/Code/User"

# 実行中のシェルスクリプトのあるディレクトリを起点に .vscode ディレクトリに移動
SCRIPT_DIR=$(cd $(dirname $0)/../.vscode && pwd)
echo $SCRIPT_DIR

rm "$VSCODE_SETTING_DIR/settings.json"
ln -s "${SCRIPT_DIR}/settings.json" "${VSCODE_SETTING_DIR}/settings.json"

rm "$VSCODE_SETTING_DIR/keybindings.json"
ln -s "${SCRIPT_DIR}/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings.json"

cd $SCRIPT_DIR

cat extensions | while read line
do
    echo $line
    code --install-extension $line
done

code --list-extensions > extensions
