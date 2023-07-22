#
#          ░▀▀█░▀█▀░█▀█░▀█▀░▀█▀
#          ░▄▀░░░█░░█░█░░█░░░█░
#          ░▀▀▀░▀▀▀░▀░▀░▀▀▀░░▀░
#
# shellcheck shell=bash

declare -A ZINIT ; ZINIT=(
          ['BIN_DIR']="${ZDATADIR}/zinit/bin"
         ['HOME_DIR']="${ZDATADIR}/zinit"
   ['ZCOMPDUMP_PATH']="${ZCACHEDIR}/zcompdump"
)

ZINIT_HOME="${ZINIT_HOME:-${ZDATADIR}/zinit}"

if [[ ! -f "${ZINIT_HOME}/zinit.zsh" ]]; then
   print -P "%F{33}▒ %F{220}Installing zinit (zdharma/zinit)…%f"

   command mkdir -p "${ZINIT_HOME}" \
      && command chmod g-rwX "${ZINIT_HOME}"
   command git clone --depth=1 https://github.com/zdharma-continuum/zinit "${ZINIT_HOME}" \
      && print -P "%F{33}▒ %F{34}Installation successful.%f" \
      || print -P "%F{160}▒ The repository clone has failed.%f"
fi

. "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# ---------------------------------------------------------------------------- #
#                         Theme & premature loading                            #
# ---------------------------------------------------------------------------- #

# most themes use this option.

setopt promptsubst

# provide a simple prompt until the theme finishes loading.

PS1='Loading prompt ... '

zinit ice lucid                                      \
   depth=1                                           \
   atload:'source ${ZDOTDIR}/.p10k.zsh; _p9k_precmd'
zinit light romkatv/powerlevel10k

# ---------------------------------------------------------------------------- #
#                                   Plugins                                    #
# ---------------------------------------------------------------------------- #


# load early to mitigate romkatv/powerlevel#716

zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh

zinit wait:'0b' lucid light-mode for                              \
      OMZ::lib/clipboard.zsh                                      \
      OMZ::lib/compfix.zsh                                        \
      OMZ::lib/completion.zsh                                     \
      OMZ::lib/diagnostics.zsh                                    \
      OMZ::lib/functions.zsh                                      \
      OMZ::lib/grep.zsh                                           \
      OMZ::lib/misc.zsh                                           \
      OMZ::lib/spectrum.zsh                                       \
      OMZ::lib/termsupport.zsh                                    \
      OMZ::lib/theme-and-appearance.zsh                           \
                                                                  \
      OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh \
      OMZ::plugins/command-not-found/command-not-found.plugin.zsh \
                                                                  \
   atinit:'zicompinit; zicdreplay'                                \
         zdharma-continuum/fast-syntax-highlighting               \
  atload:'_zsh_autosuggest_start'                                 \
         zsh-users/zsh-autosuggestions

zinit wait:'1c' blockf as:'completion' for \
      OMZ::plugins/docker/_docker          \
      OMZ::plugins/golang/_golang          \
      OMZ::plugins/ripgrep/_ripgrep

# recommended be loaded last.

zinit ice wait:'0c' blockf silent atpull:'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit wait:'1a' silent from:gh-r as:program light-mode for \
    bpick:'*64*linux*'                                     \
     pick:'xh-*/xh'                                        \
         @ducaale/xh                                       \
   atpull:'mv gomplate* gomplate > /dev/null 2>&1'         \
    bpick:'*linux*amd64*slim'                              \
         @hairyhenderson/gomplate                          \
    bpick:'*linux*64'                                      \
       mv:'sampler* -> sampler'                            \
         @sqshq/sampler                                    \
    bpick:'*linux*amd*'                                    \
       mv:'d2*/bin/d2 -> d2'                               \
         @terrastruct/d2                                   \
    bpick:'*linux*64*gz'                                   \
         @muesli/duf                                       \
    bpick:'*static*linux*amd64*'                           \
       mv:'usql_static -> usql'                            \
         @xo/usql

zinit wait:'1b' silent from:gh-r as:program for \
     pick:'imsnif/bandwhich'                    \
            @imsnif/bandwhich                   \
     pick:'dust*/dust'                          \
            @bootandy/dust                      \
    id-as:'pueue'                               \
    bpick:'pueue-*'                             \
     pick:'pueue'                               \
   atpull:'./pueue completions zsh .'           \
   atload:'alias p=pueue'                       \
      src:'_pueue'                              \
       mv:'pueue-* -> pueue'                    \
            @Nukesor/pueue                      \
    id-as:'pueued'                              \
    bpick:'pueued-*'                            \
   atload:'pueued --daemonize > /dev/null 2>&1' \
       mv:'pueued-* -> pueued'                  \
     pick:'pueued'                              \
            @Nukesor/pueue                      \
    bpick:'*x86_64*linux*gnu*'                  \
     pick:'hexyl*/hexyl'                        \
            @sharkdp/hexyl                      \
    bpick:'*linux*amd64*'                       \
     pick:'pup'                                 \
            @ericchiang/pup

zinit creinstall pueue > /dev/null 2>&1
