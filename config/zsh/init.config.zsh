#
#          ░▀█▀░█▀█░▀█▀░▀█▀
#          ░░█░░█░█░░█░░░█░
#          ░▀▀▀░▀░▀░▀▀▀░░▀░
#
# shellcheck shell=bash

export UPDATE_INTERVAL="${UPDATE_INTERVAL:-15}"
export         ZDOTDIR="${ZDOTDIR:-${XDG_CONFIG_HOME}/zsh}"
export        ZDATADIR="${ZDATADIR:-${XDG_DATA_HOME}/zsh}"
export       ZCACHEDIR="${ZCACHEDIR:-${XDG_CACHE_HOME}/zsh}"
export             ZSH="${ZDOTDIR}"

[[ -d   "${ZDOTDIR}" ]] || mkdir --parent "${ZDOTDIR}"
[[ -d  "${ZDATADIR}" ]] || mkdir --parent "${ZDATADIR}"
[[ -d "${ZCACHEDIR}" ]] || mkdir --parent "${ZCACHEDIR}"

# load the prompt and completion systems and initialize them.

autoload -Uz compinit promptinit

# on slow systems, checking the cached .zcompdump file to see if it must be
# regenerated adds a noticable delay to zsh startup. this little hack
# restricts it to once every 20 hours.

_comp_files=(${ZCACHEDIR})

if (( ${#_comp_files} )); then
   compinit -i -C -d "${ZCACHEDIR}/zcompdump"
else
   compinit -i -d "${ZCACHEDIR}/zcompdump"
fi

unset _comp_files

promptinit
setopt prompt_subst

# enable powerlevel10k instant prompt. initialization code that may require
# console input (password prompts, [y/n] confirmations, etc.) must go above
# this block; everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-${HOME}/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-${HOME}/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Additional sources

if [ -f "${XDG_CONFIG_HOME}"/tabtab/zsh/__tabtab.zsh ]; then
	. "${XDG_CONFIG_HOME}"/tabtab/zsh/__tabtab.zsh
fi

if command -v please > /dev/null 2>&1 || command -v plz > /dev/null 2>&1; then
	. "${XDG_CONFIG_HOME}"/zsh/please.compl.zsh
fi
