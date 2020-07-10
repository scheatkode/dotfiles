#!/bin/sh

# -- COLORS -------------------------------------------------------------------

    RED='\e[31m'
  GREEN='\e[32m'
 YELLOW='\e[33m'
   BLUE='\e[34m'
MAGENTA='\e[35m'
   CYAN='\e[36m'
 NORMAL='\e[0m'

# -- HELPER FUNCTIONS ---------------------------------------------------------

info      () { echo -en    "${CYAN}[INFO]${NORMAL} " "${@} " ;          }
infoline  () { echo -e     "${CYAN}[INFO]${NORMAL} " "${@} " ;          }
warn      () { echo -e   "${YELLOW}[WARN]${NORMAL} " "${@} " ;          }
fail      () { echo -e      "${RED}[FAIL]${NORMAL} " "${@} " ; exit 1 ; }
success   () { echo -e  "\r${GREEN}[ OK ]${NORMAL}"          ;          }

# -- HIERARCHY CREATION -------------------------------------------------------

user="${USER:-${LOGNAME:-#TODO}}"
home="${HOME:-'~'}"

# -- HIERARCHY CREATION -------------------------------------------------------

info 'Creating necessary directory hierarchy'

mkdir -p ${home}/.config/nvim/  \
&& success                      \
|| fail 'Unable to create folders'

# -- LINK CREATION ------------------------------------------------------------

infoline 'Links will be created to keep stuff in sync in case of update'
info     'Creating links'

ln    -s "`pwd`/init.vim"  "${home}/.config/nvim/"  \
&& ln -s "`pwd`/tmux.conf" "${home}/.tmux.conf"     \
&& success                                          \
|| fail 'Unable to create links'

