#         ░█▀▀░█▀▀░█░█░░░█▀▀░█▀▀░▀█▀░█░█░█▀█
#         ░▀▀█░▀▀█░█▀█░░░▀▀█░█▀▀░░█░░█░█░█▀▀
#         ░▀▀▀░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░░

SSH_CONFIG_HOME="${XDG_CONFIG_HOME}/ssh"

if [ -s "${XDG_CONFIG_HOME}/ssh/config" ]
then
   export SSH_CONFIG_OPTS="-F ${SSH_CONFIG_HOME}/config"
fi

# ssh agent automatic start and session sharing
SSH_ENV="${SSH_CONFIG_HOME}/agentenv"

ssh-add -l > /dev/null 2>&1

if [ "${?}" = '2' ]
then
   test -r "${SSH_ENV}" && eval "$(<${SSH_ENV})" > /dev/null
   ssh-add -l > /dev/null 2>&1

   if [ "${?}" = '2' ]
   then
      (umask 066; ssh-agent > "${SSH_ENV}")
      eval "$(<${SSH_ENV})" > /dev/null
   fi
fi

alias ssh="ssh ${SSH_CONFIG_OPTS}"
