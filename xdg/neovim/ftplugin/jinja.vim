scriptencoding utf-8

" Vim filetype plugin

if exists('b:did_ftplugin')
	finish
endif

setlocal comments=s:{#,ex:#}
setlocal commentstring={#%s#}
setlocal formatoptions+=tcqln

if exists('loaded_matchit')
	let b:match_ignorecase = 1
	let b:match_skip       = 's:Comment'

	let b:match_words = '<:>,' .
				\ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
				\ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
				\ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>,' .
				\ '{%[-+]\? *\%(end\)\@!\(\w\+\)\>.\{-}%}:{%-\? *end\1\>.\{-}%}'
endif
