#
#          ░█▀▀░█▀█░█░█░█░█░█▀█░█▀▄
#          ░█▀▀░█░█░▀▄▀░▀▄▀░█▀█░█▀▄
#          ░▀▀▀░▀░▀░░▀░░░▀░░▀░▀░▀░▀
#
# shellcheck shell=sh

if _dot_has nvim; then
	export EDITOR='nvim'
elif _dot_has vim; then
	export EDITOR='vim'
fi

if _dot_has firefox; then
	export BROWSER='firefox'
fi

# Use dark mode

export GTK_THEME=Adwaita:dark
export QT_STYLE_OVERRIDE=adwaita-dark

# disable branding & telemetry

export DOTNET_CLI_TELEMETRY_OPTOUT=yes
export DOTNET_NOLOGO=yes
