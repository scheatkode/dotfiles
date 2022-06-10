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

# Conditionally set the `copy-command` option depending
# on the available clipboard manipulation tool.
if 'command -v xclip > /dev/null' {
   set-option -s copy-command 'xclip -i -selection clipboard > /dev/null'
}
if 'command -v xsel > /dev/null' {
   set-option -s copy-command 'xsel -i -b'
}

# Emulate Vim's copy command where `y` yanks the text and brings
# you back to normal mode. The command is set conditionally
# depending on the available clipboard manipulation tool.
if 'command -v xclip > /dev/null' {
   bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel \
      'xclip -i -f -selection primary | xclip -i -selection clipboard'
}
if 'command -v xsel > /dev/null' {
   bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel \
   	'xsel -i --clipboard'
}

if 'command -v xclip > /dev/null' {
   bind-key p run \
      'tmux set-buffer "$(xclip -out -selection clipboard)"; tmux paste-buffer \; set-option key-table root'
}
if 'command -v xsel > /dev/null' {
   bind-key p run \
      'tmux set-buffer "$(xsel -i --clipboard); tmux paste-buffer \; set-option key-table root'
}
