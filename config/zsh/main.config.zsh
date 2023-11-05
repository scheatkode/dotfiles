#
#                   ░▀▀█░█▀▀░█░█░
#                   ░▄▀░░▀▀█░█▀█░
#                   ░▀▀▀░▀▀▀░▀░▀░
#
# shellcheck shell=bash
# shellcheck disable=2296

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

# history

export HISTFILE="${ZDATADIR?}/history"
export HISTSIZE=65535
export SAVEHIST=65535

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
#                                Autosuggestion                                #
# ---------------------------------------------------------------------------- #

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=true

# ---------------------------------------------------------------------------- #
#                                 Word style                                   #
# ---------------------------------------------------------------------------- #

# Useful when <C-w>-ing a path.

autoload -U select-word-style
select-word-style bash

# ---------------------------------------------------------------------------- #
#                                    ZStyle                                    #
# ---------------------------------------------------------------------------- #

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
zstyle ':completion::complete:*' cache-path "${ZCACHEDIR?}/zcompcache"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' rehash true
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
