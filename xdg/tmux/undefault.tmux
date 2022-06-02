#==============================================================#
#                       vim: set ft=tmux:                      #
#==============================================================#
#                                                              #
#   ░▀█▀░█▄█░█░█░█░█░░░░░█░█░█▀█░█▀▄░█▀▀░█▀▀░█▀█░█░█░█░░░▀█▀   #
#   ░░█░░█░█░█░█░▄▀▄░▀▀▀░█░█░█░█░█░█░█▀▀░█▀▀░█▀█░█░█░█░░░░█░   #
#   ░░▀░░▀░▀░▀▀▀░▀░▀░░░░░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀░░▀░   #
#                                                              #
#                                                              #
#                      tmux defaults reset                     #
#                                                              #
#==============================================================#

unbind-key "\$"      # rename-session
unbind-key ","       # rename-window
unbind-key "%"       # split-window -h
unbind-key '"'       # split-window
unbind-key "}"       # swap-pane -D
unbind-key "{"       # swap-pane -U
unbind-key "["       # paste-buffer
unbind-key "]"
unbind-key "'"       # select-window
unbind-key "n"       # next-window
unbind-key "p"       # previous-window
unbind-key "l"       # last-window
unbind-key "M-n"     # next window with alert
unbind-key "M-p"     # next window with alert
unbind-key "o"       # focus thru panes
unbind-key "&"       # kill-window
unbind-key "#"       # list-buffer
unbind-key "="       # choose-buffer
unbind-key "z"       # zoom-pane
unbind-key "M-Up"    # resize 5 rows up
unbind-key "M-Down"  # resize 5 rows down
unbind-key "M-Right" # resize 5 rows right
unbind-key "M-Left"  # resize 5 rows left
