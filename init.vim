
" -- {MODELINE, NOTES, AND SUMMARY} --------------------------------------------
"
"   modeline :
"     vim: set sw=2 ts=2 sts=2 et tw=81 fmr={{{,}}} fdl=0 fdm=marker:
"
"   changelog :
"     - removed this section's fold to see the todo list every time the file
"       is opened
"
"   TODO :
"     [ ] lazy git binary inside a floating window => [jesseduffield/lazygit]
"         more user friendly than vim-fugitive and makes for quicker workflow
"         this guy managed to do it => [camspiers/dotfiles]
"     [ ] this is getting out of hand so make a shell script to automate
"         installation
"     [ ] better fzf buffer operations (delete, etc.)
"     [ ] cleanup plug definitions and add load conditions
"     [ ] follow-up: figure out a way to remove s:on_cursor_load() from airline
"     [ ] follow-up: maybe replace airline with lightline
"     [ ] document code
"     [ ] check out some documentation generator [kkoomen/vim-doge]
"
" ------------------------------------------------------------------------------
" -> FUNCTIONS -------------------------------------------------------------{{{-
" ------------------------------------------------------------------------------

" -> common --------------------------------------------------------------------

" removes leading and trailing whitespaces from given string
function! s:strip(str)
  return substitute(a:str, '^\s*\|\s*$', '', 'g')
endfunction


" removes trailing newline characters from given string
function! s:chomp(str)
  return substitute(a:str, '\n*$', '', 'g')
endfunction


" TODO
function! s:escape(path)
  let path = fnameescape(a:path)

  return s:vimrc_os_is_windows
        \ ? escape(path, '$')
        \ : path
endfunction


" TODO
function! s:paths_exist(paths)
  for l:path in a:paths
    if !is_directory(l:path)
      return 0
    endif
  endfor

  return 1
endfunction


" TODO
function! s:get_color(attr, ...)
  let l:gui = has('termguicolors') && &termguicolors
  let l:fam = l:gui ? 'gui' : 'cterm'
  let l:pat = l:gui ? '%#[a-f0-9]\+' : '^[0-9]\+$'

  for l:group in a:000
    let code = synIDattr(synIDtrans(hlID(l:group)), a:attr, l:fam)

    if code =~? l:pat
      return code
    endif
  endfor

  return ''
endfunction


" TODO
function! s:csi(color, fg)
  let l:prefix = a:fg ? '38;' : '48;'

  if a:color[0] == '#'
    return l:prefix . '2;'
          \   . join(
          \       map(
          \         [a:color[1:2], a:color[3:4], a:color[5:6]],
          \         'str2nr(v:val,16)'
          \       ), ';'
          \   )
  endif

  return l:prefix . '5;' . a:color
endfunction


" TODO
function! s:ansi(str, group, default, ...)
  let l:fg    = s:get_color('fg', a:group)
  let l:bg    = s:get_color('bg', a:group)
  let l:color = (
        \ empty(l:fg)
        \ ? s:ansi[a:default]
        \ : s:csi(l:fg,1)
        \ ) . (
        \ empty(l:bg)
        \ ? ''
        \ : ';' . s:csi(l:bg,0)
        \ )

  return printf("\x1b[%s%Sm%s\x1b[m", l:color, a:0 ? ';1' : '', a:str)
endfunction

" TODO
function! s:vimrc_quick_quit()
  nnoremap <silent><buffer> <ESC> :q<CR>
  nnoremap <silent><buffer> q     :q<CR>
endfunction

" -> vanilla -------------------------------------------------------------------

" TODO
function! s:linewrap_toggle()
  if &wrap
    set nowrap
  else
    set wrap
  endif
endfunction

" TODO
function! s:linenumber_toggle()
  if &number && &relativenumber
    set nonumber
    set norelativenumber
  else
    set number
    set relativenumber
  endif
endfunction

" TODO: basic shrink function for now, implement it later
function! s:pane_shrink()
  vertical resize 80
endfunction

" -> coc -----------------------------------------------------------------------

" show symbol documentation for coc autocompletion
function! s:coc_show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" -> lightline -----------------------------------------------------------------

function! LightlineReadonly()
  return &readonly ? "\ue0a2" : '' " 
endfunction

function! LightlineGit()
  let status = ''

  if exists('*FugitiveHead')
    let branch = fugitive#head()
    let status = branch !=# ''
          \ ? branch . " \ue0a0 "
          \ : '' " 
  endif

  if exists('*sy#repo#get_stats_decorated')
    return status . sy#repo#get_stats_decorated()
  endif

  if exists('*GitGutterGetHunkSummary')
    let [a,m,r] = GitGutterGetHunkSummary()
    let status .= printf('+%d ~%d -%d', a, m, r)
  endif

  return status
endfunction

" -> fzf -----------------------------------------------------------------------

" TODO
function! s:sort_buffers(...)
  let [b1, b2] = map(copy(a:000), 'get(g:fzf#vim#buffers, v:val, v:val)')
  return (b1 < b2) ? 1 : -1
endfunction


" returns visible buffers id list
function! s:vimrc_buffer_list()
  return filter(
        \   range(1, bufnr('$')),
        \   'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"'
        \ )
endfunction

" TODO
function! s:vimrc_buffer_list_sorted()
  return sort(s:vimrc_buffer_list(), 's:sort_buffers')
endfunction


" TODO
function! s:format_buffer(b)
  let l:name = bufname(a:b)

  let l:line = exists('*getbufinfo')
        \ ? getbufinfo(a:b)[0]['lnum']
        \ : 0

  let l:name = empty(l:name)
        \ ? '[No Name]'
        \ : fnamemodify(l:name, ":p:~:.")

  let l:flag = a:b == bufnr('')
        \ ? s:blue('%', 'Conditional')
        \ : (
        \      a:b == bufnr('#')
        \      ? s:magenta('#', 'Special')
        \      : ' '
        \ )

  let l:modified = getbufvar(a:b, '&modified')
        \ ? s:red(' [+]','Exception')
        \ : ''

  let l:readonly = getbufvar(a:b, '&modifiable')
        \ ? ''
        \ : s:green(' [RO]', 'Constant')

  let l:extra  = join(filter([l:modified, l:readonly], '!empty(v:val)'), '')

  let l:target = (l:line == 0)
        \ ? l:name
        \ : l:name . ':' . l:line

  return s:strip(
        \   printf(
        \     "%s\t[%s] %s\t%s\t%s",
        \     l:target,
        \     s:yellow(a:b, 'Number'),
        \     l:flag,
        \     l:name,
        \     l:extra
        \   )
        \ )
endfunction


" TODO
function! s:fzf_build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" TODO
function! s:fzf_delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(split(line)[0],':')[0]}))
endfunction

" --------------------------------------------------------------------------}}}-
" -> ENVIRONMENT SETUP -----------------------------------------------------{{{-
" ------------------------------------------------------------------------------

" set to non zero if using neovim portable
let s:vimrc_build_is_portable = 0

" -> setup terminal colors

let s:ansi = {
      \ 'black':   30,
      \ 'red':     31,
      \ 'green':   32,
      \ 'yellow':  33,
      \ 'blue':    34,
      \ 'magenta': 35,
      \ 'cyan':    36
      \ }

for s:color_name in keys(s:ansi)
  execute "function! s:" . s:color_name . "(str, ...)\n"
        \ "  return s:ansi(a:str, get(a:, 1, ''), '" . s:color_name . "')\n"
        \ "endfunction"
endfor

" -> identify platform

let s:vimrc_os_is_windows = has('win32') ||  has('win64')   ||  has('win16')
let s:vimrc_os_is_linux   = has('unix')  && !has('macunix') && !has('win32unix')
let s:vimrc_os_is_mac     = has('macunix')

" path separator differs on windows and other oses
let s:vimrc_path_separator = s:vimrc_os_is_windows ? '\' : '/'

" s:s takes less space to write
let s:s = s:vimrc_path_separator

" -> setup directories

if s:vimrc_build_is_portable
  let s:vimrc_path_root   = fnamemodify(expand('<sfile>'), ':p:h:h:h') . s:s
  let s:vimrc_path_neovim = s:vimrc_path_root   . 'neovim'  . s:s

  let s:vimrc_path_xdg        = s:vimrc_path_neovim . 'xdg'    . s:s
  let s:vimrc_path_xdg_data   = s:vimrc_path_xdg    . 'data'   . s:s
  let s:vimrc_path_xdg_config = s:vimrc_path_xdg    . 'config' . s:s
  let s:vimrc_path_xdg_cache  = s:vimrc_path_xdg    . 'cache'  . s:s

  let s:vimrc_path_config = s:vimrc_path_neovim . 'etc'     . s:s
  let s:vimrc_path_plugin = s:vimrc_path_neovim . 'plugins' . s:s

" --> git, node, and python for the portable version

  let s:vimrc_path_git    = s:vimrc_path_root . 'git'    . s:s . 'bin' . s:s
  let s:vimrc_path_node   = s:vimrc_path_root . 'node'   . s:s
  let s:vimrc_path_python = s:vimrc_path_root . 'python' . s:s

  let $PATH.=';'.s:vimrc_path_git.';'.s:vimrc_path_node.';'.s:vimrc_path_python
else
  if s:vimrc_os_is_windows
    let s:vimrc_path_root   = expand('~\Appdata\Local\')
    let s:vimrc_path_neovim = s:vimrc_path_root . 'nvim' . s:s

    let s:vimrc_path_xdg        = s:vimrc_path_root
    let s:vimrc_path_xdg_data   = s:vimrc_path_xdg
    let s:vimrc_path_xdg_config = s:vimrc_path_xdg
    let s:vimrc_path_xdg_cache  = s:vimrc_path_xdg

    let s:vimrc_path_config = s:vimrc_path_neovim
    let s:vimrc_path_plugin = s:vimrc_path_neovim . 'plugins' . s:s
  else
    let s:vimrc_path_root   = expand('~') . s:s
    let s:vimrc_path_neovim = s:vimrc_path_root

    let s:vimrc_path_xdg        = s:vimrc_path_root
    let s:vimrc_path_xdg_data   = s:vimrc_path_xdg.'.local' .s:s.'share'.s:s
    let s:vimrc_path_xdg_config = s:vimrc_path_xdg.'.config'.s:s
    let s:vimrc_path_xdg_cache  = s:vimrc_path_xdg.'.cache' .s:s

    let s:vimrc_path_config = s:vimrc_path_xdg_config.'nvim'.s:s
    let s:vimrc_path_plugin = s:vimrc_path_xdg_data  .'nvim'.s:s.'plugins'.s:s

    let s:vimrc_path_xdg_cache  = empty($XDG_CACHE_HOME)
          \ ? s:vimrc_path_xdg_cache
          \ : $XDG_CACHE_HOME

    let s:vimrc_path_xdg_config = empty($XDG_CONFIG_HOME)
          \ ? s:vimrc_path_xdg_config
          \ : $XDG_CONFIG_HOME

    let s:vimrc_path_xdg_data   = empty($XDG_DATA_HOME)
          \ ? s:vimrc_path_xdg_data
          \ : $XDG_DATA_HOME
  endif
endif

let $XDG_CACHE_HOME  = s:vimrc_path_xdg_cache
let $XDG_CONFIG_HOME = s:vimrc_path_xdg_config
let $XDG_DATA_HOME   = s:vimrc_path_xdg_data

" --------------------------------------------------------------------------}}}-
" -> DEPENDENCY CHECKING  --------------------------------------------------{{{-
" ------------------------------------------------------------------------------

if !executable('git')
  " TODO
endif

if !executable('node')
  " TODO
endif

" --------------------------------------------------------------------------}}}-
" -> DIRECTORY CREATION ----------------------------------------------------{{{-
" ------------------------------------------------------------------------------

call mkdir($XDG_CACHE_HOME,  'p', 0700)
call mkdir($XDG_CONFIG_HOME, 'p', 0700)
call mkdir($XDG_DATA_HOME,   'p', 0700)

" --------------------------------------------------------------------------}}}-
" -> PLUGINS ---------------------------------------------------------------{{{-
" ------------------------------------------------------------------------------

" -> plugin manager automatic setup --------------------------------------------

let s:vimrc_path_plugin_plug        = s:vimrc_path_plugin.'..'.s:s.'vim-plug'
let s:vimrc_plugin_manager_present  = !empty(glob(s:vimrc_path_plugin_plug))
let s:vimrc_path_plugin_plug_script = s:vimrc_path_plugin_plug . s:s
      \ . 'autoload' . s:s
      \ . 'plug.vim'

exec 'set runtimepath+=' . s:vimrc_path_plugin_plug

if !s:vimrc_plugin_manager_present
  execute 'silent !curl -fLo "' . s:vimrc_path_plugin_plug_script
    \ . '" --create-dirs'
    \ . ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

unlet s:vimrc_path_plugin_plug
unlet s:vimrc_path_plugin_plug_script

" -> plugin declaration --------------------------------------------------------

call plug#begin(s:vimrc_path_plugin)

  " --> plug-in manager
  "Plug 'junegunn/vim-plug', {'on':[],'frozen':1}

  " --> auto completion, language server, tags, and snippets plug-ins
  Plug 'neoclide/coc.nvim',    {'branch':'release'}
  "Plug 'rhysd/vim-grammarous' | " technically a language server
  "Plug 'liuchengxu/vista.vim'
  "Plug 'honza/vim-snippets'

  " --> fuzzy searching and file exploring plug-ins
  Plug 'scrooloose/nerdTree', {'on':'NERDTreeToggle'}
  Plug 'junegunn/fzf',        {'do':'./install --all > /dev/null 2>&1'}
  Plug 'junegunn/fzf.vim'

  " --> git plug-in
  Plug 'tpope/vim-fugitive' " git wrapper
  Plug 'mhinz/vim-signify'  " show git file changes in the gutter

  " --> visual plug-ins
  "Plug 'nathanaelkane/vim-indent-guides' | " indentation guides
  Plug 'vim-airline/vim-airline' | " status bar
  "Plug 'itchyny/lightline.vim'
  Plug 'ryanoasis/vim-devicons'  | " icons            | filetypes and the such
  Plug 'morhetz/gruvbox'         | " colorscheme      | THE colorscheme
  Plug 'junegunn/goyo.vim'       | " distraction-free | no ui elements
  Plug 'junegunn/limelight.vim'  | " distraction-free | dim paragraphs
  Plug 'camspiers/animate.vim'   | " animation library
  Plug 'camspiers/lens.vim'      | " auto resize (panes|windows) when tight

  " --> syntax plug-ins
  Plug 'sheerun/vim-polyglot'

  " --> miscellaneous plug-ins
  Plug 'mhinz/vim-startify'   | " start screen
  Plug 'psliwka/vim-smoothie' | " smooth scrolling
  "Plug 'vimwiki/vimwiki'      | " personal note taking
  Plug 'kana/vim-operator-user'
  Plug 'junegunn/vim-easy-align', { 'on':['<Plug>(EasyAlign)','EasyAlign']}
  Plug 'machakann/vim-sandwich',  { 'on':[
        \ '<Plug>(operator-sandwich-add)',
        \ '<Plug>(operator-sandwich-delete)',
        \ '<Plug>(operator-sandwich-replace)',
        \ '<Plug>(textobj-sandwich-auto-a)',
        \ '<Plug>(textobj-sandwich-auto-i)',
        \ '<Plug>(textobj-sandwich-query-a)',
        \ '<Plug>(textobj-sandwich-query-i)'
        \ ] }

  if !has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif

call plug#end()

" -> plugin options ------------------------------------------------------------

" --> CoC

if s:vimrc_plugin_manager_present
  if s:vimrc_build_is_portable
    let g:python3_host_prog = s:vimrc_path_python . 'python'
    let g:coc_node_path     = s:vimrc_path_node   . 'node'
  endif

  let g:coc_config_home = s:vimrc_path_neovim
  let g:coc_data_home   = s:vimrc_path_xdg_cache . 'coc'

  let g:coc_global_extensions = [
        \ 'coc-diagnostic',
        \ 'coc-pairs',
        \ 'coc-vimlsp',
        \ 'coc-python',
        \ 'coc-clangd',
        \ 'coc-tsserver',
        \ 'coc-powershell',
        \ 'coc-sh',
        \ 'coc-html',
        \ 'coc-css',
        \ ]
        "\ 'coc-snippets',

  call coc#config('coc.preferences.useQuickfixForLocations', 'false')
  call coc#config('coc.preferences.colorSupport','true')
  call coc#config('coc.preferences.rootPatterns', [
        \    '.git',
        \    '.hg',
        \    '.venv',
        \    '.env',
        \    'package.json',
        \])

  call coc#config('suggest.timeout', 500)
  call coc#config('suggest.enablePreview', 'true')
  call coc#config('suggest.maxPreviewWidth', 35)
  call coc#config('suggest.detailMaxLength', 100)
  call coc#config('suggest.detailField', 'preview')
  call coc#config('suggest.removeDuplicateItems', 'true')
  call coc#config('suggest.snippetIndicator', " \ue796")
  call coc#config('suggest.completionItemKindLabels', {
        \    'keyword':       "\uf1de",
        \    'variable':      "\ue79b",
        \    'value':         "\uf89f",
        \    'operator':      "\u03a8",
        \    'function':      "\u0192",
        \    'reference':     "\ufa46",
        \    'constant':      "\uf8fe",
        \    'method':        "\uf09a",
        \    'struct':        "\ufb44",
        \    'class':         "\uf0e8",
        \    'interface':     "\uf417",
        \    'text':          "\ue612",
        \    'enum':          "\uf435",
        \    'enumMember':    "\uf02b",
        \    'module':        "\uf40d",
        \    'color':         "\ue22b",
        \    'property':      "\ue624",
        \    'field':         "\uf9be",
        \    'unit':          "\uf475",
        \    'event':         "\ufacd",
        \    'file':          "\uf723",
        \    'folder':        "\uf114",
        \    'snippet':       "\ue60b",
        \    'typeParameter': "\uf728",
        \    'default':       "\uf29c"
        \})

  call coc#config('codeLens.enable',    'true')
  call coc#config('codeLens.separator', "\u2023")

  call coc#config('list.indicator',"\ue602")
  call coc#config('list.maxHeight',15)

  "call coc#config('signature.target','echo')

  call coc#config('diagnostic.level',       'hint')
  call coc#config('diagnostic.virtualtext', 'true')
  call coc#config('diagnostic.errorSign',   "\uf65b")
  call coc#config('diagnostic.warningSign', "\uf421")
  call coc#config('diagnostic.infoSign',    "\uf05a")
  call coc#config('diagnostic.hintSign',    "\u25b8")
  "call coc#config('diagnostic.messageTarget','echo')

  " lint `sh` (includes `bash`) files
  call coc#config("diagnostic-languageserver.filetypes", {
        \    "sh": "shellcheck"
        \ })

  " format `sh` (includes `bash`) files using formatter defined below
  call coc#config("diagnostic-languageserver.formatFiletypes", {
        \    "sh": "shfmt"
        \ })

  " define our formatter so that we can reference it from
  " `diagnostic-languageserver.formatFiletypes`
    "\         all the below args are entirely optional
    "\"         primarily listed here to call out that flags which take an
    "\"         argument (such as `-i <num-spaces>` for specifying indentation)
    "\         should be split into two strings, the flag and then the value

  call coc#config("diagnostic-languageserver.formatters", {
        \    "shfmt": {
        \        "command": "shfmt",
        \        "args":    ["-i", "2", "-bn", "-ci", "-sr"]
        \    }
        \}
        \)

  call coc#config('clangd.semanticHighlighting','true')

  " --> Vista

  let g:vista_default_executive            = 'coc'
  "let g:vista_sidebar_width                = 10
  let g:vista_cursor_delay                 = 800
  let g:vista_update_on_text_changed       = 1
  let g:vista_update_on_text_changed_delay = 5000
  let g:vista_close_on_jump                = 0
  let g:vista_fzf_preview                  = [ 'right:45%' ]
  let g:vista_icon_indent                  = [
        \ "\u2570\u2500\u25b8 ",
        \ "\u251c\u2500\u25b8 "
        \]

  " --> FzF

  let $FZF_DEFAULT_COMMAND = empty($FZF_DEFAULT_COMMAND)
        \ ? 'rg --files'
        \ : $FZF_DEFAULT_COMMAND

  let $FZF_DEFAULT_OPTS = empty($FZF_DEFAULT_OPTS)
        \ ? '--bind=ctrl-u:half-page-up,ctrl-d:half-page-down'
        \ : $FZF_DEFAULT_OPTS

  let g:fzf_buffers_jump    = 1 " jump to existing window if possible
  let g:fzf_commands_expect = 'ctrl-s,ctrl-w,ctrl-v,ctrl-t,alt-d'

  let g:fzf_layout = {
        \ 'window':
        \ 'new | wincmd J | resize 1 | call animate#window_percent_height(0.45)'
        \ }
  " if floating windows become consistent and more flexible where it is possible
  " to center everything, fzf has it already covered
  "      \ 'window': {
  "      \     'width':   0.9,
  "      \     'height':  0.6
  "      \   }

  let g:fzf_action = {
        \ 'ctrl-q': function('s:fzf_build_quickfix_list'),
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit',
        \ }

  " --> Gruvbox

  let g:gruvbox_contrast_dark     = 'hard'
  let g:gruvbox_bold              = 1
  let g:gruvbox_underline         = 1
  let g:gruvbox_undercurl         = 1
  let g:gruvbox_italic            = 1
  let g:gruvbox_italicize_strings = 1

  " --> Indentation Guides

"  if g:gruvbox_loaded
"    hi IndentGuidesEven ctermbg=235
"    hi IndentGuidesOdd  ctermbg=236
"  endif

  " --> Animate

  let g:animate#duration = 200.0

  " --> Startify

  let g:startify_files_number        = 15
  let g:startify_padding_left        = 5
  let g:startify_change_to_dir       = 0
  let g:startify_fortune_use_unicode = 1
  let g:startify_custom_header       =
        \ 'startify#center(startify#fortune#cowsay())'
  let g:startify_lists = [
        \   {'type':'files','header':['   MRU']}
        \ ]

  " --> VimWiki

  let g:vimwiki_list = [{
        \ 'path'     : '~/wiki',
        \ 'syntax'   : 'markdown',
        \ 'ext'      : '.md',
        \ 'auto_toc' : 1
        \ }]

  let g:vimwiki_global_ext = 0 " disable temporary wikis

  " --> Limelight

  let g:limelight_conceal_ctermfg = 'DarkGray' " set unimportant text color
  let g:limelight_paragraph_span  = 0          " number of paragraphs to include
  let g:limelight_priority        = -1         " hide search highlighting

  " --> NERDTree

  let g:NERDTreeCaseSensitiveSort   = 1
  let g:NERDTreeNaturalSort         = 1
  let g:NERDTreeSortHiddenFirst     = 1
  let g:NERDTreeChDirMode           = 2
  let g:NERDTreeQuitOnOpen          = 3
  let g:NERDTreeAutoDeleteBuffer    = 1
  let g:NERDTreeDirArrowExpandable  = '▸'
  let g:NERDTreeDirArrowCollapsible = '▾'

  " --> vim-sandwich

  let g:sandwich_no_default_key_mappings = 1 " disable sandwich default mappings

  " --> Airline

  let g:airline_powerline_fonts = 1
  let g:airline_left_sep        = "\ue0c8" " 
  let g:airline_left_alt_sep    = "\ue0bb" " 
  let g:airline_right_sep       = "\ue0c7" " 
  let g:airline_right_alt_sep   = "\ue0b9" " 

  let g:airline_extensions = [
        \ 'branch',
        \ 'coc',
        \ 'fugitiveline',
        \ 'hunks',
        \ 'whitespace',
        \ 'wordcount'
        \ ]

  let g:lightline = {
        \   'colorscheme': 'jellybeans',
        \   'active': {
        \     'left':[
        \               [ 'mode', 'paste' ],
        \               [ 'cocstatus','gitbranch', 'readonly', 'filename', 'modified' ]
        \     ],
        \     'right':[
        \               [ 'lineinfo' ],
        \               [ 'percent' ]
        \     ]
        \   },
        \   'component': {
        \     'lineinfo': ' %3l:%-2v  ',
        \   },
        \   'component_function': {
        \     'cocstatus': 'coc#status',
        \     'gitbranch': 'LightlineGit',
        \   }
        \ }
  let g:lightline.separator = {
        \   'left': "\ue0c8", 'right': "\ue0c7"
        \}
  let g:lightline.subseparator = {
        \   'left': "\ue0bb", 'right': "\ue0b9"
        \}

endif

" --------------------------------------------------------------------------}}}-
" -> MISCELLANEOUS ---------------------------------------------------------{{{-
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

" set utf8 as standard encoding
set encoding=utf8
scriptencoding utf-8

" use unix as the standard file format
set fileformats=unix,dos,mac

" format comments into paragraphs and join comment leaders automatically
set formatoptions=cqrj

" set (neo)vim to no compatible mode
if &compatible
  set nocompatible
endif

" default cursor
set guicursor=

" configure backspace so it acts as it should
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" --------------------------------------------------------------------------}}}-
" -> SEARCH ----------------------------------------------------------------{{{-
" ------------------------------------------------------------------------------

set ignorecase  " ignore case when searching
set smartcase   " when searching try to be smart about cases
set hlsearch    " highlight search results
set incsearch   " makes search act like search in modern browsers
set magic       " turn magic on for regular expressions

set inccommand=split " preview substitute results

" --------------------------------------------------------------------------}}}-
" -> WHITESPACES -----------------------------------------------------------{{{-
" ------------------------------------------------------------------------------

set expandtab       " use spaces instead of tabs
set smarttab        " be smart when using tabs
set softtabstop=4   " remove 4 spaces when hitting backspace
set tabstop=4       " 1 tab = 4 spaces
set shiftwidth=4    " > inserts 4 spaces
set shiftround      " > rounds to a multiple of 'shiftwidth'

