DOTFILES_EXCLUDES := .DS_Store .git .vscode
DOTFILES_TARGET   := $(filter-out $(DOTFILES_EXCLUDES), $(wildcard .??*) bin)
MAKEFILE_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
# DOTFILES_DIR      := $(PWD)
# VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User

# initialize:
# 	@$(foreach val, $(wildcard ./etc/init/*.sh), bash $(val);)
.PHONY: brew
brew:
	brew bundle install

# set symbolic file DOTFILES_TARGET
.PHONY: symbolic
symbolic:
	@$(foreach val, $(DOTFILES_TARGET), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

.PHONY: vscode
vscode:
	echo $(MAKEFILE_DIR)
	SCRIPT_DIR=$(cd $(dirname $0) && pwd)
	rm "$(VSCODE_SETTING_DIR/settings.json)"
	ln -s "$(SCRIPT_DIR/settings.json)" "${VSCODE_SETTING_DIR}/settings.json"

	rm "$VSCODE_SETTING_DIR/keybindings.json"
	ln -s "$SCRIPT_DIR/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings.json"

	cat ./extensions | while read line
	do
	code --install-extension $line
	done

	code --list-extensions > extensions

.PHONY: sample
sample:
	@echo $(MAKEFILE_DIR)
