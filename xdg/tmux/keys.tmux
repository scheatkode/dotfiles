#==============================================================#
#                 vim: set ft=tmux fdm=marker:                 #
#==============================================================#
#                                                              #
#             ░▀█▀░█▄█░█░█░█░█░░░░░█░█░█▀▀░█░█░█▀▀             #
#             ░░█░░█░█░█░█░▄▀▄░▀▀▀░█▀▄░█▀▀░░█░░▀▀█             #
#             ░░▀░░▀░▀░▀▀▀░▀░▀░░░░░▀░▀░▀▀▀░░▀░░▀▀▀             #
#                                                              #
#                                                              #
#                   tmux keys configuration                    #
#                                                              #
#==============================================================#

# TODO(scheatkode): Figure out some logical way to sort the
# bindings.

# Detach.

bind-key d detach
bind-key D if -F '#{session_many_attached}' {
   confirm-before -p 'Detach other clients ? (y/n)' 'detach -a'
} {
   display-message 'Session has only 1 client attached'
}

# Win a key stroke.
bind-key \; command-prompt

# Reload configuration.
bind-key M-r \
		source-file     "${XDG_CONFIG_HOME}/tmux/tmux.conf" \; \
		display-message "Configuration reloaded"

# Rename table. {{{1

bind-key r switch-client -T rename-table

bind-key -T rename-table w command-prompt -I '#{window_name}'  "rename-window '%%'"
bind-key -T rename-table s command-prompt -I '#{session_name}' "rename-session '%%'"

# New shtuff table. {{{1

bind-key n switch-client -T new-table

# New window/session, retaining current working directory.

bind-key -T new-table c new-window       -c '#{pane_current_directory}' \; set-option key-table root
bind-key -T new-table n new-window       -c '#{pane_current_directory}' \; set-option key-table root
bind-key -T new-table s new-session      -c '#{pane_current_directory}' \; set-option key-table root
bind-key -T new-table t display-popup -E -d '#{pane_current_directory}' \; set-option key-table root
bind-key -T new-table p display-popup -E -d '#{pane_current_directory}' \; set-option key-table root

# Scratch terminal for quick commands.

bind-key t popup -E \; set-option key-table root

# Window table. {{{1

bind-key w switch-client -T window-table

# Window splitting with so much redundancy you'll never NOT fat
# finger again.

bind-key -T window-table v  split-window -h -c '#{pane_current_path}'
bind-key -T window-table s  split-window -v -c '#{pane_current_path}'
bind-key -T window-table |  split-window -h -c '#{pane_current_path}'
bind-key -T window-table _  split-window -v -c '#{pane_current_path}'
bind-key -T window-table \\ split-window -h -c '#{pane_current_path}'
bind-key -T window-table -  split-window -v -c '#{pane_current_path}'

bind-key -T window-table q      switch-client -T prefix
bind-key -T window-table Escape switch-client -T prefix

# Pane swapping.

bind-key -T window-table h select-pane -L \; swap-pane -s '!'
bind-key -T window-table j select-pane -D \; swap-pane -s '!'
bind-key -T window-table k select-pane -U \; swap-pane -s '!'
bind-key -T window-table l select-pane -R \; swap-pane -s '!'

# Cycle layout.

bind-key f next-layout

# Pane/window killing.

bind-key -T window-table k kill-pane
bind-key -T window-table K kill-window

# Resize panes

bind-key H resize-pane -L
bind-key L resize-pane -R
bind-key J resize-pane -D
bind-key K resize-pane -U

# Zoom

bind-key    =   resize-pane -Z
bind-key    z   resize-pane -Z

# Quick switch.

bind-key    Tab   last-window

# Quick navigation.

bind-key [ select-pane -t :.-
bind-key ] select-pane -t :.+

bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R

bind-key -T copy-mode-vi M-h select-pane -L
bind-key -T copy-mode-vi M-j select-pane -D
bind-key -T copy-mode-vi M-k select-pane -U
bind-key -T copy-mode-vi M-l select-pane -R

# Trigger copy-mode.

bind-key y copy-mode
bind-key / copy-mode \; send-key ?

# Toggle status bar.

bind-key B if -F '#{==:#{status},on}' {
   set status off
} {
   set status on
}

# Choose table {{{1

bind-key c switch-client -T choose-table

bind-key -T choose-table p choose-buffer  \; set-option key-table root
bind-key -T choose-table c choose-client  \; set-option key-table root
bind-key -T choose-table t choose-tree    \; set-option key-table root
bind-key -T choose-table s choose-session \; set-option key-table root
bind-key -T choose-table w choose-window  \; set-option key-table root

bind-key M-p choose-buffer  \; set-option key-table root
bind-key M-c choose-client  \; set-option key-table root
bind-key M-s choose-session \; set-option key-table root
bind-key M-t choose-tree    \; set-option key-table root
bind-key M-w choose-window  \; set-option key-table root

# Paste.

bind-key p paste-buffer \; set-option key-table root

# TMUX Parkour. {{{1

# Commonly used operations and motions made prefixless for some
# quick-scope rapid movement.

bind-key -n M-Tab last-window
bind-key -n M-=   resize-pane -Z

is_vim="\
ps -o state= -o comm= -t '#{pane_tty}' \
| grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

bind-key -n M-h if-shell "$is_vim" 'send-keys M-h' 'select-pane -L'
bind-key -n M-j if-shell "$is_vim" 'send-keys M-j' 'select-pane -D'
bind-key -n M-k if-shell "$is_vim" 'send-keys M-k' 'select-pane -U'
bind-key -n M-l if-shell "$is_vim" 'send-keys M-l' 'select-pane -R'

bind-key -n M-0 select-window -t :0
bind-key -n M-1 select-window -t :1
bind-key -n M-2 select-window -t :2
bind-key -n M-3 select-window -t :3
bind-key -n M-4 select-window -t :4
bind-key -n M-5 select-window -t :5
bind-key -n M-6 select-window -t :6
bind-key -n M-7 select-window -t :7
bind-key -n M-8 select-window -t :8
bind-key -n M-9 select-window -t :9

