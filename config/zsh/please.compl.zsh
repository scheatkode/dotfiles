#
#          ░█▀█░█░░░█▀▀░█▀█░█▀▀░█▀▀
#          ░█▀▀░█░░░█▀▀░█▀█░▀▀█░█▀▀
#          ░▀░░░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀
#
# shellcheck shell=bash

_plz_complete_zsh() {
	local args=("${words[@]:1:${CURRENT}}")
	local IFS=$'\n'
	local completions=($(GO_FLAGS_COMPLETION=1 ${words[1]} -p -v 0 --noupdate "${args[@]}"))

	for completion in ${completions}; do
		compadd "${completion}"
	done
}

compdef _plz_complete_zsh plz
compdef _plz_complete_zsh please
