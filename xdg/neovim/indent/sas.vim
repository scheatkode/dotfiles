" Vim indent file
" Language: SAS

if exists('b:did_indent')
	finish
endif

let b:did_indent = 1

setlocal indentexpr=IndentSAS()
setlocal indentkeys+=;,=~data,=~proc

if exists("*IndentSAS")
	finish
endif

let s:cpo_save = &cpo
set cpo&vim

" list of procs supporting run-processing
let s:run_processing_procs = [
			\ 'anova',
			\ 'arima',
			\ 'catalog',
			\ 'catmod',
			\ 'chart',
			\ 'datasets',
			\ 'document',
			\ 'ds2',
			\ 'factex',
			\ 'gareabar',
			\ 'gbarline',
			\ 'gchart',
			\ 'gkpi',
			\ 'glm',
			\ 'gmap',
			\ 'gplot',
			\ 'gradar',
			\ 'greplay',
			\ 'gslide',
			\ 'gtile',
			\ 'iml',
			\ 'model',
			\ 'optex',
			\ 'plan',
			\ 'plot',
			\ 'reg',
			\ 'sql',
			\ ]

" regex that captures the start of a data/proc section
let s:section_str     = '\v%(^|;)\s*%(data|proc)>'
" regex that captures the start of a data/proc section that
" supports run-processing
let s:section_rpp_str = '\v%(^|;)\s*proc\s+%(' . join(s:run_processing_procs, '|') . ')>'
" regex that captures the end of a data/proc section
let s:section_run     = '\v%(^|;)\s*run>'
" regex that captures the end of a data/proc section that
" supports run-processing
let s:section_end     = '\v%(^|;)\s*%(quit|enddata)>'

" regex that captures the start of a control block within data
" section
let s:block_str      = '\v\%@<!<%(do>%([^;]+<%(to|over|until|while)>[^;]+)=|select%(\s+\([^;]+\))=)\s*;'
" regex that captures the end of a control block within data
" section
let s:block_end      = '\v\%@<!<end\s*;'
" regex that captures the start of a control block within proc
" section
let s:proc_block_str = '\v%(^|;)\s*%(begingraph|compute|layout|sidebar|innermargin|discreteattrmap)>'
" regex that captures the end of a control block within proc
" section
let s:proc_block_end = '\v%(^|;)\s*%(endgraph|endcomp|endlayout|endsidebar|endinnermargin|enddiscreteattrmap)>'

" regex that captures the start of a submit block
let s:submit_str = '\v%(^|;)\s*submit>'
" regex that captures the end of a submit block
let s:submit_end = '\v%(^|;)\s*endsubmit>'

" regex that captures the start of a macro definition
let s:macro_str       = '\v\%macro>'
" regex that captures the end of a macro definition
let s:macro_end       = '\v\%mend>'
" regex that captures the start of a macro control block
let s:macro_block_str = '\v\%do>'
" regex that captures the end of a macro control block
let s:macro_block_end = '\v\%end>'

" regex that defines the end of the program
let s:program_end = '\v%(^|;)\s*endsas>'


" find the line number of previous keyword defined by the regex
function! MatchPrevious(line_number, regex)
	let skip_line            = '\v%(^|;)\s*\%=\*'
	let previous_line_number = prevnonblank(a:line_number - 1)

	while previous_line_number > 0
		let previous_line = getline(previous_line_number)

		if previous_line =~? a:regex && previous_line !~? skip_line
			break
		endif

		let previous_line_number = prevnonblank(previous_line_number - 1)
	endwhile

	return previous_line_number
endfunction


