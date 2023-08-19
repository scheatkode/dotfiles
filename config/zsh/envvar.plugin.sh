#
#          ░█▀▀░█▀█░█░█░█░█░█▀█░█▀▄
#          ░█▀▀░█░█░▀▄▀░▀▄▀░█▀█░█▀▄
#          ░▀▀▀░▀░▀░░▀░░░▀░░▀░▀░▀░▀
#
# shellcheck shell=sh

if command -v nvim > /dev/null 2>&1; then
   export EDITOR='nvim'
fi

if command -v firefox > /dev/null 2>&1; then
   export BROWSER='firefox'
fi

# Use dark mode

export GTK_THEME=Adwaita:dark
export QT_STYLE_OVERRIDE=adwaita-dark

# disable branding & telemetry

export DOTNET_CLI_TELEMETRY_OPTOUT=yes
export DOTNET_NOLOGO=yes
