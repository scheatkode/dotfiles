------------------------------------------------------------------------------
--                     ░█▀▀░█▀▀░▀█▀░▀█▀░▀█▀░█▀█░█▀▀░█▀▀                     --
--                     ░▀▀█░█▀▀░░█░░░█░░░█░░█░█░█░█░▀▀█                     --
--                     ░▀▀▀░▀▀▀░░▀░░░▀░░▀▀▀░▀░▀░▀▀▀░▀▀▀                     --
------------------------------------------------------------------------------

local fn  = vim.fn
local opt = vim.opt
local o   = vim.o

local has_06 = scheatkode.has('nvim-0.6')

-- compatibility {{{1

opt.compatible = false


-- ui {{{1

opt.termguicolors =  true -- true colors for better visuals
opt.syntax        = 'off' -- overridden by treesitter
opt.lazyredraw    =  true -- don't redraw when executing macros
opt.pumheight     =    15 -- limit completion items
opt.pumblend      =    15 -- make popup window translucient
opt.winblend      =    10 -- floating window transparency
opt.conceallevel  =     2 -- hide text unless it has a custom replacement

-- status and command line {{{1

opt.history    =  1000 -- number of commands to remember
opt.cmdheight  =     1 -- height of the command bar
opt.laststatus =     2 -- always enable the status line
opt.showcmd    =  true -- show me keystrokes
opt.showmode   = false -- disable showing modes below the status line

opt.shortmess  = {
   s = true, -- ignore 'search hit BOTTOM' kind of messages
   t = true, -- truncate long messages
   I = true, -- no need for vim's intro message
   c = true, -- don't give 'ins-completion-menu' messages
   q = true, -- i know what macro i'm recording, thank you
}

-- file change detection {{{1

opt.autoread  = true -- detect external file modifications
opt.autowrite = true -- auto write buffer when not focused

-- encoding {{{1

opt.bomb        =   false -- don't prepend bom byte
opt.encoding    = 'UTF-8' -- utf8 as standard encoding
opt.fileformats = {       -- line feed as standard line ending
   'unix',
   'dos',
   'mac',
}

-- timing {{{1

opt.updatetime  = 1000 -- inactivity delay of 1 second
opt.timeout     = true -- wait `timeoutlen` milliseconds before applying map
opt.timeoutlen  =  200 -- delay before keystroke timeout
opt.ttimeoutlen =   10 -- same but for terminal

-- windows and buffers {{{1

opt.hidden      = true   -- hide abandoned buffers but keep them around
opt.splitbelow  = true   -- split the new pane below the current one
opt.splitright  = true   -- split the new pane to the right
opt.eadirection = 'both' -- equal always option applies horizontally and vertically
  o.switchbuf   = 'useopen,uselast'

-- diff {{{1

-- use in vertical diff mode, blank lines to keep sides aligned, ignore
-- whitespace changes.

opt.diffopt = {
   'internal',
   'filler',
   'closeoff',
   'vertical',
   'iwhite',
   'hiddenoff',
   'foldcolumn:0',
   'context:16',
   'indent-heuristic',
   'algorithm:histogram',
}

-- format {{{1

opt.formatoptions = {
   ['1'] = true,
   ['2'] = true, -- use indent from second line of a paragraph

   q = true, -- continue comments with `gq`
   c = true, -- auto-wrap comments using `textwidth`
   r = true, -- continue comments when pressing `<CR>`
   n = true, -- recognize numbered lists
   t = false, -- autowrap lines using `textwidth`
   j = true, -- remove a comment leader when joining lines
   -- only break if the line was no longer than `textwidth` when the insert
   -- started and only at a white character that has been entered during the
   -- current insert command.
   l = true,
   v = true,
}

-- folds {{{1

opt.foldlevelstart = 3
opt.foldnestmax    = 3
opt.foldminlines   = 1
opt.foldmethod     = 'expr'
opt.foldexpr       = 'nvim_treesitter#foldexpr()'
opt.foldopen       = opt.foldopen + 'search'
opt.foldtext       = "getline(v:foldstart) . ' ... ' . trim(getline(v:foldend))"

-- grepping {{{1

-- use faster `grep` alternatives when possible.

if scheatkode.executable('rg') then
   o.grepprg      = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
   opt.grepformat = opt.grepformat ^ { '%f:%l:%c:%m' }
elseif scheatkode.executable('ag') then
   o.grepprg      = [[ag --nogroup --nocolor --vimgrep]]
   opt.grepformat = opt.grepformat ^ { '%f:%l:%c:%m' }
end

-- wild globs {{{1

opt.wildcharm      = fn.char2nr(scheatkode.replace_termcodes('<Tab>'))
opt.wildmode       = 'longest:full,full' -- show a menu bar as opposed to an enormous list
opt.wildignorecase = true                -- ignore case when completing file and directory names
opt.wildoptions    = 'pum'

opt.wildignore     = { -- mostly binaries
   '*.*~',        '*.aux',     '*.avi',  '*.class', '*.dll',     '*.gif',
   '*.ico',       '*.jar',     '*.jpeg', '*.jpg',   '*.o',       '*.obj',
   '*.out',       '*.png',     '*.pyc',  '*.rbc',   '*.swp',     '*.toc',
   '*.wav',       '*pycache*', '*~ ',    '*~',      '.DS_Store', '.lock',
   '__pycache__', 'tags.lock',
}

opt.completeopt = {
   'menuone',  -- use the pop-up menu
   -- 'longest',  -- only insert the longest common match
   'noinsert', -- do not insert any text for a match
   'noselect', -- do not autoselect a match
}

-- lines {{{1

opt.textwidth      =    78 -- maximum line width is 78
opt.relativenumber =  true -- use line numbers relative to the current line
opt.number         =  true -- ... but show the actual current line number
opt.linebreak      =  true -- lines wrap at words rather than random characters
opt.breakindentopt = 'sbr'
opt.showbreak      =   '↪'
opt.breakindent    =  true -- keep visual blocks indented when wrapping
opt.ruler          = false
opt.cursorline     = false -- cursorline is highlighted conditionally
opt.synmaxcol      =   200 -- don't syntax highlight long lines
opt.signcolumn     = has_06 and 'auto:1-2' or 'number'

-- whitespace, indentation, and wrapping {{{1

opt.list        =  true -- enable visual queues for invisible characters
opt.expandtab   =  true -- use spaces instead of tabs
opt.smarttab    =  true -- be smart when using tabs
opt.softtabstop =     3 -- remove 3 spaces when hitting backspace
opt.tabstop     =     3 -- 1 tab = 3 spaces
opt.shiftwidth  =     3 -- `>` inserts 3 spaces
opt.autoindent  =  true -- automatic indentation
opt.cindent     =  true -- c-style indentation
opt.smartindent =  true -- follow previous indentation level
opt.joinspaces  = false -- whoever thought this was a good idea ?
opt.wrap        = false -- don't wrap lines
opt.shiftround  =  true -- round indentation to multiple of `shiftwidth`

opt.fillchars = {
        vert = '▕',
        fold = ' ',
         eob = '~', -- keep showing me `~` at the end of the buffer
        diff = '░',
      msgsep = '‾',
    foldopen = '▾',
     foldsep = '│',
   foldclose = '▸',
}

opt.listchars = {
        eol = nil,
        tab = '│ ',
    extends = '›',
   precedes = '‹',
      trail = '•',
}

opt.backspace = { -- backspace acts as it should
   'eol',
   'start',
   'indent',
}

-- miscellaneous {{{1

opt.gdefault = false -- don't substitute all occurences by default
opt.confirm  =  true -- prompt to save before being destructive

opt.autowriteall = true -- automatically save files before running commands
opt.clipboard    = {
   'unnamedplus', -- unified clipboard, yay ~
}

opt.showmatch = true -- show matching brackets
opt.matchtime =    3 -- tenths of a second to blink when matching brackets

-- emoji {{{1

-- the emoji setting is true by default but makes (neo)vim treat all emoji
-- characters as double width which breaks rendering. this is turned off to
-- avoid said breakages.

opt.emoji = false

-- cursor {{{1

-- this is from the help docs, it enables mode shapes, "cursor" highlight, and
-- blinking.

opt.guicursor = {
   [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]],
   [[a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]],
   [[sm:block-blinkwait175-blinkoff150-blinkon175]],
}

if has_06 then
   opt.cursorlineopt = 'screenline,number'
end

-- utilities {{{1

opt.sessionoptions = {
   'globals',
   'buffers',
   'curdir',
   'help',
   'winpos',
}
opt.viewoptions = {
   'cursor',
   'folds'
}
opt.virtualedit = 'block' -- allow cursor to move freely in visual block mode

-- backups and undo {{{1

-- there's absolutely no need to use these options when saving regularly
-- and using version control.

opt.backup      = false
opt.writebackup = false

if not scheatkode.is_directory(o.undodir) then
   fn.mkdir(o.undodir, 'p')
end

opt.swapfile = false
opt.undofile = true

-- matching and searching {{{1

opt.hlsearch      =    true -- highlight search results
opt.ignorecase    =    true -- ignore case when searching
opt.smartcase     =    true -- .. unless there is a capital letter in the query
opt.incsearch     =    true -- search incrementally
opt.magic         =    true -- turn magic on for regular expressions
opt.regexpengine  =       0 -- set regexp engine to auto
opt.wrapscan      =    true -- searches wrap around the end of the file
opt.scrolloff     =      10 -- 10 lines to the cursor vertically
opt.sidescrolloff =      15 -- ... and 15 charactors horizontally
opt.sidescroll    =       1 -- minimal number of columns to scroll horizontally
opt.inccommand    = 'split' -- preview substitute results

-- spelling {{{1

opt.spellsuggest:prepend({ 12 }) -- max number of suggestions
opt.spelloptions  = 'camel'      -- assume camel case words as separate
opt.spellcapcheck = ''           -- don't check for capital letters beginning sentences
opt.langmenu      = 'en'         -- english as the default language
opt.fileformats   = {            -- line feed as standard line ending
   'unix',
   'mac',
   'dos'
}

-- mouse {{{1

opt.mouse      = '' -- mice are for the weak
opt.mousefocus = false

-- bells {{{1

-- no more annoying sounds on errors

opt.errorbells = false
opt.visualbell = false

-- vim: set fdm=marker fdl=0:

