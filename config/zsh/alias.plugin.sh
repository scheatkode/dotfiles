#
#          ░█▀█░█░░░▀█▀░█▀█░█▀▀
#          ░█▀█░█░░░░█░░█▀█░▀▀█
#          ░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
#
# shellcheck shell=sh

if _dot_has nvim; then
	alias 'v'='nvim'
elif _dot_has vim; then
	alias 'v'='vim'
fi

alias 'j'='jobs'
alias 'vol'='alsamixer'
alias 'ssh-keyless'='ssh -o PasswordAuthentication=yes -o PreferredAuthentications=keyboard-interactive,password -o PubkeyAuthentication=no'

# forcefully expand aliases with sudo
alias 'sudo'='sudo '

# builtin alternatives

if _dot_has bat; then
	alias 'cat'='bat'
fi

if _dot_has exa; then
	alias 'ls'='exa'
fi

if _dot_has dog; then
	alias 'dig'='dog'
fi
