#
#         ░█▀▀░█▀█░█░█░░░█▀▀░█▀▀░▀█▀░█░█░█▀█
#         ░█▀▀░█░█░▀▄▀░░░▀▀█░█▀▀░░█░░█░█░█▀▀
#         ░▀▀▀░▀░▀░░▀░░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░░
#

# EDITOR

if command -v nvim > /dev/null 2>&1 ; then
   export EDITOR='nvim'
fi

# Dotnet

export DOTNET_CLI_TELEMETRY_OPTOUT=yes
export              DOTNET_NOLOGO=yes

# Local Variables:
# tab-width: 3
# mode: shell
# End:
# vim: set ft=zsh sw=3 ts=3 sts=3 et tw=78:
