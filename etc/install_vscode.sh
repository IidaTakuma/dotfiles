#!/bin/sh

set -u

VSCODE_SETTING_DIR="${HOME}/Library/Application Support/Code/User"
echo "vscode_setting_dir: $VSCODE_SETTING_DIR"

SCRIPT_DIR=$(cd $(dirname $0)/../.vscode && pwd)
echo "script_dir: $SCRIPT_DIR"

rm "$VSCODE_SETTING_DIR/settings.json"
ln -s "${SCRIPT_DIR}/settings.json" "${VSCODE_SETTING_DIR}/settings.json"

rm "$VSCODE_SETTING_DIR/keybindings.json"
ln -s "${SCRIPT_DIR}/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings.json"

cd $SCRIPT_DIR

cat extensions | while read line
do
    code --install-extension $line
done

code --list-extensions > extensions
