DOTFILES_EXCLUDES  := .DS_Store .git .vscode
DOTFILES_TARGET    := $(filter-out $(DOTFILES_EXCLUDES), $(wildcard .??*) bin)
DOTFILES_DIR       := $(PWD)
VSCODE_SETTING_DIR := $(shell echo '$(HOME)/Library/Application Support/Code/User')

# Init
init:
	@make brew_setup
	@make brew
	@make symbolic
	@make vscode

brew_setup:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install from Homebrew
brew:
	brew bundle install

# Set Symbolic file
symbolic:
	@$(foreach val, $(DOTFILES_TARGET), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

# Setting VSCode Configration
vscode:
	-rm "$(VSCODE_SETTING_DIR)/settings.json"
	ln -s "$(DOTFILES_DIR)/.vscode/settings.json" "$(VSCODE_SETTING_DIR)/settings.json"

	-rm "$(VSCODE_SETTING_DIR)/keybindings.json"
	ln -s "$(DOTFILES_DIR)/.vscode/keybindings.json" "$(VSCODE_SETTING_DIR)/keybindings.json"

	cat extensions | while read line; do code --install-extension $${line}; done
	code --list-extensions > extensions
