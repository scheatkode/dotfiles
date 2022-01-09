" Vim compiler file
" Compiler: dotnet build

if exists("current_compiler")
   finish
endif
let current_compiler = "dotnet-build"
let s:keepcpo = &cpo
set cpo&vim

if exists(":CompilerSet") != 2
   command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=dotnet\ build\ -nologo\ --verbosity:quiet\ --property:GenerateFullPaths=true
CompilerSet errorformat=
         \%-A%.%#Microsoft%.%#,
         \%-ZBuild\ FAILED.,
         \%C%.%#,
         \%-G%.%#,
            \%f(%l\\\,%c):\ %tarning\ %m\ [%.%#],
            \%f(%l\\\,%c):\ %trror\ %m\ [%.%#],
         \%-G%.%#

let &cpo = s:keepcpo
unlet s:keepcpo
