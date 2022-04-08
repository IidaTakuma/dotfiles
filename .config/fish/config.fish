set -x PATH /opt/homebrew/bin $PATH

if status is-interactive
    rbenv init - fish | source
    nodenv init - fish | source
end

# custom settings
set -U theme_display_date no
set -U theme_display_cmd_duration no
