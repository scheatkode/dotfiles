#
#          ░█▀█░█░░░▀█▀░█▀█░█▀▀
#          ░█▀█░█░░░░█░░█▀█░▀▀█
#          ░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
#
# shellcheck shell=sh

if command -v nvim >/dev/null 2>&1; then
	alias 'v'='nvim'
elif command -v vim >/dev/null 2>&1; then
	alias 'v'='vim'
fi

alias 'j'='jobs'
alias 'vol'='alsamixer'
alias 'ssh-keyless'='ssh -o PasswordAuthentication=yes -o PreferredAuthentications=keyboard-interactive,password -o PubkeyAuthentication=no'
alias 'zy'='zypper'

# forcefully expand aliases with sudo
alias 'sudo'='sudo '

# builtin alternatives

if command -v bat > /dev/null; then
	alias 'cat'='bat'
fi

if command -v exa > /dev/null; then
	alias 'ls'='exa'
fi

if command -v dig > /dev/null; then
	alias 'dig'='dog'
fi
