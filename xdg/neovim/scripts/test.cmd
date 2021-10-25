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

nvim                                             \
   --headless                                    \
   --noplugin                                    \
   --clean                                       \
   -u tests/minimal.vim                          \
   -c "
      PlenaryBustedDirectory tests               \
         { minimal_init = 'tests/minimal.vim' }, \
         { sequential }                          \
      "                                          \
   -c "qa"

exit 0


:WINDOWS_CMD_SCRIPT

nvim              ^
   --headless     ^
   --noplugin     ^
   --clean        ^
   -u tests\minimal.vim ^
   -c "set shellslash" ^
   -c "PlenaryBustedDirectory tests { minimal_init = 'tests/minimal.vim' }, { sequential } " ^
   -c "qa"

