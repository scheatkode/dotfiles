" Vim syntax file
" Language: Salt States template

" for version 5.x: clear all syntax items
" for later versions: quit when a syntax file was already loaded
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

let s:keepcpo = &cpo
set cpo&vim

if !exists("main_syntax")
	let main_syntax = "yaml"
endif

runtime! syntax/yaml.vim
syntax include @Yaml  syntax/yaml.vim
syntax include @Jinja syntax/jinja.vim

syntax cluster jinjaslsblocks add=jinjatagblock,jinjavarblock,jinjacomment
syntax region  jinjatagblock  matchgroup=jinjatagdelim     start=/{%-\?/ end=/-\?%}/ containedin=ALLBUT,jinjatagblock,jinjavarblock,jinjaraw,jinjastring,jinjanested,jinjacomment,@jinjaslsblocks
syntax region  jinjavarblock  matchgroup=jinjavardelim     start=/{{-\?/ end=/-\?}}/ containedin=ALLBUT,jinjatagblock,jinjavarblock,jinjaraw,jinjastring,jinjanested,jinjacomment,@jinjaslsblocks
syntax region  jinjacomment   matchgroup=jinjacommentdelim start="{#" end="#}" containedin=ALLBUT,jinjatagblock,jinjavarblock,jinjastring,@jinjaslsblocks

syntax keyword salt_stateInclude     include extend containedin=yamlBlockMappingKey
syntax keyword salt_stateSpecialArgs name names check_cmd listen listen_in onchanges onchanges_in onfail onfail_in onlyif prereq prereq_in require require_in unless use use_in watch watch_in containedin=yamlBlockMappingKey
syntax keyword salt_stateErrors      requires requires_in watches watches_in includes extends containedin=yamlBlockMappingKey

hi def link salt_stateInclude     Include
hi def link salt_stateSpecialArgs Special
hi def link salt_stateErrors      Error

let &cpo = s:keepcpo
unlet s:keepcpo

let b:current_syntax = "sls"
