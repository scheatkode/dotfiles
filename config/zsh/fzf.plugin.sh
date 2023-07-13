#
#          ░█▀▀░▀▀█░█▀▀
#          ░█▀▀░▄▀░░█▀▀
#          ░▀░░░▀▀▀░▀░░
#
# shellcheck shell=sh
# shellcheck disable=2089,2090

# use sharkdp/fd as a faster alternative to `find`.

if command -v fd > /dev/null 2>&1; then
	export FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
	export FZF_ALT_C_COMMAND='fd --type d --exclude .git --exclude .npm'
fi

# preview file content

if command -v bat > /dev/null 2>&1; then
	export FZF_CTRL_T_OPTS="
		--preview 'bat -n --color=always {}'
		--bind 'ctrl-/:change-preview-window(down|hidden|)'"
else
	export FZF_CTRL_T_OPTS="--bind 'ctrl-/:change-preview-window(down|hidden|)'"
fi

# print tree structure in the preview window

if command -v exa > /dev/null 2>&1; then
	export FZF_ALT_C_OPTS="--preview 'exa -T -L 2 {}'"
fi

# CTRL-/ to toggle small preview window to see the full command.
# CTRL-Y to copy the command into clipboard using xclip.

export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -sel clipboard)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# setup coloscheme

export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS}
	--color=fg:#a89984,bg:-1,hl:#d79921
	--color=fg+:#ebdbb2,bg+:-1,hl+:#fabd2f
	--color=info:#d79921,prompt:#d65d0e,pointer:#fe8019
	--color=marker:#689d6a,spinner:#b16286,header:#83a598"
