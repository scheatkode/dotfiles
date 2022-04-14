: # This is a special script which intermixes both `sh`
: # and `cmd` code.  It is written this  way because it
: # is   used  in  `system()`  shell-outs  directly  in
: # otherwise portable code.

:<<"::WINJUMP"
@ECHO OFF
GOTO :WINDOWS_CMD_SCRIPT
::WINJUMP

set -u

# no need for complicated checks here, just try running a lua
# interpreter in succession and print an error message if all
# else fails.
if                                            \
		luajit src/dotman/init.lua 2> /dev/null \
	|| lua    src/dotman/init.lua 2> /dev/null
then
	exit 0
fi

# fallback to neovim as a lua runtime.
if                                        \
	nvim                                   \
		--headless                          \
		--noplugin                          \
		--clean                             \
		--cmd 'luafile src/dotman/init.lua' \
		--cmd 'qa' 2> /dev/null
then
	exit 0
fi

echo 'could not run dotman, at least lua (jit or 5.*) or neovim is required'

exit 65 # ENOPKG

:WINDOWS_CMD_SCRIPT

REM TODO(scheatkode): Handle windows case.

