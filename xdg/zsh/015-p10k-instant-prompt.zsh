#
# ░█▀█░▀█░░▄▀▄░█░█░░░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█▀█░▀█▀░░░█▀█░█▀▄░█▀█░█▄█░█▀█░▀█▀
# ░█▀▀░░█░░█/█░█▀▄░░░░█░░█░█░▀▀█░░█░░█▀█░█░█░░█░░░░█▀▀░█▀▄░█░█░█░█░█▀▀░░█░
# ░▀░░░▀▀▀░░▀░░▀░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀░▀░░▀░░░░▀░░░▀░▀░▀▀▀░▀░▀░▀░░░░▀░
#

# enable  powerlevel10k  instant  prompt.  should  stay
# close   to    the   top    of   ~/.config/zsh/.zshrc.
# initialization  code that  may require  console input
# (password prompts, [y/n] confirmations, etc.) must go
# above this block; everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Local Variables:
# tab-width: 3
# mode: shell
# End:
# vim: set ft=zsh sw=3 ts=3 sts=3 et tw=78:
