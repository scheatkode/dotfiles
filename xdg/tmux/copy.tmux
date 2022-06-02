#==============================================================#
#                       vim: set ft=tmux:                      #
#==============================================================#
#                                                              #
#             ░▀█▀░█▄█░█░█░█░█░░░░░█▀▀░█▀█░█▀█░█░█             #
#             ░░█░░█░█░█░█░▄▀▄░▀▀▀░█░░░█░█░█▀▀░░█░             #
#             ░░▀░░▀░▀░▀▀▀░▀░▀░░░░░▀▀▀░▀▀▀░▀░░░░▀░             #
#                                                              #
#                                                              #
#                   tmux copy configuration                    #
#                                                              #
#==============================================================#

bind-key -T copy-mode-vi Escape send -X cancel
bind-key -T copy-mode-vi v      send -X begin-selection
bind-key -T copy-mode-vi V      send -X select-line
bind-key -T copy-mode-vi C-v    send -X rectangle-toggle

# conditionally set the `copy-command` option depending
# on the available clipboard manipulation tool.
if 'command -v xclip > /dev/null' {
   set-option -s copy-command 'xclip -i -selection clipboard > /dev/null'
}
if 'command -v xsel > /dev/null' {
   set-option -s copy-command 'xsel -i -b'
}

if 'command -v xclip > /dev/null' {
   bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel \
      'xclip -i -f -selection primary | xclip -i -selection clipboard'
}
if 'command -v xsel > /dev/null' {
   bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel 'xsel -i --clipboard'
}

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

if 'command -v xclip > /dev/null' {
   bind-key p run \
      'tmux set-buffer "$(xclip -out -selection clipboard)"; tmux paste-buffer'
}
if 'command -v xsel > /dev/null' {
   bind-key p run \
      'tmux set-buffer "$(xsel -i --clipboard); tmux paste-buffer'
}
