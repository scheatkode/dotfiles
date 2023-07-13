#
#          ░█▀█░█▀█░▀█▀░█░█░█▀▀
#          ░█▀▀░█▀█░░█░░█▀█░▀▀█
#          ░▀░░░▀░▀░░▀░░▀░▀░▀▀▀
#
# shellcheck shell=sh

export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export GOPATH="${XDG_DATA_HOME}/go"
export PNPM_HOME="${XDG_DATA_HOME}/pnpm"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

export npm_config_userconfig="${XDG_CONFIG_HOME}/npm/npmrc"
export npm_config_cache="${XDG_CACHE_HOME}/npm"
export npm_config_prefix="${XDG_DATA_HOME}/npm"

export LESSHISTFILE="${XDG_DATA_HOME}/less/history"
export LESSKEY="${XDG_DATA_HOME}/less/keys"

export PATH="${GOPATH}/bin:${CARGO_HOME}/bin:${PNPM_HOME}:${XDG_DATA_HOME}/npm/bin:/usr/local/bin:${PATH}"