set lbr   " break lines
set tw=91 " break lines on 90 characters

set autoindent  " auto indent
set smartindent " smart indent

" --------------------------------------------------------------------------}}}-
" -> FILES, BACKUP, AND UNDO -----------------------------------------------{{{-
" ------------------------------------------------------------------------------

set nobomb        " don't prepend bom byte
set nobackup
set noswapfile
set nowritebackup

" --------------------------------------------------------------------------}}}-
" -> USER INTERFACE --------------------------------------------------------{{{-
" ------------------------------------------------------------------------------

" -- locale
let $LANG='en'      " set language as english
set langmenu=en     " same

" -- inactivity delay
set updatetime=6000 " 6 seconds

" -- scroll
set scrolloff=7     " set 7 lines to the cursor vertically
set sidescrolloff=5 " set 5 lines to the cursor horizontally

" -- status and commandline
set laststatus=2    " set statusline and commandline to be 2 rows high
set cmdheight=1     " height of the command bar
set noshowmode      " disable showing modes below the statusline

" -- line numbers
set number         " use line numbers
set relativenumber " use relative numbers to current line

" -- signs and autocompletion
set shortmess+=c    " don't pass messages to |ins-completion-menu|
set signcolumn=yes  " always show the sign column because it gets annoying

" -- line wrapping
set nowrap        " don't wrap lines
set list listchars=tab:▸\ ,trail:\ ,precedes:←,extends:→

" -- natural splits
set splitright " split the new pane to the right
set splitbelow " split the new pane below the current one

" -- menus
set wildmenu                " enable autocomplete menu
set wildignore=*.o,*~,*.pyc " ignore compiled and swap files

if s:vimrc_os_is_windows
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set hidden " hide a buffer if it's abandoned

" configure backspace so it acts as it should
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set lazyredraw   " don't redraw while executing macros (good performance config)
set showmatch    " show matching brackets when text indicator is over them
set mat=2        " how many tenths of a second to blink when matching brackets

"set foldcolumn=1 " add a bit extra margin to the left
set foldmethod=syntax " fold language objects (classes, functions, etc.)
set foldlevel=1       " fold on the second level

set cursorline " highlight current line

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=600

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

" custom terminal title
let &titlestring = $USER . '@' . hostname() . ' : %F %r: %m'
set title

" fix ugly colors on some terminals
" --> https://github.com/neovim/neovim/issues/2897#issuecomment-115464516
if has('nvim')
  let g:terminal_color_0  = '#2e3436'
  let g:terminal_color_1  = '#cc0000'
  let g:terminal_color_2  = '#4e9a06'
  let g:terminal_color_3  = '#c4a000'
  let g:terminal_color_4  = '#3465a4'
  let g:terminal_color_5  = '#75507b'
  let g:terminal_color_6  = '#0b939b'
  let g:terminal_color_7  = '#d3d7cf'
  let g:terminal_color_8  = '#555753'
  let g:terminal_color_9  = '#ef2929'
  let g:terminal_color_10 = '#8ae234'
  let g:terminal_color_11 = '#fce94f'
  let g:terminal_color_12 = '#729fcf'
  let g:terminal_color_13 = '#ad7fa8'
  let g:terminal_color_14 = '#00f5e9'
  let g:terminal_color_15 = '#eeeeec'
endif

" --------------------------------------------------------------------------}}}-
" -> COMMANDS --------------------------------------------------------------{{{-
" ------------------------------------------------------------------------------

" -> additional commands -------------------------------------------------------

" --> vanilla

  command! WrapToggle       call <SID>linewrap_toggle()
  command! LineNumberToggle call <SID>linenumber_toggle()
  command! PaneShrink       call <SID>pane_shrink()

" --> fzf

  command! BufferDelete call fzf#run(fzf#wrap({
      \ 'source' : map(s:vimrc_buffer_list_sorted(), 's:format_buffer(v:val)'),
      \ 'sink*' : { lines -> s:fzf_delete_buffers(lines) },
      \ 'options' : '--multi --ansi --bind ctrl-a:select-all'
      \ }))

" -> automatic commands -------------------------------------------------------

" --> vanilla

  " show cursorline only in windows which have focus
  autocmd WinEnter,FocusGained * set cursorline
  autocmd WinLeave,FocusLost   * set nocursorline

  " update a buffer's contents on focus if it changed outside of the editor
  autocmd FocusGained,BufEnter * :checktime

  " highlight unwanted spaces
  autocmd BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * silent! match ExtraWhitespace /\s\+%#\@<!$/

  " clear stale messages under the status line after some timeout
  autocmd CursorHold * :echo

  " unset paste mode when finished
  autocmd InsertLeave * silent! set nopaste

  " set crlf for windows scripting languages
  autocmd FileType cmd,ps1 setlocal fileformat=dos

" --> coc

if s:vimrc_plugin_manager_present
  augroup CoC
    autocmd!
    autocmd  FileType json syntax match Comment +\/\/.\+$+
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    " highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

    " update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup END

" --> airline#extensions#whitespace

