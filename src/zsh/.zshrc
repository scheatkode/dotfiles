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
#                                Instant prompt                                #
# ---------------------------------------------------------------------------- #

# enable powerlevel10k instant prompt. should stay close to the top of
# ~/.config/zsh/.zshrc. initialization code that may require console input
# (password prompts, [y/n] confirmations, etc.) must go above this block;
# everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ---------------------------------------------------------------------------- #
#                              Zsh configuration                               #
# ---------------------------------------------------------------------------- #

# install functions

export UPDATE_INTERVAL="${UPDATE_INTERVAL:-15}"
export ZDOTDIR="${ZDOTDIR:-${XDG_CONFIG_HOME}/zsh}"
export ZDATADIR="${ZDATADIR:-${XDG_DATA_HOME}/zsh}"
export ZCACHEDIR="${ZCACHEDIR:-${XDG_CACHE_HOME}/zsh}"
export ZSH="${ZDOTDIR}"

[[ -d   "${ZDOTDIR}" ]] || mkdir --parent "${ZDOTDIR}"
[[ -d  "${ZDATADIR}" ]] || mkdir --parent "${ZDATADIR}"
[[ -d "${ZCACHEDIR}" ]] || mkdir --parent "${ZCACHEDIR}"

# load the prompt and completion systems and initialize them.

autoload -Uz compinit promptinit

# on slow systems, checking the cached .zcompdump file to see if it must be
# regenerated adds a noticable delay to zsh startup.  this little hack restricts
# it to once every 20 hours.

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
#                                 Zsh settings                                 #
# ---------------------------------------------------------------------------- #

autoload -U colors && colors # load colors.
unsetopt CASE_GLOB           # use case-insensitive globbing.
setopt   GLOBDOTS            # glob dotfiles as well.
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
zstyle ':completion::complete:*' cache-path "$HOME/.zcompcache"
zstyle ':completion:*' list-colors $LS_COLORS
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
#                             Zinit configuration                              #
# ---------------------------------------------------------------------------- #

declare -A ZINIT

ZINIT=(
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
#                                    Theme                                     #
# ---------------------------------------------------------------------------- #

# most themes use this option.

setopt promptsubst

# these plugins provide many aliases - atload''

zinit wait lucid for   \
      OMZ::lib/git.zsh \
   atload"unalias grv" \
      OMZ::plugins/git/git.plugin.zsh

# provide a simple prompt until the theme finishes loading.

PS1="READY >"
zinit ice wait'!' lucid
zinit ice depth=1
zinit light romkatv/powerlevel10k

# ---------------------------------------------------------------------------- #
#                                   Plugins                                    #
# ---------------------------------------------------------------------------- #

# load early to mitigate romkatv/powerlevel#716

zinit snippet OMZ::lib/key-bindings.zsh

zinit wait'0a' lucid light-mode for                                   \
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
      OMZ::plugins/fzf/fzf.plugin.zsh                             \
   atinit"zicompinit; zicdreplay"                                 \
         zdharma/fast-syntax-highlighting                         \
      OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh \
      OMZ::plugins/command-not-found/command-not-found.plugin.zsh \
  atload"_zsh_autosuggest_start"                                  \
         zsh-users/zsh-autosuggestions                            \
  as"completion"                                                  \
      OMZ::plugins/docker/_docker                                 \
      OMZ::plugins/composer/composer.plugin.zsh

# recommended be loaded last.

zinit ice wait'0c' blockf lucid atpull'zinit creinstall -q .'
zinit load zsh-users/zsh-completions

zinit ice lucid wait'1c' as"command" id-as"junegunn/fzf-tmux" pick"bin/fzf-tmux"
zinit light junegunn/fzf

zinit ice lucid wait'1c' from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat" atload"alias cat=bat"
zinit light sharkdp/bat

export BAT_THEME="gruvbox-dark"

zinit ice lucid wait'1c' as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

zinit ice lucid wait'1c' from"gh-r" as"program" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
zinit light BurntSushi/ripgrep

zinit ice lucid wait"1c" as"program" from"gh-r" mv"lazygit* -> lazygit" atload"alias lg='lazygit'"
zinit light 'jesseduffield/lazygit'

# ---------------------------------------------------------------------------- #
#                         Theme / Prompt customization                         #
# ---------------------------------------------------------------------------- #

# to customize prompt, run `p10k configure` or edit `~/.p10k.zsh`.

[[ ! -f "${ZDOTDIR}/.p10k.zsh" ]] || . "${ZDOTDIR}/.p10k.zsh"

# old config
# FIXME: needs to be cleaned up

autoload -U select-word-style
select-word-style bash

DISABLE_AUTO_TITLE="off"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

# fzf settings. uses sharkdp/fd for a faster alternative to `find`.

FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
FZF_ALT_C_COMMAND='fd --type d --exclude .git --exclude .npm'
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS}
--color fg:252,hl:67,fg+:252,bg+:235,hl+:81
--color info:144,prompt:161,spinner:135,pointer:135,marker:118
"

# updating the path

export PATH=$HOME/bin:${HOME}/local/bin:/usr/local/bin:$PATH

# to customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.

[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

