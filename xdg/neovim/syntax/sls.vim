" Vim syntax file
" Language: Salt States template

" for version 5.x: clear all syntax items
" for later versions: quit when a syntax file was already loaded
if version < 600
	syntax clear
elseif exists('b:current_syntax')
	finish
endif

let s:keepcpo = &cpo
set cpo&vim

if !exists('main_syntax')
	let main_syntax = 'yaml'
endif

runtime! syntax/yaml.vim
syntax include @Yaml  syntax/yaml.vim
syntax include @Jinja syntax/jinja.vim

let s:load_jinja_syntax = findfile('syntax/jinja.vim', &runtimepath, 1) != ''

if s:load_jinja_syntax
	syntax cluster jinjaSLSBlocks add=jinjaTagBlock,jinjaVarBlock,jinjaComment
	syntax region  jinjaTagBlock  matchgroup=jinjaTagDelim     start=/{%-\?/ end=/-\?%}/ containedin=ALLBUT,jinjaTagBlock,jinjaVarBlock,jinjaRaw,jinjaString,jinjaNested,jinjaComment,@jinjaSLSBlocks
	syntax region  jinjaVarBlock  matchgroup=jinjaVarDelim     start=/{{-\?/ end=/-\?}}/ containedin=ALLBUT,jinjaTagBlock,jinjaVarBlock,jinjaRaw,jinjaString,jinjaNested,jinjaComment,@jinjaSLSBlocks
	syntax region  jinjaComment   matchgroup=jinjaCommentDelim start="{#" end="#}" containedin=ALLBUT,jinjaTagBlock,jinjaVarBlock,jinjaString,@jinjaSLSBlocks
else
	" Fall back to Django template syntax
	syntax include @Jinja syntax/django.vim

	syntax cluster djangoBlocks   add=djangoTagBlock,djangoVarBlock,djangoComment,djangoComBlock
	syntax region  djangoTagBlock start="{%" end="%}" contains=djangoStatement,djangoFilter,djangoArgument,djangoTagError display containedin=ALLBUT,@djangoBlocks
	syntax region  djangoVarBlock start="{{" end="}}" contains=djangoFilter,djangoArgument,djangoVarError display containedin=ALLBUT,@djangoBlocks
	syntax region  djangoComBlock start="{#" end="#}" contains=djangoTodo containedin=ALLBUT,@djangoBlocks
endif

syntax keyword salt_stateInclude     include extend containedin=yamlBlockMappingKey
syntax keyword salt_stateSpecialArgs name names check_cmd listen listen_in onchanges onchanges_in onfail onfail_in onlyif prereq prereq_in require require_in unless use use_in watch watch_in containedin=yamlBlockMappingKey
syntax keyword salt_stateErrors      requires requires_in watches watches_in includes extends containedin=yamlBlockMappingKey

hi def link salt_stateInclude     Include
hi def link salt_stateSpecialArgs Special
hi def link salt_stateErrors      Error

let &cpo = s:keepcpo
unlet s:keepcpo

let b:current_syntax = 'sls'