function! IndentSAS()
	let prev_lnum = prevnonblank(v:lnum - 1)

	if prev_lnum ==# 0
		" leave the indentation of the first line unchanged
		return indent(1)
	endif

	let prev_line = getline(prev_lnum)

	" previous non-blank line contains the start of
	" a macro/section/control block while not the end of
	" a macro/section/control block (at the same line)
	if
				\    (prev_line =~? s:section_str     && prev_line !~? s:section_run && prev_line !~? s:section_end)
				\ || (prev_line =~? s:block_str       && prev_line !~? s:block_end)
				\ || (prev_line =~? s:proc_block_str  && prev_line !~? s:proc_block_end)
				\ || (prev_line =~? s:submit_str      && prev_line !~? s:submit_end)
				\ || (prev_line =~? s:macro_str       && prev_line !~? s:macro_end)
				\ || (prev_line =~? s:macro_block_str && prev_line !~? s:macro_block_end)

		let ind = indent(prev_lnum) + shiftwidth()

	elseif prev_line =~? s:section_run && prev_line !~? s:section_end

		let prev_section_str_lnum = MatchPrevious(v:lnum, s:section_str)
		let prev_section_end_lnum = max([
					\ MatchPrevious(v:lnum, s:section_end    ),
					\ MatchPrevious(v:lnum, s:submit_str     ),
					\ MatchPrevious(v:lnum, s:submit_end     ),
					\ MatchPrevious(v:lnum, s:macro_str      ),
					\ MatchPrevious(v:lnum, s:macro_end      ),
					\ MatchPrevious(v:lnum, s:program_end    )])

		" check if the previous section supports run-processing
		if
					\ prev_section_end_lnum < prev_section_str_lnum
					\ && getline(prev_section_str_lnum) =~? s:section_rpp_str

			let ind = indent(prev_lnum) + shiftwidth()

		else
			let ind = indent(prev_lnum)
		endif

	else
		let ind = indent(prev_lnum)
	endif

	" re-adjustments based on the inputs of the current line
	let curr_line = getline(v:lnum)

	if curr_line =~? s:program_end
		" end of the program
		let prev_macro_str_lnum = MatchPrevious(v:lnum, s:macro_str)
		let prev_macro_end_lnum = MatchPrevious(v:lnum, s:macro_end)

		if prev_macro_end_lnum < prev_macro_str_lnum
			" same indentation as the first non-blank line within
			" the macro definition
			return indent(nextnonblank(prev_macro_str_lnum + 1))
		endif

		" same indentation as the first non-blank line
		return indent(nextnonblank(1))
	endif

	if curr_line =~? s:macro_end && curr_line !~? s:macro_str
		" current line is the end of a macro
		" match the indentation of the start of the macro
		return indent(MatchPrevious(v:lnum, s:macro_str))
	endif

	if curr_line =~? s:section_end
		" current line is the end of a run-processing section
		" match the indentation of the start of the run-processing
		" section
		let prev_section_rpp_str_lnum = MatchPrevious(v:lnum, s:section_rpp_str)
		let prev_section_end_lnum = max([
					\ MatchPrevious(v:lnum, s:section_end),
					\ MatchPrevious(v:lnum, s:macro_str  ),
					\ MatchPrevious(v:lnum, s:macro_end  ),
					\ MatchPrevious(v:lnum, s:program_end)])

		if prev_section_end_lnum < prev_section_rpp_str_lnum
			return indent(prev_section_rpp_str_lnum)
		endif
	elseif curr_line =~? s:section_str || curr_line =~? s:section_run
		" re-adjust if current line is the start/end of a section
		" since the end of the previous section could be
		" inexplicit
		let prev_section_str_lnum = MatchPrevious(v:lnum, s:section_str)
		let prev_section_end_lnum = max([
					\ MatchPrevious(v:lnum, s:section_end    ),
					\ MatchPrevious(v:lnum, s:submit_str     ),
					\ MatchPrevious(v:lnum, s:submit_end     ),
					\ MatchPrevious(v:lnum, s:macro_str      ),
					\ MatchPrevious(v:lnum, s:macro_end      ),
					\ MatchPrevious(v:lnum, s:program_end    )])

		if prev_section_end_lnum < prev_section_str_lnum
			return indent(prev_section_str_lnum)
		endif
	elseif curr_line =~? s:submit_end && curr_line !~? s:submit_str
		" current line is the end of a submit block
		" match the indentation of the start of the submit block
		return indent(MatchPrevious(v:lnum, s:submit_str))
	endif

	if (curr_line =~? s:block_end && curr_line !~? s:block_str) ||
				\ (curr_line =~? s:proc_block_end && curr_line !~? s:proc_block_str) ||
				\ (curr_line =~? s:macro_block_end && curr_line !~? s:macro_block_str)
		" re-adjust if current line is the end of a control block
		" while not the beginning of a control block (at the same
		" time). returning the indent of previous block start
		" directly would not work due to nesting.
		let ind = ind - shiftwidth()
	endif

	return ind
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
