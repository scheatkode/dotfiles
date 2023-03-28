#
#         ░█░░░█▀▀░░░█▀▀░█▀█░█░░░█▀█░█▀▄░█▀▀
#         ░█░░░▀▀█░░░█░░░█░█░█░░░█░█░█▀▄░▀▀█
#         ░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
#

autoload -U colors && colors # load colors.

LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32";
LSCOLORS="ExGxFxDxCxDxDxhbhdacEc";

# linux or bsd style ?

if command -v dircolors > /dev/null 2>&1 ; then
   eval "$(command dircolors --sh "$(dirname "${(%):-%N}")/gruvbox.dircolors")"
else
   eval "$(command gdircolors --sh "$(dirname "${(%):-%N}")/gruvbox.dircolors")"
fi
