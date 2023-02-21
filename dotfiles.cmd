: # This is a special script which intermixes both `sh`
: # and `cmd` code.  It is written this  way because it
: # is   used  in  `system()`  shell-outs  directly  in
: # otherwise portable code.

:<<"::WINJUMP"
@ECHO OFF
GOTO :WINDOWS_CMD_SCRIPT
::WINJUMP

set -e
set -u

has () {
	command -v "${1}" >/dev/null 2>&1
}

# no need for complicated checks here, just try running a lua
# interpreter in succession and print an error message if all
# else fails.
if has luajit; then
	luajit src/dotman/init.lua "${@}"
	exit 0
fi

if has lua; then
	lua src/dotman/init.lua "${@}"
	exit 0
fi

# fallback to neovim as a lua runtime.
if has nvim; then
	nvim                                   \
		--headless                          \
		--noplugin                          \
		--clean                             \
		--cmd 'luafile src/dotman/init.lua' \
		--cmd 'qa' -- "${@}"
	exit 0
fi

echo 'could not run dotman, at least lua (jit or 5.*) or neovim is required'

exit 65 # ENOPKG

:WINDOWS_CMD_SCRIPT

REM TODO(scheatkode): Handle windows case.

