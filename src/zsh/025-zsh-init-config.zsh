# -------------------------------------------------------------------------- #
#          ░▀▀█░█▀▀░█░█░░░▀█▀░█▀█░▀█▀░▀█▀░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀          #
#          ░▄▀░░▀▀█░█▀█░░░░█░░█░█░░█░░░█░░░░█░░░█░█░█░█░█▀▀░░█░░█░█          #
#          ░▀▀▀░▀▀▀░▀░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀          #
# -------------------------------------------------------------------------- #

# install functions.

export UPDATE_INTERVAL="${UPDATE_INTERVAL:-15}"
export         ZDOTDIR="${ZDOTDIR:-${XDG_CONFIG_HOME}/zsh}"
export        ZDATADIR="${ZDATADIR:-${XDG_DATA_HOME}/zsh}"
export       ZCACHEDIR="${ZCACHEDIR:-${XDG_CACHE_HOME}/zsh}"
export             ZSH="${ZDOTDIR}"

[[ -d   "${ZDOTDIR}" ]] || mkdir --parent "${ZDOTDIR}"
[[ -d  "${ZDATADIR}" ]] || mkdir --parent "${ZDATADIR}"
[[ -d "${ZCACHEDIR}" ]] || mkdir --parent "${ZCACHEDIR}"

# load the prompt and completion systems and initialize
# them.

autoload -Uz compinit promptinit

# on slow systems, checking  the cached .zcompdump file
# to see  if it  must be  regenerated adds  a noticable
# delay to  zsh startup. this little  hack restricts it
# to once every 20 hours.

_comp_files=(${ZCACHEDIR})

if (( ${#_comp_files} )); then
   compinit -i -C -d "${ZCACHEDIR}/zcompdump"
else
   compinit -i -d "${ZCACHEDIR}/zcompdump"
fi

unset _comp_files

promptinit
setopt prompt_subst

# Local Variables:
# tab-width: 3
# mode: shell
# End:
# vim: set ft=zsh sw=3 ts=3 sts=3 et tw=78:
