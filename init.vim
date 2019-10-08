" ------------------------------------------------------------------------------
" -- modeline and notes ------------------------------------------------------{-
" ------------------------------------------------------------------------------
" vim: set sw=4 ts=4 sts=4 et tw=82 fmr={,} fdl=0 fdm=marker:
"
" ----------------------------------------------------------------------------}-
" -- environment -------------------------------------------------------------{-
" ------------------------------------------------------------------------------

" -- helper functions

silent function! s:amp_paths_exist(paths)
    let l:exists = true

    for l:path in a:paths
        if !is_directory(l:path)
            l:exists = false
        endif
    endfor

    return l:exists
endfunction

" -- identify platform

let s:amp_os_is_windows = has('win32') ||  has('win64')   ||  has('win16')
let s:amp_os_is_linux   = has('unix')  && !has('macunix') && !has('win32unix')
let s:amp_os_is_mac     = has('macunix')

if s:amp_os_is_windows
    let s:amp_path_separator = '\'
else
    let s:amp_path_separator = '/'
endif

" -- setup directories

let s:s               = s:amp_path_separator     " s:s takes less space to write
let s:amp_path_root   = fnamemodify(expand('<sfile>'), ':p:h:h:h') . s:s
let s:amp_path_neovim = s:amp_path_root   . 'neovim'  . s:s
let s:amp_path_config = s:amp_path_neovim . 'etc'     . s:s
let s:amp_path_plugin = s:amp_path_neovim . 'plugins' . s:s

let s:amp_path_xdg        = s:amp_path_neovim . 'xdg'    . s:s
let s:amp_path_xdg_data   = s:amp_path_xdg    . 'data'   . s:s
let s:amp_path_xdg_config = s:amp_path_xdg    . 'config' . s:s
let s:amp_path_xdg_cache  = s:amp_path_xdg    . 'cache'  . s:s

if s:amp_os_is_windows
    let s:amp_path_git    = s:amp_path_root . 'git'    . s:s . 'bin' . s:s
    let s:amp_path_node   = s:amp_path_root . 'node'   . s:s
    let s:amp_path_python = s:amp_path_root . 'python' . s:s

    let $PATH .= ';'.s:amp_path_git.';'.s:amp_path_node.';'.s:amp_path_python
endif

let $XDG_DATA_HOME   = s:amp_path_xdg_data
let $XDG_CONFIG_HOME = s:amp_path_xdg_config
let $XDG_CACHE_HOME  = s:amp_path_xdg_cache

let s:amp_path_plugin_dein = s:amp_path_plugin . s:s
            \   . 'repos'      . s:s
            \   . 'github.com' . s:s
            \   . 'Shougo'     . s:s
            \   . 'dein.vim'

" ----------------------------------------------------------------------------}-
" -- plug-ins ----------------------------------------------------------------{-
" ------------------------------------------------------------------------------

exec 'set runtimepath+='.s:amp_path_plugin_dein

try
    if dein#load_state(s:amp_path_plugin)
        call dein#begin(s:amp_path_plugin)

        " -- plug-in manager
        call dein#add(s:amp_path_plugin_dein)
        call dein#add('Shougo/dein.vim')

        " -- auto completion and linting plug-ins
        call dein#add('neoclide/coc.nvim',{'rev':'release'})

        " -- fuzzy, file viewer and the sort plug-ins
        call dein#add('Shougo/denite.nvim',{'build':'UpdateRemotePlugins'})
        call dein#add('scrooloose/nerdTree',{'on_cmd':'NERDTreeToggle'})

        " -- git plug-ins
        call dein#add('tpope/vim-fugitive')
        call dein#add('mhinz/vim-signify')

        " -- visual plug-ins
        call dein#add('vim-airline/vim-airline')
        call dein#add('morhetz/gruvbox')

        if !has('nvim')
            call dein#add('roxma/nvim-yarp')
            call dein#add('roxma/vim-hug-neovim-rpc')
        endif
    endif
catch
    echo 'dein.vim not found'
endtry

" ----------------------------------------------------------------------------}-
" -- plug-in options ---------------------------------------------------------{-
" ------------------------------------------------------------------------------

let g:python3_host_prog = s:amp_path_python . 'python'
let g:coc_node_path     = s:amp_path_node   . 'node'

let g:gruvbox_contrast_dark     = 'soft'
let g:gruvbox_italicize_strings = 1

let g:NERDTreeDirArrowExpandable  = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let g:airline_extensions = [
            \   'branch', 'coc', 'denite', 'fugitiveline',
            \   'keymap', 'quickfix', 'whitespace', 'wordcount'
            \ ]

" ----------------------------------------------------------------------------}-
" -- miscellaneous -----------------------------------------------------------{-
" ------------------------------------------------------------------------------

" set the number of lines (neo)vim has to remember
set history=1000

" enable filetype plug-ins and detection
if has('autocmd')
    filetype on
    filetype plugin on
    filetype indent on
endif

" enable syntax highlighting
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

" set autoread when a file is modified from outside
set autoread

" set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" use unix as the standard file format
set fileformats=unix,dos,mac

" set (neo)vim to no compatible mode
if &compatible
    set nocompatible
endif

" default cursor
set guicursor=

" configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" ----------------------------------------------------------------------------}-
" -- search ------------------------------------------------------------------{-
" ------------------------------------------------------------------------------

set ignorecase  " ignore case when searching
set smartcase   " when searching try to be smart about cases
set hlsearch    " highlight search results
set incsearch   " makes search act like search in modern browsers
set magic       " turn magic on for regular expressions

set inccommand=split " preview substitute results

" ----------------------------------------------------------------------------}-
" -- spaces ------------------------------------------------------------------{-
" ------------------------------------------------------------------------------

set expandtab       " use spaces instead of tabs
set smarttab        " be smart when using tabs
set softtabstop=4   " remove 4 spaces when hitting backspace
set tabstop=4       " 1 tab = 4 spaces
set shiftwidth=4    " > inserts 4 spaces
set shiftround      " > rounds to a multiple of 'shiftwidth'

set lbr   " break lines
set tw=82 " break lines on 82 characters

set autoindent  " auto indent
set smartindent " smart indent
set wrap        " wrap lines

" ----------------------------------------------------------------------------}-
" -- files, backup and undo --------------------------------------------------{-
" ------------------------------------------------------------------------------

set nobackup
set noswapfile
set nowritebackup

" ----------------------------------------------------------------------------}-
" -- user interface ----------------------------------------------------------{-
" ------------------------------------------------------------------------------

" -- locale
let $LANG='en'      " set language as english
set langmenu=en     " same

" -- scroll
set scrolloff=7     " set 7 lines to the cursor vertically
set sidescrolloff=5 " set 5 lines to the cursor horizontally

" -- status and commandline
set laststatus=2    " set statusline and commandline to be 2 rows high
set cmdheight=2     " height of the command bar

" -- line numbers
set number         " use line numbers
set relativenumber " use relative numbers to current line

set wildmenu                " turn on the wild menu
set wildignore=*.o,*~,*.pyc " ignore compiled files
if s:amp_os_is_windows
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set hidden         " hide a buffer if it's abandoned
set updatetime=300 " lessen screen update time

" configure backspace so it acts as it should
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set lazyredraw   " don't redraw while executing macros (good performance config)
set showmatch    " show matching brackets when text indicator is over them
set mat=2        " how many tenths of a second to blink when matching brackets
"set foldcolumn=1 " add a bit extra margin to the left

set cursorline " highlight current line

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500

" properly disable sound on errors on macvim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" mouse configuration
set mouse=a   " automatically enable mouse usage
set mousehide " automatically hide mouse cursor while typing

" set color scheme
try
    colorscheme gruvbox
catch
    colorscheme default
endtry

" set extra options when running in gui mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set termguicolors
else
    set t_Co=256
endif

" ----------------------------------------------------------------------------}-
" -- key mappings ------------------------------------------------------------{-
" ------------------------------------------------------------------------------

" -- Vanilla -------------------------------------------------------------------
    let mapleader=','

    " semicolon is never used anyway
    nnoremap <silent> ; :

    " remove search highlighting
    nnoremap <silent> <leader>s :let @/=""<CR>

