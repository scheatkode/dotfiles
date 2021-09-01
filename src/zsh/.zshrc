# ---------------------------------------------------------------------------- #
#                                 XDG setup                                    #
# ---------------------------------------------------------------------------- #

export   XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export  XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

[[ -d   "${XDG_DATA_HOME}" ]] || mkdir --parent "${XDG_DATA_HOME}"
[[ -d  "${XDG_CACHE_HOME}" ]] || mkdir --parent "${XDG_CACHE_HOME}"
[[ -d "${XDG_CONFIG_HOME}" ]] || mkdir --parent "${XDG_CONFIG_HOME}"

# ---------------------------------------------------------------------------- #
#                                 GPG setup                                    #
# ---------------------------------------------------------------------------- #

export GPG_TTY="${TTY}"

# ---------------------------------------------------------------------------- #
#                                Path setup                                    #
# ---------------------------------------------------------------------------- #

export PATH=$HOME/bin:${HOME}/local/bin:/usr/local/bin:$PATH

# ---------------------------------------------------------------------------- #
#                                Instant prompt                                #
# ---------------------------------------------------------------------------- #

# enable  powerlevel10k  instant  prompt.  should  stay
# close   to    the   top    of   ~/.config/zsh/.zshrc.
# initialization  code that  may require  console input
# (password prompts, [y/n] confirmations, etc.) must go
# above this block; everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ---------------------------------------------------------------------------- #
#                              Zsh configuration                               #
# ---------------------------------------------------------------------------- #

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


# ---------------------------------------------------------------------------- #
#                                  Ls colors                                   #
# ---------------------------------------------------------------------------- #

autoload -U colors && colors # load colors.

LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32";
LSCOLORS="ExGxFxDxCxDxDxhbhdacEc";

# do we need linux or bsd style ?

if command -v dircolors > /dev/null 2>&1 ; then
   eval "$(command dircolors --sh "$(dirname "${(%):-%N}")/gruvbox.dircolors")"
else
   eval "$(command gdircolors --sh "$(dirname "${(%):-%N}")/gruvbox.dircolors")"
fi

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
   command git clone --depth=1 https://github.com/zdharma/zinit "${ZINIT_HOME}" \
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

# these plugins provide many aliases - atload:''.

zinit wait:'0a' lucid for \
      OMZ::lib/git.zsh    \
   atload:'unalias grv'   \
      OMZ::plugins/git/git.plugin.zsh

# provide a simple prompt until the theme finishes loading.

PS1="Loading prompt ... "

zinit ice lucid                                      \
   depth=1                                           \
   atload:'source ${ZDOTDIR}/.p10k.zsh; _p9k_precmd'
zinit light romkatv/powerlevel10k

# ---------------------------------------------------------------------------- #
#                                   Plugins                                    #
# ---------------------------------------------------------------------------- #


zinit light zinit-zsh/z-a-bin-gem-node

# load early to mitigate romkatv/powerlevel#716

zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh

zinit wait:'0b' lucid light-mode for                              \
      OMZ::lib/clipboard.zsh                                      \
      OMZ::lib/compfix.zsh                                        \
      OMZ::lib/completion.zsh                                     \
      OMZ::lib/diagnostics.zsh                                    \
      OMZ::lib/functions.zsh                                      \
      OMZ::lib/git.zsh                                            \
      OMZ::lib/grep.zsh                                           \
      OMZ::lib/misc.zsh                                           \
      OMZ::lib/spectrum.zsh                                       \
      OMZ::lib/termsupport.zsh                                    \
      OMZ::lib/theme-and-appearance.zsh                           \
   atinit:"zicompinit; zicdreplay"                                \
         zdharma/fast-syntax-highlighting                         \
      OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh \
      OMZ::plugins/command-not-found/command-not-found.plugin.zsh \
      OMZ::plugins/dotnet/dotnet.plugin.zsh                       \
  atload:"_zsh_autosuggest_start"                                 \
         zsh-users/zsh-autosuggestions

zinit wait:'0b' lucid light-mode as:completion for \
      OMZ::plugins/docker/_docker                  \
      OMZ::plugins/ripgrep/_ripgrep                \
      OMZ::plugins/flutter/_flutter                \
      OMZ::plugins/composer/composer.plugin.zsh

# recommended be loaded last.

