: #  ░░░░░░░█░░░░█▀▄░█▀█░▀█▀░█▀▀░▀█▀░█░░░█▀▀░█▀▀
: #  ▄█▄█░░█▀░░░░█░█░█░█░░█░░█▀▀░░█░░█░░░█▀▀░▀▀█
: #  ▀░▀░░█▀░░▀░░▀▀░░▀▀▀░░▀░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀

: # This is a special script which intermixes both `sh`
: # and `cmd` code.  It is written this  way because it
: # is   used  in  `system()`  shell-outs  directly  in
: # otherwise portable code.

:<<"::WINJUMP"
@ECHO OFF
GOTO :WINDOWS_CMD_SCRIPT
::WINJUMP

set -e
set -u
set -o pipefail

# TODO(scheatkode): check for binaries and print warning if they are not found.

if [ -z "${HOME+x}" ] ; then
   cat << EOF

   Something seems to be wrong with your environment.
   Check that your HOME variable is properly set before rerunning the script.

EOF

   exit 67
fi

# constants {{{1
# path {{{2

DOTFILES_CURRENT_PATH="$(pwd)"
DOTFILES_CONFIGURATION_PATH="${XDG_CONFIG_HOME-${HOME}/.config}"

# icons {{{2

DOTFILES_ICON_PENDING='\u2026' # …
DOTFILES_ICON_SUCCESS='\uf00c' # 
DOTFILES_ICON_FAILURE='\uf00d' # 

DOTFILES_ICON_CONTINUATION='\u21b3' # ↳

# colors {{{2

# basic 8 colors, no need for anything fancy.

if [ -z "${NO_COLOR+x}" ] ; then

      DOTFILES_COLOR_BLACK="$(tput setaf 0)"
        DOTFILES_COLOR_RED="$(tput setaf 1)"
      DOTFILES_COLOR_GREEN="$(tput setaf 2)"
     DOTFILES_COLOR_YELLOW="$(tput setaf 3)"
       DOTFILES_COLOR_BLUE="$(tput setaf 4)"
    DOTFILES_COLOR_MAGENTA="$(tput setaf 5)"
       DOTFILES_COLOR_CYAN="$(tput setaf 6)"
      DOTFILES_COLOR_WHITE="$(tput setaf 7)"
     DOTFILES_COLOR_PURPLE="$(tput setaf 125)"
     DOTFILES_COLOR_NORMAL="$(tput sgr0)"

else

      DOTFILES_COLOR_BLACK=''
        DOTFILES_COLOR_RED=''
      DOTFILES_COLOR_GREEN=''
     DOTFILES_COLOR_YELLOW=''
       DOTFILES_COLOR_BLUE=''
    DOTFILES_COLOR_MAGENTA=''
       DOTFILES_COLOR_CYAN=''
      DOTFILES_COLOR_WHITE=''
     DOTFILES_COLOR_PURPLE=''
     DOTFILES_COLOR_NORMAL=''

fi

# miscellaneous {{{2

DOTFILES_INDENTATION='   '
NL='
'

# script names {{{2

DOTFILES_HOOK_POST_UPDATE='.git/hooks/post-update'

# functions {{{1
# action lifecycle {{{2

act () {
   act_message="${1-Processing}"
   act_command="${2-:}"

   printf                        \
      "%b[%b%b%b] - %s"          \
      "${DOTFILES_INDENTATION}"  \
      "${DOTFILES_COLOR_YELLOW}" \
      "${DOTFILES_ICON_PENDING}" \
      "${DOTFILES_COLOR_NORMAL}" \
      "${act_message}"

   shift 2

   if act_return="$("${act_command}" ${*} 2>&1)" ; then
      succeed
   else
      fail "${act_return}"
      return 1
   fi
}

succeed () {
   printf                        \
      "\r%b[%b%b%b]\n"           \
      "${DOTFILES_INDENTATION}"  \
      "${DOTFILES_COLOR_GREEN}"  \
      "${DOTFILES_ICON_SUCCESS}" \
      "${DOTFILES_COLOR_NORMAL}"
}

fail () {
   printf                        \
      "\r%b[%b%b%b]\n"           \
      "${DOTFILES_INDENTATION}"  \
      "${DOTFILES_COLOR_RED}"    \
      "${DOTFILES_ICON_FAILURE}" \
      "${DOTFILES_COLOR_NORMAL}"

   if [ "${1+?}" != '?' ] ; then
      return 0
   fi

   if [ x"${1}" = x'' ] ; then
      return 0
   fi

   printf \
      '\r%b    %b%b%b %b\n' \
      "${DOTFILES_INDENTATION}"  \
      "${DOTFILES_COLOR_RED}"    \
      "${DOTFILES_ICON_CONTINUATION}" \
      "${DOTFILES_COLOR_NORMAL}" \
      "${1}"
}

# actions {{{2
# dependencies {{{3

has () {
   command -v "${@}" > /dev/null 2>&1
}

dotfiles_ensure_dependencies () {
   if ! has git ; then
      echo 'git command not found'
      return 1
   fi
}

dotfiles_ensure_dependency_version () {
   : # TODO(scheatkode): Add dependency versions check
}

# dotfiles {{{3

dotfiles_setup_xdg_config () {
   mkdir --parents "${XDG_CONFIG_HOME-~/.config/}"
   mkdir --parents "${XDG_DATA_HOME-~/.local/share/}"
}

dotfiles_setup_alacritty () {
   configuration_path="${DOTFILES_CONFIGURATION_PATH}/alacritty"

   dotfiles_ensure_backup "${configuration_path}"

   ln --symbolic                               \
      "${DOTFILES_CURRENT_PATH}/xdg/alacritty" \
      "${configuration_path}"
}

dotfiles_setup_alsa () {
   configuration_path="${DOTFILES_CONFIGURATION_PATH}/alsa"

   dotfiles_ensure_backup "${configuration_path}"

   ln --symbolic                          \
      "${DOTFILES_CURRENT_PATH}/xdg/alsa" \
      "${configuration_path}"
}

dotfiles_setup_awesome () {
   configuration_path="${DOTFILES_CONFIGURATION_PATH}/awesome"

   dotfiles_ensure_backup "${configuration_path}"

   ln --symbolic                             \
      "${DOTFILES_CURRENT_PATH}/xdg/awesome" \
      "${configuration_path}"
}

dotfiles_setup_btop () {
   configuration_path="${DOTFILES_CONFIGURATION_PATH}/btop"

   dotfiles_ensure_backup "${configuration_path}"

   ln --symbolic                          \
      "${DOTFILES_CURRENT_PATH}/xdg/btop" \
      "${configuration_path}"
}

dotfiles_setup_neovim () {
   configuration_path="${DOTFILES_CONFIGURATION_PATH}/nvim"

   dotfiles_ensure_backup "${configuration_path}"

   ln --symbolic                            \
      "${DOTFILES_CURRENT_PATH}/xdg/neovim" \
      "${configuration_path}"
}

dotfiles_setup_pueue () {
   configuration_path="${DOTFILES_CONFIGURATION_PATH}/pueue"

   dotfiles_ensure_backup "${configuration_path}"

   ln --symbolic                            \
      "${DOTFILES_CURRENT_PATH}/xdg/pueue" \
      "${configuration_path}"
}

dotfiles_setup_tmux () {
   configuration_path="${DOTFILES_CONFIGURATION_PATH}/tmux"

   dotfiles_ensure_backup "${configuration_path}"

   ln --symbolic                          \
      "${DOTFILES_CURRENT_PATH}/xdg/tmux" \
      "${configuration_path}"
}

dotfiles_setup_zsh () {
   configuration_path="${DOTFILES_CONFIGURATION_PATH}/zsh"

   dotfiles_ensure_backup "${configuration_path}"
   dotfiles_ensure_backup "${HOME}/.zshenv"

   cat << 'EOF' > "${HOME}/.zshenv"
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
EOF

   ln --symbolic                         \
      "${DOTFILES_CURRENT_PATH}/xdg/zsh" \
      "${configuration_path}"
}

