" Vim compiler file
" Compiler: dotnet test

if exists("current_compiler")
   finish
endif
let current_compiler = "dotnet-test"
let s:keepcpo = &cpo
set cpo&vim

if exists(":CompilerSet") != 2
   command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=dotnet\ test\ -nologo\ -verbosity:quiet\ -property:GenerateFullPaths=true
CompilerSet errorformat=
            \%.%#=%f(%l\\\,%c):\ %tarning\ %m\ [%.%#],
            \%.%#=%f(%l\\\,%c):\ %trror\ %m\ [%.%#],
            \%f(%l\\\,%c):\ %tarning\ %m\ [%.%#],
            \%f(%l\\\,%c):\ %trror\ %m\ [%.%#],
         \%EError\ Message:\ %m,
         \%-G%.%#,
         \%.%#\ at\ %.%#\ in\ %f:line\ %l,
         \%C%.%#,
         \%-G%.%#

let &cpo = s:keepcpo
unlet s:keepcpo
