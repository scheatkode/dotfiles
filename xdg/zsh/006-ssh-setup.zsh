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

function __start_ssh_agent {
   if                                            \
         ! command -v ssh-agent > /dev/null 2>&1 \
      || ! command -v ssh-add   > /dev/null 2>&1
   then
      local red
      local normal

      if ! command -v tput > /dev/null 2>&1
      then
         red="\e[0;31m"
         normal="\e[0m"
      else
         red="$(tput setaf 1)"
         normal="$(tput sgr0)"
      fi

      printf "%b%s%b\n"          \
         "$(tput setaf 1)"       \
         "ssh-agent not found !" \
         "$(tput sgr0)"

      return 1
   fi

   ssh-agent | sed 's/^echo/#echo/' | tee "${SSH_ENV}"

   chmod 600 "${SSH_ENV}"
   . "${SSH_ENV}" > /dev/null

   ## automatically add keys to agent if no passwords are used
   ## otherwise, this breaks the user experience on launch

   # local ssh_private_keys

   # ssh_private_keys=("${(@f)$( \
   #    file ${SSH_CONFIG_HOME}/* \
   #    | grep 'private key$' \
   #    | cut -d':' -f1 \
   # )}")

   # for key in ${ssh_private_keys}
   # do
   #    ssh-add "${key}"
   # done
}

# source ssh settings, if applicable

if [ -f "${SSH_ENV}" ]
then
   . "${SSH_ENV}" > /dev/null

   ps -ef | grep "${SSH_AGENT_PID}" | grep -q 'ssh-agent$' || {
      __start_ssh_agent
   }
else
   __start_ssh_agent
fi

alias ssh="ssh ${SSH_CONFIG_OPTS}"
