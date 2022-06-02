#==============================================================#
#                       vim: set ft=tmux:                      #
#==============================================================#
#                                                              #
#                 ░▀█▀░█▄█░█░█░█░█░░░░░█░█░▀█▀                 #
#                 ░░█░░█░█░█░█░▄▀▄░▀▀▀░█░█░░█░                 #
#                 ░░▀░░▀░▀░▀▀▀░▀░▀░░░░░▀▀▀░▀▀▀                 #
#                                                              #
#                                                              #
#                     tmux ui configuration                    #
#                                                              #
#==============================================================#

dark0_hard='#1d2021'
dark0_dim='#242424'
dark0='#282828'
dark0_soft='#32302f'
dark1='#3c3836'
dark2='#504945'
dark3='#665c54'
dark4='#7c6f64'

gray='#928374'

light0_hard='#f9f5d7'
light0='#fbf1c7'
light0_soft='#f2e5bc'
light1='#ebdbb2'
light2='#d5c4a1'
light3='#bdae93'
light4='#a89984'

bright_red='#fb4934'
bright_green='#b8bb26'
bright_yellow='#fabd2f'
bright_blue='#83a598'
bright_purple='#d3869b'
bright_aqua='#8ec07c'
bright_orange='#fe8019'

neutral_red='#cc241d'
neutral_green='#98971a'
neutral_yellow='#d79921'
neutral_blue='#458588'
neutral_purple='#b16286'
neutral_aqua='#689d6a'
neutral_orange='#d65d0e'

faded_red='#9d0006'
faded_green='#79740e'
faded_yellow='#b57614'
faded_blue='#076678'
faded_purple='#8f3f71'
faded_aqua='#427b58'
faded_orange='#af3a03'

pale_yellow='#d8a657'
pale_orange='#e78a4e'
pale_red='#ea6962'
pale_green='#a9b665'
pale_blue='#7daea3'
pale_aqua='#89b482'

# Status bar.

set-option -g status-position bottom
set-option -g status-justify  centre
set-option -g status-style    bg=${dark0_dim},fg=${light1},none

# Left side of status bar.

set-option -g status-left-length 25
set-option -g status-left "\
#[fg=${pale_aqua}#,bg=${dark0_dim}]#{?#{==:#{client_key_table},prefix},#[fg=${faded_orange}],} ●   \
#[fg=${dark1}#,bg=${dark0_dim}] %H:%M │ \
%d-%m-%y"

# Right side of status bar.

set-option -g status-right-length 30
set-option -g status-right '' # TODO(scheatkode): CPU monitor

# Window tab style.

set-option -wg window-style        bg=${dark0_dim}
set-option -wg window-active-style bg=${dark0}

set-option -wg window-status-separator      ''
set-option -wg window-status-activity-style "fg=${dark0_dim},bg=${light1},none"
set-option -wg window-status-current-style  "bg=${dark0_dim},fg=${pale_aqua}"

set-option -wg window-status-format "\
#{?window_activity_flag,#[fg=${dark4}#,bg=${dark0_dim}],#[fg=${dark1}#,bg=${dark0_dim}]} #I│#W "

set-option -wg window-status-current-format "\
#[fg=${pale_aqua}#,bg=${dark0_dim}] #I│#W "

# Message bar.

set-option -g message-style fg=${pale_yellow}

# Panes.

# set-option -g pane-border-lines        off
# set-option -g pane-border-lines        ""
set-option -g pane-border-status       off
set-option -g pane-border-style        fg=${dark0_dim},bg=${dark0_dim}
set-option -g pane-active-border-style fg=${dark0_dim},bg=${dark0_dim}