# helpers {{{3

usage () {
   cat - <<EOF
   ${DOTFILES_COLOR_CYAN}░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
   ░░░░░░░░░░░█░░░░█▀▄░█▀█░▀█▀░█▀▀░▀█▀░█░░░█▀▀░█▀▀░░░░
   ░░░░▄█▄█░░█▀░░░░█░█░█░█░░█░░█▀▀░░█░░█░░░█▀▀░▀▀█░░░░
   ░░░░▀░▀░░█▀░░▀░░▀▀░░▀▀▀░░▀░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░░░
   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

   scheatkode${DOTFILES_COLOR_NORMAL}'s dotfiles management script.

   Usage: $(basename ${0}) [${DOTFILES_COLOR_YELLOW}sub-command${DOTFILES_COLOR_NORMAL}]

   ${DOTFILES_COLOR_YELLOW}Sub commands${DOTFILES_COLOR_NORMAL}:
      setup:alacritty   Setup alacritty configuration
      setup:alsa        Setup alsa configuration
      setup:awesome     Setup awesome configuration
      setup:btop        Setup btop configuration
      setup:neovim      Setup neovim configuration
      setup:pueue       Setup pueue configuration
      setup:tmux        Setup tmux configuration
      setup:zsh         Setup zsh configuration
      setup:all         Alias to run all the above

      help              Show this help screen

EOF
}

act_all () {
   act 'Setting up configuration directory' dotfiles_setup_xdg_config
   act 'Setting up alacritty'               dotfiles_setup_alacritty
   act 'Setting up alsa'                    dotfiles_setup_alsa
   act 'Setting up awesome'                 dotfiles_setup_awesome
   act 'Setting up btop'                    dotfiles_setup_btop
   act 'Setting up neovim'                  dotfiles_setup_neovim
   act 'Setting up pueue'                   dotfiles_setup_pueue
   act 'Setting up tmux'                    dotfiles_setup_tmux
   act 'Setting up zsh'                     dotfiles_setup_zsh
}

dotfiles_ensure_backup () {
   unlink "${1}"               > /dev/null 2>&1
   mv     "${1}" "${1}.backup" > /dev/null 2>&1
}

# main {{{1

main () {
   while [ "${#}" -gt 0 ] ; do
      case "${1}" in
         setup:alacritty)
            act 'Setting up configuration directory' dotfiles_setup_xdg_config
            act 'Setting up alacritty'               dotfiles_setup_alacritty
            ;;

         setup:alsa)
            act 'Setting up configuration directory' dotfiles_setup_xdg_config
            act 'Setting up alsa'                    dotfiles_setup_alsa
            ;;

         setup:awesome)
            act 'Setting up configuration directory' dotfiles_setup_xdg_config
            act 'Setting up awesome'                 dotfiles_setup_awesome
            ;;

         setup:btop)
            act 'Setting up configuration directory' dotfiles_setup_xdg_config
            act 'Setting up btop'                    dotfiles_setup_btop
            ;;

         setup:neovim)
            act 'Setting up configuration directory' dotfiles_setup_xdg_config
            act 'Setting up neovim'                  dotfiles_setup_neovim
            ;;

         setup:pueue)
            act 'Setting up configuration directory' dotfiles_setup_xdg_config
            act 'Setting up pueue'                   dotfiles_setup_pueue
            ;;

         setup:tmux)
            act 'Setting up configuration directory' dotfiles_setup_xdg_config
            act 'Setting up tmux'                    dotfiles_setup_tmux
            ;;

         setup:zsh)
            act 'Setting up configuration directory' dotfiles_setup_xdg_config
            act 'Setting up zsh'                     dotfiles_setup_zsh
            ;;

         setup:all) act_all ;;

         usage|--usage|help|--help) usage ;;
      esac

      shift
   done
}

echo ''

main "${*}"

echo ''
exit 0

:WINDOWS_CMD_SCRIPT

REM TODO(scheatkode): Handle windows case.
REM TODO(scheatkode): Maybe break down the file and source system-specific scripts.

