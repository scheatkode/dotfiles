" Vim syntax file
" Language: Git ignore file

" for version 5.x: clear all syntax items
" for later versions: quit when a syntax file was already loaded
if version < 600
	syntax clear
elseif exists('b:current_syntax')
	finish
endif

let s:keepcpo = &cpo
set cpo&vim

syntax keyword gitignore_todo      contained TODO FIXME XXX
syntax match   gitignore_comment   "^#.*" contains=gitignore_todo
syntax match   gitignore_comment   "\s#.*"ms=s+1 contains=gitignore_todo
syntax match   gitignore_file      "^\(#\)\@!.*\(/\)\@<!$"
syntax match   gitignore_directory "^\(#\)\@!.*\/$"

" define the default highlighting.
hi def link gitignore_comment   Comment
hi def link gitignore_todo      Todo
hi def link gitignore_directory Constant
hi def link gitignore_file      Type

let &cpo = s:keepcpo
unlet s:keepcpo

let b:current_syntax = 'gitignore'

setlocal commentstring=#\ %s
