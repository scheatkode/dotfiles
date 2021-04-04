local apply   = require('lib.config').options.use
local options = {

   -- miscellaneous

   history    = 1000,  -- number of commands to remember
   compatible = false, -- incompatible with legacy vi implementations
   hidden     = true,  -- hide abandoned buffers but keep them around
   lazyredraw = true,  -- don't redraw when executing macros
   showmatch  = true,  -- show matching brackets
   mat        = 2,     -- tenths of a second to blink when matching brackets
   pumheight  = 10,    -- limit completion items
   re         = 0,     -- set regexp engine to auto
   mouse      = 'n',   -- mice are for the weak
   synmaxcol  = 300,   -- limit for syntax highlighting in a single line

   clipboard     = 'unnamedplus', -- unified clipboard, yay ~
   termguicolors = true,          -- true colors for better visuals

   formatoptions = 'c' -- wrap comments but not text ('t')
      .. 'r'           -- automatically insert current leader on enter
      .. 'o'           -- automatically insert comment leader on 'o' or 'O'
      .. 'q'           -- comments, too, are formatted with 'gq'
      .. 'j',          -- remove comment leader when joining lines

   backspace = { -- backspace acts as it should
      'eol',
      'start',
      'indent',
   },

   -- file detection

   autoread  = true, -- detect external file modifications
   autowrite = true, -- auto write buffer when not focused

   -- encoding

   bomb        = false,   -- don't prepend bom byte
   encoding    = 'UTF-8', -- utf8 as standard encoding
   fileformats = {        -- line feed as standard line ending
      'unix',
      'dos',
      'mac',
   },

   -- searching

   ignorecase = true,    -- ignore case when searching
   smartcase  = true,    -- .. unless there is a capital letter in the query
   hlsearch   = true,    -- highlight search results
   incsearch  = true,    -- search incrementally
   magic      = true,    -- turn magic on for regular expressions
   inccommand = 'split', -- preview substitute results

   -- whitespaces & wrapping

   -- fillchars = { eob = '~' }, -- TODO: implement is_array()
   expandtab   = true,  -- use spaces instead of tabs
   smarttab    = true,  -- be smart when using tabs
   softtabstop = 3,     -- remove 3 spaces when hitting backspace
   tabstop     = 3,     -- 1 tab = 3 spaces
   shiftwidth  = 3,     -- > inserts 3 spaces
   autoindent  = true,  -- automatic indentation
   cindent     = true,  -- c-style indentation
   smartindent = true,  -- follow previous indentation level
   joinspaces  = false, -- whoever thought this was a good idea ?
   wrap        = false, -- don't wrap lines
   listchars   = {
      'tab:▸ ◂',    -- visual queue for tabs
      'trail:◂',    -- visual queue for trailing whitespaces
      'precedes:←', -- visual queue when not wrapping
      'extends:→',  -- same
      'nbsp:·',     -- visual queue for non-breakable spaces
   },

   -- files, backup, and undo

   -- there's absolutely no need to use these options when saving regularly
   -- and using version control.

   backup      = false, -- don't use backup files
   swapfile    = false, -- don't use swap files
   writebackup = false, -- don't write backup files

   -- locale

   -- let $LANG='en' -- default language
   langmenu = 'en',

   -- delays

   updatetime = 1000, -- inactivity delay of 1 second
   timeoutlen = 1000, -- delay before keystroke timeout

   -- scrolling

   scrolloff     = 7,  -- 7 lines to the cursor vertically
   sidescrolloff = 10, -- 10 characters horizontally

   -- splitting

   -- splitting behavior becomes more natural

   splitright = true, -- split the new pane to the right
   splitbelow = true, -- split the new pane below the current one

   -- folding

   --foldcolumn = 1, -- add a bit of extra margin to the left
   foldmethod = 'syntax', -- fold language objects (class, function, etc.)
   foldlevel  = 1,        -- fold on the second level

   -- status and command lines

   laststatus = 2,     -- always enable the status line
   cmdheight  = 1,     -- height of the command bar
   showmode   = false, -- disable showing modes below the status line
   showcmd    = false, -- disable showing keystrokes, it gets annoying
   shortmess  = 's' -- ignore 'search hit BOTTOM' kind of messages
      .. 't'        -- truncate long messages
      .. 'I'        -- no need for vim's intro message
      .. 'c'        -- don't give 'ins-completion-menu' messages
      .. 'q',       -- i know what macro i'm recording, thank you

   -- lines

   textwidth      = 80,   -- maximum line width is 78
   relativenumber = true, -- use line numbers relative to the current line
   number         = true, -- .. but show the actual current line number
   cursorline     = true, -- highlight current line

   -- signs and autocompletion

   signcolumn  = 'yes', -- always show the sign column, flicker is annoying
   wildmenu    = true,  -- enable autocomplete menu
   wildoptions = 'pum', -- use the pop-up menu cmdline-completion
   wildignore  = { -- ignore compiled files
      '__pycache__',
      '*.o',
      '*~',
      '*.pyc',
      '*pycache*',
   },
   wildmode = { -- completion mode settings
      'longest', -- complete till longest common string
      'list',    -- when more than one match, list all matches
      'full',    -- complete the next full match
   },
   completeopt = { -- better completion experience
      'menuone',  -- use the pop-up menu
      'longest',  -- only insert the longest common match
      'noinsert', -- do not insert any text for a match
      'noselect', -- do not autoselect a match
   },

   -- bells

   -- no more annoying sounds on errors

   errorbells = false,
   visualbell = false,
   t_vb       = '',

}

return apply(options)

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:

-- vim: set sw=3 ts=3 sts=3 et tw=78 fmr={{{,}}} fdl=0 fdm=marker:
