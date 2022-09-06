#
#         ░█▀█░█░░░▀█▀░█▀█░█▀▀░░░█▀▀░█▀▀░▀█▀░█░█░█▀█
#         ░█▀█░█░░░░█░░█▀█░▀▀█░░░▀▀█░█▀▀░░█░░█░█░█▀▀
#         ░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░░
#

alias 'vol'='alsamixer'
alias 'v'='nvim'

alias 'gc!!'='git commit --amend --no-edit'
alias 'ga!'='git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 -o -t git add'
alias 'grbc!'='GIT_EDITOR=true grbc'
