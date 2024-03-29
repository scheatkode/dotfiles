" Vim indent file
" Language:               Jinja template
" Shamelessly taken from: Glench/Vim-Jinja2-Syntax

" only load this indent file when no other was loaded.
if exists("b:did_indent")
	finish
endif

" indent within the jinja tags
if &l:indentexpr == ""
	if &l:cindent
		let &l:indentexpr = "cindent(v:lnum)"
	else
		let &l:indentexpr = "indent(prevnonblank(v:lnum-1))"
	endif
endif

let b:html_indentexpr = &l:indentexpr
let b:did_indent      = 1

setlocal indentexpr=IndentJinja()
setlocal indentkeys=o,O,*<Return>,{,},o,O,!^F,<>>

" only define the function once.
if exists("*IndentJinja")
   finish
endif

function! IndentJinja(...)
	if a:0 && a:1 == "."
		let v:lnum = line(".")
	elseif a:0 && a:1 =~ "^\d"
		let v:lnum = a:1
	endif

   call cursor(v:lnum, col("."))

	let ind  = &l:indentexpr
	let lnum = prevnonblank(v:lnum - 1)
	let pnb  = getline(lnum)
	let cur  = getline(v:lnum)

	let tagstart = ".*" . "{%\s*"
	let tagend   = ".*%}" . ".*"

	let blocktags = "\(block\|for\|if\|with\|autoescape\|comment\|filter\|spaceless\|macro\)"
	let midtags   = "\(empty\|else\|elif\)"

	let pnb_blockstart = pnb =~# tagstart . blocktags . tagend
	let pnb_blockend   = pnb =~# tagstart . "end"     . blocktags . tagend
	let pnb_blockmid   = pnb =~# tagstart . midtags   . tagend

	let cur_blockstart = cur =~# tagstart . blocktags . tagend
	let cur_blockend   = cur =~# tagstart . "end"     . blocktags . tagend
	let cur_blockmid   = cur =~# tagstart . midtags   . tagend

	if (pnb_blockstart && !pnb_blockend) || (pnb_blockmid && !pnb_blockend)
		let ind = ind + &shiftwidth
	endif

	if (cur_blockend && !cur_blockstart) || cur_blockmid
		let ind = ind - &shiftwidth
	endif

	return ind
endfunction
