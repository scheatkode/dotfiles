#==============================================================#
#                       vim: set ft=tmux:                      #
#==============================================================#
#                                                              #
#           ░▀█▀░█▄█░█░█░█░█░░░░░█▄█░█▀█░█▀▄░█▀▀░█▀▀           #
#           ░░█░░█░█░█░█░▄▀▄░▀▀▀░█░█░█░█░█░█░█▀▀░▀▀█           #
#           ░░▀░░▀░▀░▀▀▀░▀░▀░░░░░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀           #
#                                                              #
#                                                              #
#                   tmux modes configuration                   #
#                                                              #
#==============================================================#

# Disable default prefix key the prefix key and make it a No-Op.
unbind-key C-b
set-option -g prefix None

# Use `M-a` (Alt-a) as a *sticky* prefix key. It enters prefix
# (normal) mode and stays there.
bind-key -n M-a set-option key-table prefix

# These bindings exit "normal" mode by setting the key table
# back to the root or "insert" mode.
bind-key q      set-option key-table root
bind-key Escape set-option key-table root

set-hook -g client-detached[0] 'set-option key-table root'
