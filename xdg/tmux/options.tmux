#==============================================================#
#                       vim: set ft=tmux:                      #
#==============================================================#
#                                                              #
#       ░▀█▀░█▄█░█░█░█░█░░░░░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀       #
#       ░░█░░█░█░█░█░▄▀▄░▀▀▀░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█       #
#       ░░▀░░▀░▀░▀▀▀░▀░▀░░░░░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀       #
#                                                              #
#                                                              #
#                         tmux options                         #
#                                                              #
#==============================================================#

# The startup shell is only used for launching tmux, hence
# I set it to `/bin/sh` to avoid having an unused zsh process
# running in the background. tmux will then start the right
# shell once launched.

set-option -g default-shell '/usr/bin/zsh'

# Set the `TERM` and capabilities.

set-option -s  default-terminal   'tmux-256color'
set-option -sa terminal-overrides ',xterm-256color:RGB'
set-option -ga terminal-overrides ',xterm-256color:Tc'

# Undercurl support & underscore colors (needs TMUX-3.0),
# respectively.

set-option -sa terminal-overrides ',*:Smulx=\E[4::%p1%dm'
set-option -sa terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

# Events and monitoring.

set-option -s escape-time  0
set-option -s focus-events on

set-option -wg bell-action      none
set-option -g  visual-activity  off
set-option -g  visual-bell      off
set-option -g  visual-silence   on
set-option -wg monitor-activity on
set-option -wg monitor-bell     off

set-option -g repeat-time 150

set-option -s exit-empty   off
set-option -s buffer-limit 200

# Search options.

set-option -g word-separators " =+!@#$%^&*,.<>/?;:\\|~`(){}[]\"'"
set-option -g history-limit   20000
set-option -g wrap-search     on

# Default to utf8 encoding.

set-option -qg  status-utf8 on
set-option -qwg utf8        on

set-option -g editor nvim
set-option -g mouse  off # keyboard masterrace

set-option -g detach-on-destroy off

# Copy mode options.

set-option -s set-clipboard on
set-option -g status-keys   vi
set-option -g mode-keys     vi

# UI options.

set-option -g  base-index       1
set-option -wg pane-base-index  1
set-option -g  renumber-windows on

set-option -wg automatic-rename on
set-option -g  set-titles       on

set-option -g display-panes-time 1500
set-option -g display-time       500

set-option -g status-interval 10