" -- plugin manager ----------------------------------------------------(Dein)--
    nnoremap <silent> <leader>pi :call dein#install()<CR>
    nnoremap <silent> <leader>pu :call dein#update()<CR>

" -- file explorer -------------------------------------------------(NERDTree)--
    " toggle NERDTree side bar
    nnoremap <silent> <F1> :NERDTreeToggle<CR>

" -- intellisense and linting -------------------------------------------(CoC)--
    " use `[l` and `]l` to navigate diagnostic
    nmap <silent> [l <Plug>(coc-diagnostic-prev)
    nmap <silent> ]l <Plug>(coc-diagnostic-next)

    " remap keys for gotos
    nmap <silent> <leader>ld <Plug>(coc-definition)
    nmap <silent> <leader>lt <Plug>(coc-type-definition)
    nmap <silent> <leader>li <Plug>(coc-implementation)
    nmap <silent> <leader>lr <Plug>(coc-references)

    " use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    " remap for rename current word
    nmap <leader>lR <Plug>(coc-rename)

    " remap for format selected region
    xmap <leader>lf  <Plug>(coc-format-selected)
    nmap <leader>lf  <Plug>(coc-format-selected)

" -- fuzzy finding ---------------------------------------------------(Denite)--
    " <leader>ub - browse currently open buffers
    " <leader>uf - browse list of files in current directory
    " <leader>ug - search current directory for occurences of given term
    " <leader>uj - search current directory for occurences of word under cursor

    nnoremap <leader>ub :Denite buffer<CR>
    nnoremap <leader>uf :DeniteProjectDir file/rec<CR>
    nnoremap <leader>ug :<C-u>Denite grep:. -no-empty<CR>
    nnoremap <leader>uj :<C-u>DeniteCursorWord grep:.<CR>

" ----------------------------------------------------------------------------}-
" -- autocommands ------------------------------------------------------------{-
" ------------------------------------------------------------------------------

" -- vanilla

    autocmd FileType help call s:amp_help_settings()
    function! s:amp_help_settings()
        nnoremap <silent><buffer> <ESC>
                    \ :q<CR>
        nnoremap <silent><buffer> q
                    \ :q<CR>
    endfunction


" -- coc

    autocmd  FileType json syntax match Comment +\/\/.\+$+
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    " highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

    " update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')


" -- denite

    autocmd FileType denite call s:amp_denite_settings()
    function! s:amp_denite_settings() abort
        nnoremap <silent><buffer><expr> <CR>
                    \ denite#do_map('do_action')
        nnoremap <silent><buffer><expr> <ESC>
                    \ denite#do_map('quit')
        nnoremap <silent><buffer><expr> q
                    \ denite#do_map('quit')
        nnoremap <silent><buffer><expr> d
                    \ denite#do_map('do_action', 'delete')
        nnoremap <silent><buffer><expr> p
                    \ denite#do_map('do_action', 'preview')
        nnoremap <silent><buffer><expr> i
                    \ denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> <Space>
                    \ denite#do_map('toggle_select').'j'
    endfunction

    autocmd FileType denite-filter call s:amp_denite_filter_settings()
    function! s:amp_denite_filter_settings() abort
        inoremap <silent><buffer><expr> <ESC>
                    \ denite#do_map('quit')
        nnoremap <silent><buffer><expr> <ESC>
                    \ denite#do_map('quit')
        inoremap <silent><buffer><expr> <CR>
                    \ denite#do_map('do_action')
    endfunction


    " -- fugitive

    autocmd FileType fugitive call s:amp_fugitive_settings()
    function! s:amp_fugitive_settings() abort
        nnoremap <silent><buffer> <ESC>
                    \ :q<CR>
    endfunction

" ----------------------------------------------------------------------------}-
" -- helper functions --------------------------------------------------------{-
" ------------------------------------------------------------------------------

" -- coc

" show symbol documentation for coc autocompletion
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" -- denite

" loop through denite options and enable them
function! s:profile(opts) abort
    for l:fname in keys(a:opts)
        for l:dopt in keys(a:opts[l:fname])
            call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
        endfor
    endfor
endfunction

try
    call s:profile(s:denite_options)
catch
    echo 'denite not installed.'
endtry

" ----------------------------------------------------------------------------}-
