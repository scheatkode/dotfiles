#
#          ░█▀▀░█▀█░█▀█░█▀▀░█░█░░░░░▀▀█
#          ░█▀▀░█▀█░█░█░█░░░░█░░▀▀▀░▄▀░
#          ░▀░░░▀░▀░▀░▀░▀▀▀░░▀░░░░░░▀▀▀
#
# shellcheck shell=sh

fancy_ctrl_z() {
	if [ "${#BUFFER}" = '0' ]; then
		BUFFER=" fg"
		zle accept-line
	else
		zle push-input
		zle clear-screen
	fi
}

zle      -N  fancy_ctrl_z
bindkey '^Z' fancy_ctrl_z
