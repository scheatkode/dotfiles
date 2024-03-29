#
#                   ░▀▀█░█▀▀░█░█░
#                   ░▄▀░░▀▀█░█▀█░
#                   ░▀▀▀░▀▀▀░▀░▀░
#
# shellcheck shell=sh

. "${ZDOTDIR}"/functions.include.sh
. "${ZDOTDIR}"/init.config.zsh
. "${ZDOTDIR}"/main.config.zsh
. "${ZDOTDIR}"/paths.plugin.sh
. "${ZDOTDIR}"/gpg.plugin.sh
. "${ZDOTDIR}"/ssh.plugin.sh
. "${ZDOTDIR}"/lscolors.plugin.sh
. "${ZDOTDIR}"/envvar.plugin.sh
. "${ZDOTDIR}"/alias.plugin.sh
. "${ZDOTDIR}"/bat.plugin.sh
. "${ZDOTDIR}"/git.plugin.sh
. "${ZDOTDIR}"/zoxide.plugin.sh
. "${ZDOTDIR}"/zinit.plugin.zsh

. "${ZDOTDIR}"/fancy-z.plugin.sh
. "${ZDOTDIR}"/fun.plugin.sh
. "${ZDOTDIR}"/fzf.plugin.sh

# shellcheck disable=3006
# this is interpreted by zsh anyway
(( ! ${+functions[p10k]} )) || p10k finalize
