# -------------------------------------------------------------------------- #
#                    ░█░█░█▀▄░█▀▀░░░█▀▀░█▀▀░▀█▀░█░█░█▀█                      #
#                    ░▄▀▄░█░█░█░█░░░▀▀█░█▀▀░░█░░█░█░█▀▀                      #
#                    ░▀░▀░▀▀░░▀▀▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░░                      #
# -------------------------------------------------------------------------- #

export   XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export  XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

[[ -d   "${XDG_DATA_HOME}" ]] || mkdir --parent "${XDG_DATA_HOME}"
[[ -d  "${XDG_CACHE_HOME}" ]] || mkdir --parent "${XDG_CACHE_HOME}"
[[ -d "${XDG_CONFIG_HOME}" ]] || mkdir --parent "${XDG_CONFIG_HOME}"

# Local Variables:
# tab-width: 3
# mode: shell
# End:
# vim: set ft=zsh sw=3 ts=3 sts=3 et tw=78: