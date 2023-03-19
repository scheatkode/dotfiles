" Vim syntax file
" Language:               Jinja template
" Shamelessly taken from: Glench/Vim-Jinja2-Syntax

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
	if v:version < 600
		syntax clear
	elseif exists("b:current_syntax")
		finish
	endif

	let main_syntax = "jinja"
endif

syntax case match

" jinja template built-in tags and parameters (without filter, macro, is
" and raw, they have special threatment)
syntax keyword jinjastatement containedin=jinjavarblock,jinjatagblock,jinjanested contained and if else in not or recursive as import

syntax keyword jinjastatement containedin=jinjavarblock,jinjatagblock,jinjanested contained is filter skipwhite nextgroup=jinjafilter
syntax keyword jinjastatement containedin=jinjatagblock contained macro skipwhite nextgroup=jinjafunction
syntax keyword jinjastatement containedin=jinjatagblock contained block skipwhite nextgroup=jinjablockname

" variable names
syntax match   jinjavariable containedin=jinjavarblock,jinjatagblock,jinjanested contained /[a-zA-Z_][a-zA-Z0-9_]*/
syntax keyword jinjaspecial  containedin=jinjavarblock,jinjatagblock,jinjanested contained false true none False True None loop super caller varargs kwargs

" filters
syntax match jinjaoperator  "|" containedin=jinjavarblock,jinjatagblock,jinjanested contained skipwhite nextgroup=jinjafilter
syntax match jinjafilter        contained /[a-zA-Z_][a-zA-Z0-9_]*/
syntax match jinjafunction      contained /[a-zA-Z_][a-zA-Z0-9_]*/
syntax match jinjablockname     contained /[a-zA-Z_][a-zA-Z0-9_]*/

" jinja template constants
syntax region jinjastring containedin=jinjavarblock,jinjatagblock,jinjanested contained start=/"/ skip=/\(\\\)\@<!\(\(\\\\\)\@>\)*\\"/ end=/"/
syntax region jinjastring containedin=jinjavarblock,jinjatagblock,jinjanested contained start=/'/ skip=/\(\\\)\@<!\(\(\\\\\)\@>\)*\\'/ end=/'/
syntax match  jinjanumber containedin=jinjavarblock,jinjatagblock,jinjanested contained /[0-9]\+\(\.[0-9]\+\)\?/

" operators
syntax match jinjaoperator    containedin=jinjavarblock,jinjatagblock,jinjanested contained /[+\-*\/<>=!,:]/
syntax match jinjapunctuation containedin=jinjavarblock,jinjatagblock,jinjanested contained /[()\[\]]/
syntax match jinjaoperator    containedin=jinjavarblock,jinjatagblock,jinjanested contained /\./ nextgroup=jinjaattribute
syntax match jinjaattribute   contained /[a-zA-Z_][a-zA-Z0-9_]*/

" jinja template tag and variable blocks
syntax region jinjanested   matchgroup=jinjaoperator start="(" end=")" transparent display containedin=jinjavarblock,jinjatagblock,jinjanested contained
syntax region jinjanested   matchgroup=jinjaoperator start="\[" end="\]" transparent display containedin=jinjavarblock,jinjatagblock,jinjanested contained
syntax region jinjanested   matchgroup=jinjaoperator start="{" end="}" transparent display containedin=jinjavarblock,jinjatagblock,jinjanested contained
syntax region jinjatagblock matchgroup=jinjatagdelim start=/{%[-+]\?/ end=/[-+]\?%}/ containedin=ALLBUT,jinjatagblock,jinjavarblock,jinjaraw,jinjastring,jinjanested,jinjacomment

syntax region jinjavarblock matchgroup=jinjavardelim start=/{{-\?/ end=/-\?}}/ containedin=ALLBUT,jinjatagblock,jinjavarblock,jinjaraw,jinjastring,jinjanested,jinjacomment

" jinja template "raw" tag
syntax region jinjaraw matchgroup=jinjarawdelim start="{%\s*raw\s*%}" end="{%\s*endraw\s*%}" containedin=ALLBUT,jinjatagblock,jinjavarblock,jinjastring,jinjacomment

" jinja comments
syntax region jinjacomment matchgroup=jinjacommentdelim start="{#" end="#}" containedin=ALLBUT,jinjatagblock,jinjavarblock,jinjastring,jinjacomment

" block start keywords. a bit tricker. we only highlight at the start of
" a tag block and only if the name is not followed by a comma or equals
" sign which usually means that we have to deal with an assignment.
syntax match jinjastatement containedin=jinjatagblock contained /\({%[-+]\?\s*\)\@<=\<[a-zA-Z_][a-zA-Z0-9_]*\>\(\s*[,=]\)\@!/

" and context modifiers
syntax match jinjastatement containedin=jinjatagblock contained /\<with\(out\)\?\s\+context\>/


" define the default highlighting.
hi def link jinjapunctuation  jinjaoperator
hi def link jinjaattribute    jinjavariable
hi def link jinjafunction     jinjafilter

hi def link jinjatagdelim     jinjatagblock
hi def link jinjavardelim     jinjavarblock
hi def link jinjacommentdelim jinjacomment
hi def link jinjarawdelim     jinja

hi def link jinjaspecial      Special
hi def link jinjaoperator     Operator
hi def link jinjaraw          Normal
hi def link jinjatagblock     PreProc
hi def link jinjavarblock     PreProc
hi def link jinjastatement    Statement
hi def link jinjafilter       Function
hi def link jinjablockname    Function
hi def link jinjavariable     Identifier
hi def link jinjastring       Constant
hi def link jinjanumber       Constant
hi def link jinjacomment      Comment

let b:current_syntax = "jinja"

if main_syntax ==# "jinja"
	unlet main_syntax
endif
