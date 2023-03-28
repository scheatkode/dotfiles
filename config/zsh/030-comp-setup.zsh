#
#            ░█▀▀░█▀█░█▄█░█▀█░░░█▀▀░█▀▀░▀█▀░█░█░█▀█
#            ░█░░░█░█░█░█░█▀▀░░░▀▀█░█▀▀░░█░░█░█░█▀▀
#            ░▀▀▀░▀▀▀░▀░▀░▀░░░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░░
#

# tabtab source for packages
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

command -v please > /dev/null 2>&1 \
	&& source <(please --completion_script | sed 's/plz/please/g')
