
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

if status is-interactive
    rbenv init - fish | source
    nodenv init - fish | source
end

# custom settings
set -U theme_display_date no
set -U theme_display_cmd_duration no
