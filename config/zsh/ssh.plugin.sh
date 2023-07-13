#
#          ░█▀▀░█▀▀░█░█
#          ░▀▀█░▀▀█░█▀█
#          ░▀▀▀░▀▀▀░▀░▀
#
# shellcheck shell=sh

SSH_CONFIG_HOME="${XDG_CONFIG_HOME}/ssh"

if [ -s "${XDG_CONFIG_HOME}/ssh/config" ]; then
   export SSH_CONFIG_OPTS="-F ${SSH_CONFIG_HOME}/config"
fi

# ssh agent automatic start and session sharing
SSH_ENV="${SSH_CONFIG_HOME}/agentenv"

ssh-add -l > /dev/null 2>&1

if [ "${?}" = '2' ]; then
   lock="${SSH_CONFIG_HOME}/lock"

   # wait for atomically acquired lock
   while ! (set -C; : >"${lock}") > /dev/null 2>&1; do
      # not waiting to keep the startup snappy since these operations are fast
      # enough to not require every instance to `sleep` before checking again.
      :
   done

   # if the session file exists, source it and confirm its validity.
   test -r "${SSH_ENV}" && eval "$(cat "${SSH_ENV}")" > /dev/null
   ssh-add -l > /dev/null 2>&1

   # `ssh-add` returning with an exit status of `2` means it was unable to
   # contact the `ssh-agent`, in our case, ensuring the latter was not
   # started. create a new session file.
   if [ "${?}" = '2' ]; then
      (umask 006; ssh-agent > "${SSH_ENV}")
      eval "$(cat "${SSH_ENV}")" > /dev/null
   fi

   # release the acquired lock.
   rm "${lock}"

   unset lock
fi

alias ssh="ssh ${SSH_CONFIG_OPTS}"