"  augroup Airline#Whitespace
"    autocmd!
"    autocmd CursorHold * silent call airline#extensions#whitespace#check()
"  augroup END

" --> vista.vim

  augroup Vista
    autocmd FileType vista,vista_kind nnoremap <buffer> <silent>
          \ / :<C-u>call vista#finder#fzf#Run()<CR>
  augroup END

" --> vim-fugitive

  " re-read file if it has just been created; this helps vim-fugitive register
  " it and make it appear automatically in :G status.

  augroup Fugitive
    autocmd!
    autocmd BufWritePre *
          \  if !filereadable(expand('%'))
          \|    let b:new_file = 1
          \| endif
    autocmd BufWritePost *
          \  if get(b:, 'new_file', 0)
          \|    silent execute 'e'
          \|    let b:new_file = 0
          \| endif
  augroup END
endif

" --> vimwiki

  augroup VimWiki
    autocmd!
    autocmd FileType vimwiki setlocal spell
  augroup END

" --------------------------------------------------------------------------}}}-
" -> KEY MAPPINGS ----------------------------------------------------------{{{-
" ------------------------------------------------------------------------------

" -> normal key mappings -------------------------------------------------------

" --> vanilla ------------------------------------------------------------------

  let mapleader=','

  " semicolon is never used anyway
  nnoremap <silent> ; :
  xnoremap <silent> ; :

  " easier navigation
  nnoremap j gj
  xnoremap j gj
  nnoremap k gk
  xnoremap k gk

  " don't lose selection when shifting sidewards
  " https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
  xnoremap < <gv
  xnoremap > >gv

  " saner behavior of n and N (search forward and backward, respectively)
  " https://github.com/mhinz/vim-galore#go-to-other-end-of-selected-text
  nnoremap <expr> n 'Nn'[v:searchforward]
  xnoremap <expr> n 'Nn'[v:searchforward]
  onoremap <expr> n 'Nn'[v:searchforward]

  nnoremap <expr> N 'nN'[v:searchforward]
  xnoremap <expr> N 'nN'[v:searchforward]
  onoremap <expr> N 'nN'[v:searchforward]

  " insert mode navigation
  inoremap <M-k> <up>
  inoremap <M-j> <down>
  inoremap <M-h> <left>
  inoremap <M-l> <right>

  " quick screen centering in insert mode
  inoremap <C-z><C-z> <C-o>zz

  " less use of arrow keys in command mode
  cnoremap <C-k> <up>
  cnoremap <C-j> <down>

  " quickly go to last command
  nnoremap <leader>cl :<up>
  xnoremap <leader>cl :<up>

  " remove search highlighting
  nnoremap <silent> <leader>s :let @/=""<CR>

  " more consistent pane navigation
  nnoremap <silent> <C-w>[ <C-w><left>
  nnoremap <silent> <C-w>] <C-w><right>

  " simple pane navigation with leader key
  nnoremap <silent> <leader>[ <C-w><left>
  nnoremap <silent> <leader>] <C-w><right>

  " more complete pane navigation with leader key
  nnoremap <silent> <leader>wj <C-w><down>
  nnoremap <silent> <leader>wk <C-w><up>
  nnoremap <silent> <leader>wl <C-w><right>
  nnoremap <silent> <leader>wh <C-w><left>
  nnoremap <silent> <leader>wv <C-w>v
  "nnoremap <silent> <leader>ws <C-w>s

  " easier to remember pane splitting
  nnoremap <silent> <leader>_  <C-w>s
  nnoremap <silent> <leader>\| <C-w>v

  " quick quickfix
  nnoremap <silent> <leader>qo :copen<CR>
  nnoremap <silent> <leader>qc :cclose<CR>

  " toggles
  nnoremap <silent> <leader>tln :LineNumberToggle<CR>
  nnoremap <silent> <leader>tw  :WrapToggle<CR>

  " shrink pane
  nnoremap <silent> <leader>shrink :PaneShrink<CR>

" --> plugin manager ---------------------------------------------------(Plug)--

  nnoremap <silent> <leader>pu :PlugUpdate<CR>
  nnoremap <silent> <leader>pU :PlugUpgrade<CR>
  nnoremap <silent> <leader>pi :PlugInstall<CR>
  nnoremap <silent> <leader>pc :PlugClean<CR>
  nnoremap <silent> <leader>ps :PlugStatus<CR>

" --> file explorer ------------------------------------------------(NERDTree)--

  " toggle NERDTree side bar
  nnoremap <silent> <F1> :NERDTreeToggle<CR>

" --> distraction-free -------------------------------------(Goyo & Limelight)--

  nnoremap <silent> <leader>G :Goyo<CR>

  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!

" --> intellisense and linting ------------------------------------------(CoC)--

  " use `[l` and `]l` to navigate diagnostic
  nmap <silent> [l <Plug>(coc-diagnostic-prev)
  nmap <silent> ]l <Plug>(coc-diagnostic-next)

  " remap keys for gotos
  nmap <silent> <leader>ld <Plug>(coc-definition)
  nmap <silent> <leader>lT <Plug>(coc-type-definition)
  nmap <silent> <leader>li <Plug>(coc-implementation)
  nmap <silent> <leader>lr <Plug>(coc-references)

  " use K to show documentation in preview window
  nnoremap <silent> K :call <SID>coc_show_documentation()<CR>

  " remap for rename current word
  nmap <leader>lR <Plug>(coc-rename)

  " remap for format selected region
  xmap <leader>lf  <Plug>(coc-format-selected)
  nmap <leader>lf  <Plug>(coc-format-selected)

  " coc lists shortcut
  nnoremap <leader>ll :CocList<CR>

" --> grammar correction -------------------------------------(vim-grammarous)--

  nmap ]gr <Plug>(grammarous-move-to-next-error)
  nmap [gr <Plug>(grammarous-move-to-prevous-error)

  nmap <silent> <leader>gra <Plug>(operator-grammarous)
  nmap <silent> <leader>gro <Plug>(grammarous-open-info-window)
  nmap <silent> <leader>grm <Plug>(grammarous-move-to-info-window)
  nmap <silent> <leader>grq <Plug>(grammarous-close-info-window)

" --> tag list --------------------------------------------------------(Vista)--

  nnoremap <silent> <leader>lt :Vista!!<CR>

" --> fuzzy finding -----------------------------------------------------(FzF)--

  " <leader>ub - browse currently open buffers
  " <leader>uf - browse list of files in current directory
  " <leader>uF - prompt for a path of which to list the contents
  " <leader>ul - browse lines of the currently open buffer
  " <leader>uL - browse lines of all currently open buffers
  " <leader>uc - browse list of commands
  " <leader>ug - browse list of files under the current working directory
  " <leader>uG - prompt for a pattern to look for
  " <leader>uw - browse list of currently open windows

  nnoremap <leader>ub :Buffers<CR>
  nnoremap <leader>uf :Files<CR>
  nnoremap <leader>uF :Files<space>
  nnoremap <leader>ul :Lines<CR>
  nnoremap <leader>uL :BLines<CR>
  nnoremap <leader>uc :Commands<CR>
  nnoremap <leader>ug :Rg<CR>
  nnoremap <leader>uG :Rg<space>
  nnoremap <leader>uw :Windows<CR>

" --> text alignment -----------------------------------------(vim-easy-align)--

  " <leader>ta - start EasyAlign

  xmap <leader>ta <Plug>(EasyAlign)
  nmap <leader>ta <Plug>(EasyAlign)

" --> text surrounding & text object definition ----------------(vim-surround)--

  " <leader>tsd - shortcut to delete surrounding character
  " <leader>tsc - shortcut to change surrounding character
  " <leader>tsy - shortcut for interactive changing
  " <leader>tsv - shortcut for visual modification

  nmap <leader>tsd <Plug>(operator-sandwich-delete)
        \<Plug>(operator-sandwich-release-count)
        \<Plug>(textobj-sandwich-query-a)
  nmap <leader>tsdd <Plug>(operator-sandwich-delete)
        \<Plug>(operator-sandwich-release-count)
        \<Plug>(textobj-sandwich-auto-a)
  nmap <leader>tsc <Plug>(operator-sandwich-replace)
        \<Plug>(operator-sandwich-release-count)
        \<Plug>(textobj-sandwich-query-a)
  nmap <leader>tscc <Plug>(operator-sandwich-replace)
        \<Plug>(operator-sandwich-release-count)
        \<Plug>(textobj-sandwich-auto-a)

  nmap <leader>tsa <Plug>(operator-sandwich-add)
  xmap <leader>tsa <Plug>(operator-sandwich-add)

  " text object definition

  xmap is <Plug>(textobj-sandwich-query-i)
  xmap as <Plug>(textobj-sandwich-query-a)
  omap is <Plug>(textobj-sandwich-query-i)
  omap as <Plug>(textobj-sandwich-query-a)

  " text object to select nearest surrounded text automatically

  xmap iss <Plug>(textobj-sandwich-auto-i)
  xmap ass <Plug>(textobj-sandwich-auto-a)
  omap iss <Plug>(textobj-sandwich-auto-i)
  omap ass <Plug>(textobj-sandwich-auto-a)

  " text objects to select a text surrounded by user input character

  xmap im <Plug>(textobj-sandwich-literal-query-i)
  xmap am <Plug>(textobj-sandwich-literal-query-a)
  omap im <Plug>(textobj-sandwich-literal-query-i)
  omap am <Plug>(textobj-sandwich-literal-query-a)

  " additional text objects

  xnoremap <silent> il g_o^
  onoremap <silent> il :normal vil<CR>
  xnoremap <silent> al $o^
  onoremap <silent> al :normal val<CR>

" --> git operations -------------------------------------------(vim-fugitive)--

  nnoremap <leader>g :G<CR>
  nnoremap <leader>gp :Gpush<CR>
  nnoremap <leader>gP :Gpush<space>

" --> personal wiki -------------------------------------------------(vimwiki)--

  nnoremap <silent> <leader>wkt :vsplit \| VimwikiIndex<CR>

" -> conditional key mappings --------------------------------------------------

" --> vanilla

  autocmd FileType help call s:vimrc_quick_quit()
  autocmd FileType qf   call s:vimrc_quick_quit()

" --> fugitive

  autocmd FileType fugitive call s:vimrc_quick_quit()

" --> nerdtree

  autocmd FileType nerdtree call s:vimrc_quick_quit()

" --> plugin update

  autocmd FileType vim-plug call s:vimrc_quick_quit()

" --------------------------------------------------------------------------}}}-
