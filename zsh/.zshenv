if [[ -z "${XDG_CONFIG_HOME}" ]] ; then
   export XDG_CONFIG_HOME="${HOME}/.config"
fi

if [[ -z "${XDG_DATA_HOME}" ]] ; then
   export XDG_DATA_HOME="${HOME}/.local/share"
fi

if [[ -d "${XDG_CONFIG_HOME}/zsh" ]] ; then
   export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
fi

if [[ -z "${GPG_TTY}" ]] ; then
   export GPG_TTY="${TTY}"
fi
