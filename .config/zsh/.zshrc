# Read only for login shells and interactive shells.

# Set Homebrew PATH
case $(/usr/bin/uname -m) in
    arm64)
        echo 'uname => arm64'
        export PATH="/opt/homebrew/bin:$PATH"
        ;;
    x86_64)
        echo 'uname => x86_64'
        export PATH="/usr/local/bin:$PATH"
        ;;
    *)
        echo 'Only supported on x86_64 or arm64'
        exit
        ;;
esac

export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"

# Initialize rbenv, nodenv, pyenv
eval "$(rbenv init - zsh)"
eval "$(nodenv init -)"
eval "$(pyenv init -)"

# Zsh settings
EXECUTE_DIR=$(cd $(dirname $0); pwd)
DOT_ZSH_DIR=${HOME}/.config/zsh/.zsh
COMPLETION_DIR=${DOT_ZSH_DIR}/completion

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# /completion ディレクトリがなければ作成
mkdir -p ${COMPLETION_DIR}

if [ ! -e ${COMPLETION_DIR}/git-completion.bash ]; then
    curl -o ${COMPLETION_DIR}/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
fi

if [ ! -e ${COMPLETION_DIR}/_git ]; then
    curl -o ${COMPLETION_DIR}/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
fi

FPATH=$COMPLETION_DIR:$FPATH

autoload -U compinit
compinit -u

# Prompt settings

if [ ! -e ${DOT_ZSH_DIR}/git-prompt.zsh ]; then
    git clone --depth=1 https://github.com/woefe/git-prompt.zsh ${DOT_ZSH_DIR}/git-prompt.zsh
fi

source ${DOT_ZSH_DIR}/git-prompt.zsh/git-prompt.zsh

ZSH_GIT_PROMPT_SHOW_UPSTREAM="no"
ZSH_GIT_PROMPT_SHOW_TRACKING_COUNTS=0
ZSH_GIT_PROMPT_SHOW_LOCAL_COUNTS=0

ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg[cyan]%}:"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL="%{$fg[yellow]%}⟳ "
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%{$fg[red]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX="%{$fg[red]%})"
ZSH_THEME_GIT_PROMPT_BEHIND="↓"
ZSH_THEME_GIT_PROMPT_AHEAD="↑"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}● "
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}✚ "
ZSH_THEME_GIT_PROMPT_UNTRACKED=""
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}⚑ "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔ "

PS1=$'\n%F{green}%~%f$(gitprompt)\n%F{cyan}❯ %f'

# bun completions
[ -s "/Users/iida-takuma/.bun/_bun" ] && source "/Users/iida-takuma/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
