set -x PATH /usr/local/sbin $PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# custom settings
set -U theme_display_date no
set -U theme_display_cmd_duration no

# rbenv
status --is-interactive; and rbenv init - fish | source
