# shellcheck shell=zsh

fancy-ctrl-z () {
	if [ "${#BUFFER}" = '0' ]; then
		BUFFER=" fg"
		zle accept-line
	else
		zle push-input
		zle clear-screen
	fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
