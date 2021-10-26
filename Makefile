DOTFILES_EXCLUDES := .DS_Store .git .vscode
DOTFILES_TARGET   := $(filter-out $(DOTFILES_EXCLUDES), $(wildcard .??*) bin)
VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User

# Install from Homebrew
.PHONY: brew
brew:
	brew bundle install

# Set Symbolic file
.PHONY: symbolic
symbolic:
	@$(foreach val, $(DOTFILES_TARGET), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

# Setting VSCode Configration
# vscode:
# 	rm "$VSCODE_SETTING_DIR/settings.json"
# 	ln -s "$SCRIPT_DIR/settings.json" "${VSCODE_SETTING_DIR}/settings.json"

# 	rm "$VSCODE_SETTING_DIR/keybindings.json"
# 	ln -s "$SCRIPT_DIR/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings.json"

# 	cat ./extensions | while read line
# 	do
# 	code --install-extension $line
# 	done

# 	code --list-extensions > extensions
