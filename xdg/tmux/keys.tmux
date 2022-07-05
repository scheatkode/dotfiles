#==============================================================#
#              vim: set ft=tmux fdm=marker fdl=0:              #
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

is_vim="\
ps -o state= -o comm= -t '#{pane_tty}' \
| grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

# Normal mode {{{1

# Win a key stroke.
bind-key \; command-prompt

# Scratch terminal for quick commands.
bind-key t display-popup -E -b rounded -d '#{pane_current_path}' \; \
	set-option key-table root

# Reload configuration.
bind-key M-r \
		source-file     "${XDG_CONFIG_HOME}/tmux/tmux.conf" \; \
		display-message "Configuration reloaded"

# Cycle layout.
bind-key f next-layout

# Detach session and return to vanilla shell.
bind-key d detach
bind-key D if -F '#{session_many_attached}' {
   confirm-before -p 'Detach other clients ? (y/n)' 'detach -a'
} {
   display-message 'Session has only 1 client attached'
}

# Resize panes
bind-key H resize-pane -L
bind-key L resize-pane -R
bind-key J resize-pane -D
bind-key K resize-pane -U

# Zoom
bind-key = resize-pane -Z
bind-key z resize-pane -Z

# Quick switch.
bind-key Tab last-window

# Quick navigation.
bind-key [ select-pane -t :.-
bind-key ] select-pane -t :.+

bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R

bind-key M-h if-shell "$is_vim" 'send-keys M-h' 'select-pane -L'
bind-key M-j if-shell "$is_vim" 'send-keys M-j' 'select-pane -D'
bind-key M-k if-shell "$is_vim" 'send-keys M-k' 'select-pane -U'
bind-key M-l if-shell "$is_vim" 'send-keys M-l' 'select-pane -R'

# Trigger copy-mode.
bind-key y copy-mode
bind-key / copy-mode \; send-key ?

# # Paste.
# bind-key p paste-buffer \; set-option key-table root

# Toggle status bar.
bind-key B if -F '#{==:#{status},on}' {
   set status off
} {
   set status on
}

# Parkour mode. {{{1

# Commonly used operations and motions made prefixless for some
# quick-scope rapid movement.

bind-key -n M-Tab last-window
bind-key -n M-=   resize-pane -Z

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

# Copy mode. {{{1

bind-key -T copy-mode-vi Escape send -X cancel
bind-key -T copy-mode-vi v      send -X begin-selection
bind-key -T copy-mode-vi V      send -X select-line
bind-key -T copy-mode-vi C-v    send -X rectangle-toggle

bind-key -T copy-mode-vi u send-key -X halfpage-up
bind-key -T copy-mode-vi d send-key -X halfpage-down

bind-key -T copy-mode-vi * if -F '#{selection_active}' {
   send-key -X  copy-pipe
   send-key -FX search-forward-text '#{buffer_sample}'
} {
   send-key -FX search-forward '#{copy_cursor_word}'
}
bind-key -T copy-mode-vi \# if -F '#{selection_active}' {
   send-key -X  copy-pipe
   send-key -FX search-backward-text '#{buffer_sample}'
   send-key -X  search-again
} {
   send-key -FX search-backward-text '#{copy_cursor_word}'
}

# Rename sub-table. {{{1

bind-key r switch-client -T rename-table

bind-key -T rename-table w command-prompt -I '#{window_name}'  "rename-window '%%'"
bind-key -T rename-table s command-prompt -I '#{session_name}' "rename-session '%%'"

# New shtuff sub-table. {{{1

bind-key n switch-client -T new-table

# New window/session, retaining current working directory.

bind-key -T new-table c new-window       -c '#{pane_current_directory}' \; set-option key-table root
bind-key -T new-table n new-window       -c '#{pane_current_directory}' \; set-option key-table root
bind-key -T new-table s new-session      -c '#{pane_current_directory}' \; set-option key-table root
bind-key -T new-table t display-popup -E -d '#{pane_current_directory}' \; set-option key-table root
bind-key -T new-table p display-popup -E -d '#{pane_current_directory}' \; set-option key-table root

# Window sub-table. {{{1

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

# Window navigation.

bind-key -T window-table 0 select-window -t :0
bind-key -T window-table 1 select-window -t :1
bind-key -T window-table 2 select-window -t :2
bind-key -T window-table 3 select-window -t :3
bind-key -T window-table 4 select-window -t :4
bind-key -T window-table 5 select-window -t :5
bind-key -T window-table 6 select-window -t :6
bind-key -T window-table 7 select-window -t :7
bind-key -T window-table 8 select-window -t :8
bind-key -T window-table 9 select-window -t :9

# Pane/window killing.

bind-key -T window-table d kill-pane
bind-key -T window-table D kill-window

bind-key -T copy-mode-vi M-h select-pane -L
bind-key -T copy-mode-vi M-j select-pane -D
bind-key -T copy-mode-vi M-k select-pane -U
bind-key -T copy-mode-vi M-l select-pane -R

# Sending panes to other windows.

bind-key -T window-table f command-prompt -p "get pane from window #:" "join-pane -s ':%%'"
bind-key -T window-table t command-prompt -p "send pane to window #:"  "join-pane -t ':%%'"

# Choose sub-table {{{1

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

