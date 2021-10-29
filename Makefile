DOTFILES_EXCLUDES  := .DS_Store .git .vscode
DOTFILES_TARGET    := $(filter-out $(DOTFILES_EXCLUDES), $(wildcard .??*) bin)
DOTFILES_DIR       := $(PWD)

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
	-rm "$(HOME)/Library/Application Support/Code/User/settings.json"
	ln -s ${DOTFILES_DIR}/.vscode/settings.json "$(HOME)/Library/Application Support/Code/User/settings.json"

	-rm "$(HOME)/Library/Application Support/Code/User/keybindings.json"
	ln -s ${DOTFILES_DIR}/.vscode/keybindings.json "$(HOME)/Library/Application Support/Code/User/keybindings.json"

	cat extensions | while read line; do code --install-extension $${line}; done
	code --list-extensions > extensions