zinit ice wait'0c' blockf silent atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit wait:'1a' silent from:gh-r as:program light-mode for \
     pick:'${ZPFX}/bin/(fzf|fzf-tmux)'                     \
  atclone:'cp shell/completion.zsh _fzf_completion;        \
      cp bin/(fzf|fzf-tmux) ${ZPFX}/bin'                   \
     make:'PREFIX=${ZPFX} install'                         \
         @junegunn/fzf                                     \
     sbin:'lazygit'                                        \
   atload:'alias lg=lazygit'                               \
         @jesseduffield/lazygit                            \
     sbin:'tldr'                                           \
   atinit:'mv tldr* tldr 2> /dev/null'                     \
         @dbrgn/tealdeer                                   \
     sbin:'ipinfo'                                         \
   atinit:'mv ipinfo* ipinfo 2> /dev/null'                 \
   atpull:'%atinit'                                        \
  atclone:'%atinit'                                        \
         @ipinfo/cli                                       \
    bpick:'curlie*linux*64*gz'                             \
   atinit:'mv curlie* curlie 2> /dev/null'                 \
   atpull:'%atinit'                                        \
  atclone:'%atinit'                                        \
         @rs/curlie                                        \
   atinit:'mv sampler* sampler 2> /dev/null'               \
   atpull:'%atinit'                                        \
  atclone:'%atinit'                                        \
         @sqshq/sampler                                    \
    bpick:'duf*64*gz'                                      \
   atinit:'mv duf* duf 2> /dev/null'                       \
   atpull:'%atinit'                                        \
  atclone:'%atinit'                                        \
         @muesli/duf

zinit wait:'1b' silent from:gh-r as:program for                     \
       mv:'bat* -> bat'                                             \
     pick:'bat*/bat'                                                \
   atinit:'mv pueue-* pueue 2> /dev/null'                           \
  atclone:'%atinit'                                                 \
   atpull:'%atinit'                                                 \
   atload:'alias cat=bat'                                           \
            @sharkdp/bat                                            \
       mv:'fd* -> fd'                                               \
     pick:'fd/fd'                                                   \
            @sharkdp/fd                                             \
       mv:'hyperfine*/hyperfine -> hyperfine'                       \
     pick:'hyperfine*/hyperfine'                                    \
            @sharkdp/hyperfine                                      \
       mv:'exa* -> exa'                                             \
     pick:'bin/exa'                                                 \
   atload:'alias ls="exa --icons"'                                  \
            @ogham/exa                                              \
       mv:'ripgrep* -> ripgrep'                                     \
     pick:'ripgrep/rg'                                              \
            @BurntSushi/ripgrep                                     \
       mv:'procs* -> procs'                                         \
    bpick:'*lnx*'                                                   \
            @dalance/procs                                          \
       mv:'bandwhich* -> bandwhich'                                 \
     pick:'imsnif/bandwhich'                                        \
            @imsnif/bandwhich                                       \
       mv:'dust*/dust'                                              \
     pick:'dust*/dust'                                              \
            @bootandy/dust                                          \
    id-as:'pueue'                                                   \
    bpick:'pueue-*linux*64*'                                        \
  atclone:'mv pueue* pueue 2> /dev/null; ./pueue completions zsh .' \
   atpull:'%atclone'                                                \
   atload:'alias p=pueue'                                           \
            @Nukesor/pueue                                          \
    id-as:'pueued'                                                  \
    bpick:'pueued-*linux*64*'                                       \
   atinit:'mv pueued-* pueued 2> /dev/null'                         \
  atclone:'%atinit'                                                 \
   atpull:'%atinit'                                                 \
   atload:'pueued --daemonize > /dev/null 2>&1'                     \
            @Nukesor/pueue                                          \
     pick:'zoxide*/zoxide'                                          \
   atload:'eval "$(zoxide init zsh)"'                               \
            @ajeetdsouza/zoxide                                     \
     pick:'delta/delta'                                             \
   atinit:'mv delta-* delta 2> /dev/null'                           \
  atclone:'%atinit'                                                 \
   atpull:'%atinit'                                                 \
   atload:'alias diff="delta"'                                      \
            @dandavison/delta                                       \
     pick:'bin/dog'                                                 \
  atclone:'%atinit'                                                 \
   atpull:'%atinit'                                                 \
   atinit:'mv dog-* dog 2> /dev/null'                               \
   atload:'alias dig="dog"'                                         \
      src:'completions/dog.zsh'                                     \
            @ogham/dog

zinit creinstall pueue

# ---------------------------------------------------------------------------- #
#                            Plugin configuration                              #
# ---------------------------------------------------------------------------- #

# sharkdp/bat theme.

export BAT_THEME="gruvbox-dark"

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

# ---------------------------------------------------------------------------- #
#                            Alias configuration                               #
# ---------------------------------------------------------------------------- #

alias vol=alsamixer

# Finalize p10k configuration.

(( ! ${+functions[p10k]} )) || p10k finalize
