#
#         ░█▀▀░█▀█░█░█░░░█▀▀░█▀▀░▀█▀░█░█░█▀█
#         ░█▀▀░█░█░▀▄▀░░░▀▀█░█▀▀░░█░░█░█░█▀▀
#         ░▀▀▀░▀░▀░░▀░░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░░
#
# shellcheck shell=sh

# EDITOR

if command -v nvim > /dev/null 2>&1 ; then
   export EDITOR='nvim'
fi

if command -v firefox > /dev/null 2>&1 ; then
   export BROWSER='firefox'
fi

# Dotnet

export DOTNET_CLI_TELEMETRY_OPTOUT=yes
export              DOTNET_NOLOGO=yes
