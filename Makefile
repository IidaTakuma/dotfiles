# DOTFILES_EXCLUDES := .DS_Store .git .vscode
# DOTFILES_TARGET   := $(filter-out $(DOTFILES_EXCLUDES), $(wildcard .??*) bin)
# DOTFILES_DIR      := $(PWD)
# VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User

# initialize:
# 	@$(foreach val, $(wildcard ./etc/init/*.sh), bash $(val);)

# brew:

# set symbolic file DOTFILES_TARGET
# symbolic:
# 	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

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
