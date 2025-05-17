
# Set Homebrew PATH
switch (/usr/bin/uname -m)
case arm64
    echo 'uname => arm64'
    set -x PATH /opt/homebrew/bin $PATH
case x86_64
    echo 'uname => x86_64'
    set -x PATH /usr/local/bin $PATH
case '*'
    echo 'Only supported on x86_64 or arm64'
    exit
end

set -x PATH /opt/homebrew/opt/openssl@1.1/bin $PATH
set -x PATH $HOME/.local/bin $PATH

if status is-interactive
    rbenv init - fish | source
    nodenv init - fish | source

    set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    pyenv init - fish | source
end

# custom settings
set -U theme_display_date no
set -U theme_display_cmd_duration no

set -x EDITOR code
eval (direnv hook fish)
