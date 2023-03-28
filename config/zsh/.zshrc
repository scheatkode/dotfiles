#
#                   ░▀▀█░█▀▀░█░█░
#                   ░▄▀░░▀▀█░█▀█░
#                   ░▀▀▀░▀▀▀░▀░▀░
#

# load modular configurations

for config ("${ZDOTDIR:-~}"/**/*.zsh) source "${config}"

# ---------------------------------------------------------------------------- #
#                                 Word style                                   #
# ---------------------------------------------------------------------------- #

# Useful when <C-w>-ing a path.

autoload -U select-word-style
select-word-style bash


# ---------------------------------------------------------------------------- #
#                                 Zsh settings                                 #
# ---------------------------------------------------------------------------- #

unsetopt CASE_GLOB           # use case-insensitive globbing.
setopt   EXTENDEDGLOB        # use extended globbing.
setopt   AUTOCD              # automatically change directory if a directory is entered.

# smart urls

autoload -Uz url-quote-magic
zle      -N self-insert url-quote-magic

# general

setopt   BRACE_CCL           # allow brace character class list expansion.
setopt   COMBINING_CHARS     # combine zero-length punctuation characters ( accents ) with the base character.
setopt   RC_QUOTES           # allow 'tommy''s garage' instead of 'tommy'\''s garage'.
setopt   MAIL_WARNING        # print a warning message if a mail file has been accessed.

# jobs

setopt   LONG_LIST_JOBS      # list jobs in the long format by default.
setopt   AUTO_RESUME         # attempt to resume existing job before creating a new process.
setopt   NOTIFY              # report status of background jobs immediately.
setopt   BG_NICE             # run all background jobs at a lower priority.
unsetopt HUP                 # don't kill jobs on shell exit.
setopt   CHECK_JOBS          # report on jobs when shell exit.

setopt   CORRECT             # turn on corrections.

# completion options

setopt   COMPLETE_IN_WORD    # complete from both ends of a word.
setopt   ALWAYS_TO_END       # move cursor to the end of a completed word.
setopt   PATH_DIRS           # perform path search even on command names with slashes.
setopt   AUTO_MENU           # show completion menu on a successive tab press.
setopt   AUTO_LIST           # automatically list choices on ambiguous completion.
setopt   AUTO_PARAM_SLASH    # if completed parameter is a directory, add a trailing slash.
setopt   NO_COMPLETE_ALIASES # self explanatory

setopt   MENU_COMPLETE       # do not autoselect the first completion entry.
unsetopt FLOW_CONTROL        # disable start/stop characters in shell editor.

# zstyle

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZCACHEDIR}/zcompcache"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' rehash true

# history

HISTFILE="${ZDATADIR}/history"
HISTSIZE=65535
SAVEHIST=65535

setopt   APPENDHISTORY
setopt   NOTIFY
unsetopt BEEP
unsetopt NOMATCH

unsetopt BANG_HIST                # don't treat the '!' character specially during expansion.
setopt   INC_APPEND_HISTORY       # write to the history file immediately, not when the shell exits.
setopt   SHARE_HISTORY            # share history between all sessions.
setopt   HIST_EXPIRE_DUPS_FIRST   # expire a duplicate event first when trimming history.
setopt   HIST_IGNORE_DUPS         # do not record an event that was just recorded again.
setopt   HIST_IGNORE_ALL_DUPS     # delete an old recorded event if a new event is a duplicate.
setopt   HIST_FIND_NO_DUPS        # do not display a previously found event.
setopt   HIST_IGNORE_SPACE        # do not record an event starting with a space.
setopt   HIST_SAVE_NO_DUPS        # do not write a duplicate event to the history file.
setopt   HIST_VERIFY              # do not execute immediately upon history expansion.
setopt   EXTENDED_HISTORY         # show timestamp in history.


# ---------------------------------------------------------------------------- #
#                            Zsh vim-like bindings                             #
# ---------------------------------------------------------------------------- #

bindkey '^K'   up-line-or-beginning-search
bindkey '^k'   up-line-or-beginning-search
bindkey '^J' down-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search


# ---------------------------------------------------------------------------- #
#                             Zinit configuration                              #
# ---------------------------------------------------------------------------- #

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

source "${ZINIT_HOME}/zinit.zsh"

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
         @muesli/duf

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

# ---------------------------------------------------------------------------- #
#                            Plugin configuration                              #
# ---------------------------------------------------------------------------- #

# sharkdp/bat theme.

export BAT_THEME='gruvbox-dark'

# autosuggestion plugin options.

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

# junegunn/fzf  settings. uses  sharkdp/fd as  a faster
# alternative to `find`.

FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
FZF_ALT_C_COMMAND='fd --type d --exclude .git --exclude .npm'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=fg:#a89984,bg:-1,hl:#d79921
--color=fg+:#ebdbb2,bg+:-1,hl+:#fabd2f
--color=info:#d79921,prompt:#d65d0e,pointer:#fe8019
--color=marker:#689d6a,spinner:#b16286,header:#83a598'

# Finalize p10k configuration.

(( ! ${+functions[p10k]} )) || p10k finalize
eval "$(zoxide init zsh)"
