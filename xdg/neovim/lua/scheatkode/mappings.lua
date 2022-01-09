--- TODO(scheatkode): Add dissection function for packer
--- TODO(scheatkode): Add dissection function for whichkey
--- TODO(scheatkode): Add soft navigation toggle

local function convert_mapping(mapping)
   local mode, keys, command, description, options = unpack(mapping)

   return {
      mode        = mode,
      keys        = keys,
      command     = command,
      description = description,
      options     = options,
   }
end

local function convert_mappings(mappings)
   local converted_table = {}

   for _, mapping in ipairs(mappings) do
      table.insert(converted_table, convert_mapping(mapping))
   end

   return converted_table
end

require('util').register_keymaps(convert_mappings({

   --- TODO(scheatkode): Move this somewhere else
   --- shortcut for the current file's directory, better than manually typing
   --- `%:p:h` every time.

   {'c', ',,e', '<C-r>=expand("%:p:h") . "/"<CR>', 'which_key_ignore', { nowait = true, silent = false }},

   --- TODO(scheatkode): Move this somewhere else
   --- TODO(scheatkode): Better documentation
   --- Swap ` and ' for marks

   {'n', "'", '`', 'which_key_ignore', { nowait = true, silent = false }},
   {'n', '`', "'", 'which_key_ignore', { nowait = true, silent = false }},

   --- be consistent with the shell

   {'i', '<M-d>', '<Esc>ldwi', 'which_key_ignore', { nowait = true, silent = true }},

   --- auto correct me please

   --- TODO(scheatkode): kinda
   --- TODO(scheatkode): look for another trigger

   -- {'n', ';;', '<Esc>A;<Esc>', 'which_key_ignore', { nowait = true, silent = false }},

   -- {'i', '_>',   '->',   'which_key_ignore', { nowait = true, silent = false }},
   -- {'i', '_.',   '->',   'which_key_ignore', { nowait = true, silent = false }},
   -- {'i', '-.',   '->',   'which_key_ignore', { nowait = true, silent = false }},
   -- {'i', '+>',   '=>',   'which_key_ignore', { nowait = true, silent = false }},
   -- {'i', '+.',   '=>',   'which_key_ignore', { nowait = true, silent = false }},
   -- {'i', '=.',   '=>',   'which_key_ignore', { nowait = true, silent = false }},

   --- when there is no need for modifier keys

   {'i', ';;', '::', 'which_key_ignore', { nowait = true, silent = true }},

   --- remove annoying ex-mode

   {'n', 'Q',  '<NOP>', 'which_key_ignore'},
   {'n', 'q:', '<NOP>', 'which_key_ignore'},

   --- make 'Y' behaviour more consistent with 'D'

   {'n', 'Y', 'y$', 'which_key_ignore'},

   --- faster escaping

   {'t', '<Esc>', '<C-\\><C-n>', 'which_key_ignore'},
   {'i', 'jk',    '<Esc>',       'which_key_ignore'},
   {'i', 'kj',    '<Esc>',       'which_key_ignore'},
   {'c', 'jk',    '<Esc>',       'which_key_ignore'},
   {'c', 'kj',    '<Esc>',       'which_key_ignore'},
   {'t', 'jk',    '<Esc>',       'which_key_ignore'},
   {'t', 'kj',    '<Esc>',       'which_key_ignore'},
   {'o', 'jk',    '<Esc>',       'which_key_ignore'},
   {'o', 'kj',    '<Esc>',       'which_key_ignore'},

   --- visual line 'shorthand'

   {'n', 'vv', 'V', 'which_key_ignore'},

   --- soft navigation

   -- {'n', 'j', 'gj', modifiers},
   -- {'x', 'j', 'gj', modifiers},
   -- {'n', 'k', 'gk', modifiers},
   -- {'x', 'k', 'gk', modifiers},
   -- {'n', '0', 'g0', modifiers},
   -- {'x', '0', 'g0', modifiers},
   -- {'n', '^', 'g^', modifiers},
   -- {'x', '^', 'g^', modifiers},
   -- {'n', '$', 'g$', modifiers},
   -- {'x', '$', 'g$', modifiers},

    --- better line navigation
    --- TODO(scheatkode): clean this up
    --- INFO(scheatkode): lookup `smart home`

    {'n', 'H', "col('.') == match(getline('.'), '\\S')+1 ? '0' : '^'", 'which_key_ignore', {expr = true}},
    {'x', 'H', "col('.') == match(getline('.'), '\\S')+1 ? '0' : '^'", 'which_key_ignore', {expr = true}},
    {'o', 'H', "col('.') == match(getline('.'), '\\S')+1 ? '0' : '^'", 'which_key_ignore', {expr = true}},

    {'n', 'L', '$', 'which_key_ignore'},
    {'x', 'L', '$', 'which_key_ignore'},
    {'o', 'L', '$', 'which_key_ignore'},

   --- don't lose selection when indenting or outdenting
   -- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards

   {'x', '<', '<gv', 'which_key_ignore'},
   {'x', '>', '>gv', 'which_key_ignore'},

   --- saner behavior of n and N (search forward and backward, respectively)
   -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n

   {'', '<SID>(search-forward)',  "'Nn'[v:searchforward]", 'which_key_ignore', { expr = true }},
   {'', '<SID>(search-backward)', "'nN'[v:searchforward]", 'which_key_ignore', { expr = true }},

   {'n', 'n', '<SID>(search-forward)zzzv', 'which_key_ignore', { noremap = false }},
   {'x', 'n', '<SID>(search-forward)zzzv', 'which_key_ignore', { noremap = false }},
   {'o', 'n', '<SID>(search-forward)zzzv', 'which_key_ignore', { noremap = false }},

   {'n', 'N', '<SID>(search-backward)zzzv', 'which_key_ignore', { noremap = false }},
   {'x', 'N', '<SID>(search-backward)zzzv', 'which_key_ignore', { noremap = false }},
   {'o', 'N', '<SID>(search-backward)zzzv', 'which_key_ignore', { noremap = false }},

   --- saner behavior of ; and , (search character forward and backward, respectively)

   --- TODO(scheatkode): Move this somewhere else
   --- TODO(scheatkode): Better documentation
   --- swap : and ; for command and character movement

   {'n', ';', ':', 'which_key_ignore', { nowait = true, silent = false }},
   {'x', ';', ':', 'which_key_ignore', { nowait = true, silent = false }},

   {'', '<SID>(character-search-forward)',  "getcharsearch().forward ? ';':','", 'which_key_ignore', { expr = true }},
   {'', '<SID>(character-search-backward)', "getcharsearch().forward ? ',':';'", 'which_key_ignore', { expr = true }},

   {'n', ':', '<SID>(character-search-forward)', 'which_key_ignore', { noremap = false }},
   {'x', ':', '<SID>(character-search-forward)', 'which_key_ignore', { noremap = false }},
   {'o', ':', '<SID>(character-search-forward)', 'which_key_ignore', { noremap = false }},

   {'n', ',', '<SID>(character-search-backward)', 'which_key_ignore', { noremap = false }},
   {'x', ',', '<SID>(character-search-backward)', 'which_key_ignore', { noremap = false }},
   {'o', ',', '<SID>(character-search-backward)', 'which_key_ignore', { noremap = false }},

   --- saner behavior of J

   {'n', 'J', 'mzJ\'z', 'which_key_ignore'},

   --- remove annoying persistent search highlighting
   --- TODO(scheatkode): See if we can make this a conditional mapping.
   ---                   Not handling `v:count` is annoying here.
   ---                   At least make it fail silently.

   {'n', '<Esc>', ':let @/=""<CR>', 'which_key_ignore', {noremap = false}},

   --- quick escape from quickfix
   --- TODO(scheatkode): Remove this.

   {'n', '<Esc>', '&buftype==#"quickfix" ? "<cmd>cclose<CR>" : "<cmd>nohl<CR>"', 'which_key_ignore', { noremap = false, expr = true, nowait = true }},
   {'n', 'q',     '&buftype==#"quickfix" ? "<cmd>cclose<CR>" : "q"', 'which_key_ignore', { noremap = false, expr = true, nowait = true }},

   --- saner undo break points

   {'i', ',', ',<C-g>u', 'which_key_ignore'},
   -- {'i', '.', '.<C-g>u', 'which_key_ignore'},
   {'i', '!', '!<C-g>u', 'which_key_ignore'},
   {'i', '?', '?<C-g>u', 'which_key_ignore'},

   --- saner jumplist triggers

   {'n', 'k', '(v:count1 > 5 ? "m\'" . v:count : "") . "k"', 'which_key_ignore', { expr = true }},
   {'n', 'j', '(v:count1 > 5 ? "m\'" . v:count : "") . "j"', 'which_key_ignore', { expr = true }},

   --- insert-mode quick navigation

   -- {'i', '<M-k>', '<Up>',    'which_key_ignore'},
   -- {'i', '<M-j>', '<Down>',  'which_key_ignore'},
   {'i', '<M-h>', '<Left>',  'which_key_ignore'},
   {'i', '<M-l>', '<Right>', 'which_key_ignore'},

   --- insert-mode quick screen centering

   {'i', '<M-z><M-z>', '<C-o>zz', 'which_key_ignore'},


   --- quick and convenient text movement, doesn't fuck up with registers.
   --- TODO(scheatkode): better documentation.

   {'n', '<C-j>', '<cmd>execute "move .+" .  v:count1      . " <bar> normal! =="<CR>', 'which_key_ignore'},
   {'n', '<C-k>', '<cmd>execute "move .-" . (v:count1 + 1) . " <bar> normal! =="<CR>', 'which_key_ignore'},

   {'i', '<M-j>', '<cmd>move .+1 <bar> normal! ==<CR>', 'which_key_ignore'},
   {'i', '<M-k>', '<cmd>move .-2 <bar> normal! ==<CR>', 'which_key_ignore'},

   {'x', '<C-j>', ':move \'>+1<CR>gv=gv', 'which_key_ignore'},
   {'x', '<C-k>', ':move \'<-2<CR>gv=gv', 'which_key_ignore'},

   --- making mappings more consistent for command-mode

   {'c', '<C-k>', '<Up>',   'which_key_ignore', { nowait = true, silent = false }},
   {'c', '<C-j>', '<Down>', 'which_key_ignore', { nowait = true, silent = false }},

   --- fast window movement

   {'n', '<M-h>', '<cmd>wincmd h<CR>', 'which_key_ignore'},
   {'n', '<M-l>', '<cmd>wincmd l<CR>', 'which_key_ignore'},
   {'n', '<M-j>', '<cmd>wincmd j<CR>', 'which_key_ignore'},
   {'n', '<M-k>', '<cmd>wincmd k<CR>', 'which_key_ignore'},

   --- fast window resizing, optimized for dvorak

   {'n', '<M-->', '<cmd>wincmd -<CR>', 'which_key_ignore'},
   {'n', '<M-=>', '<cmd>wincmd +<CR>', 'which_key_ignore'},
   {'n', '<M-.>', '<cmd>wincmd ><CR>', 'which_key_ignore'},
   {'n', '<M-,>', '<cmd>wincmd <<CR>', 'which_key_ignore'},

   --- window navigation with leader-key prefix

   {'n', '<leader>ww', '<cmd>wincmd w<CR>', 'Go to window next'},
   {'n', '<leader>wk', '<cmd>wincmd k<CR>', 'Go to window above'},
   {'n', '<leader>wj', '<cmd>wincmd j<CR>', 'Go to window below'},
   {'n', '<leader>wh', '<cmd>wincmd h<CR>', 'Go to window left'},
   {'n', '<leader>wl', '<cmd>wincmd l<CR>', 'Go to window right'},

   --- pane splitting

   {'n', '<leader>wv', '<cmd>wincmd v<CR>', 'Split window vertically'},
   {'n', '<leader>ws', '<cmd>wincmd s<CR>', 'Split window horizontally'},

   --- window rotating

   {'n', '<leader>wRb', '<cmd>wincmd r<CR>', 'Rotate windows down/right'},
   {'n', '<leader>wRu', '<cmd>wincmd R<CR>', 'Rotate windows up/left'},

   --- window resizing with leader-key prefix

   {'n', '<leader>w+', '<cmd>wincmd +<CR>', 'Balance windows'},
   {'n', '<leader>w-', '<cmd>wincmd -<CR>', 'Increase window height'},
   {'n', '<leader>w<', '<cmd>wincmd <<CR>', 'Decrease window height'},
   {'n', '<leader>w>', '<cmd>wincmd ><CR>', 'Increase window width'},
   {'n', '<leader>w=', '<cmd>wincmd =<CR>', 'Decrease window width'},

   --- window movement

   {'n', '<leader>wmx', '<cmd>wincmd x<CR>', 'Exchange windows'},
   {'n', '<leader>wmh', '<cmd>wincmd h<CR>', 'Move window left'},
   {'n', '<leader>wmj', '<cmd>wincmd j<CR>', 'Move window below'},
   {'n', '<leader>wmk', '<cmd>wincmd k<CR>', 'Move window above'},
   {'n', '<leader>wml', '<cmd>wincmd l<CR>', 'Move window right'},

   --- window deletion

   {'n', '<leader>wq', '<cmd>wincmd q<CR>', 'Close/Quit window'},

   --- file operations

   -- {'n', '<leader>fs', '<cmd>w<CR>', 'Save file'},
   -- {'n', '<leader>fS', ':w ',        'Save file as', { silent = false }},

   --- buffer operations

   {'n', '<leader>bn', '<cmd>bnext<CR>',     'Next buffer'},
   {'n', '<leader>bp', '<cmd>bprevious<CR>', 'Previous buffer'},
   {'n', '<leader>bl', '<cmd>buffers<CR>',   'List buffers'},
   {'n', '<leader>bL', '<cmd>buffers!<CR>',  'List all buffers'},
   {'n', '<leader>bN', '<cmd>enew<CR>',      'New empty buffer'},
   {'n', '<leader>bw', '<cmd>bwipeout!<CR>', 'Wipe buffer'},
   {'n', '<leader>bq', '<cmd>bunload<CR>',   'Quit/Close buffer'},
   {'n', '<leader>br', '<cmd>e<CR>',         'Reload buffer'},
   {'n', '<leader>bR', '<cmd>e!<CR>',        'Reload buffer forcefully'},

   --- tab operations

   -- {'n', '<leader>tf', '<cmd>tabfirst<CR>',    'First tab'},
   -- {'n', '<leader>tl', '<cmd>tablast<CR>',     'Last tab'},
   {'n', '<leader>TL', '<cmd>tabs<CR>',        'List tabs'},
   {'n', '<leader>TN', '<cmd>tabnew<CR>',      'New tab'},
   {'n', '<leader>Tn', '<cmd>tabnext<CR>',     'Next tab'},
   {'n', '<leader>Tp', '<cmd>tabprevious<CR>', 'Prevous tab'},
   {'n', '<leader>Tq', '<cmd>tabclose<CR>',    'Quit/Close tab'},

   --- closing operations

   {'n', '<leader>qq', '<cmd>quitall<CR>',  'Quit Neovim'},
   {'n', '<leader>qQ', '<cmd>quitall!<CR>', 'Quit Neovim forcefully'},

   --- toggle operations

   -- {'n', '<leader>Ts', '<cmd>set scrollbind!<CR>', 'Toggle scroll bind'},
}))

--- whichkey setup

local has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register({
      b = {
         name = '+buffers',

         k = {'Kill buffer'},
         K = {'Kill buffer forcefully'},
         l = {'List buffers'},
         L = {'List all buffers'},
         n = {'Next buffer'},
         p = {'Previous buffer'},
         N = {'New buffer'},
         r = {'Reload buffer'},
         R = {'Reload buffer forcefully'},
         u = {'Unload buffer'},
      },

      f = {
         name = '+files',

         s = {'Save file'},
         S = {'Save file as'},
      },

      q = {
         name = '+quit',

         q = {'Quit Neovim'},
         Q = {'Force quit Neovim'},
      },

      t = {
         name = '+text'
      },

      T = {
         name = '+tab',

         -- f = {'First tab'},
         -- l = {'Last tab'},
         L = {'List tabs'},
         N = {'New tab'},
         n = {'Next tab'},
         p = {'Prevous tab'},
         q = {'Delete tab'},
      },

      -- T = {
      --    name = '+toggle',

      --    s = {'Scroll bind toggle'},
      -- },

      w = {
         name = '+windows',

         h = {'Go to window left'},
         j = {'Go to window below'},
         k = {'Go to window above'},
         l = {'Go to window right'},

         m = {
            name = '+move',

            x = {'Exchange windows'},
            h = {'Move window left'},
            j = {'Move window below'},
            k = {'Move window above'},
            l = {'Move window right'},
         },

         r = {
            name = '+resize',

            ['='] = {'Balance windows'},
            ['+'] = {'Increase window height'},
            ['-'] = {'Decrease window height'},
            ['>'] = {'Increase window width'},
            ['<'] = {'Decrease window width'},
         },

         R = {
            name = '+rotate',

            b = {'Rotate down/right'},
            u = {'Rotate up/left'},
         },

         q = {'Delete window'},
         s = {'Split horizontally'},
         v = {'Split vertically'},
      },
   }, {
      prefix = '<leader>'
   })

   whichkey.register({
      ['q:'] = 'which_key_ignore',
       ['Q'] = 'which_key_ignore',
      ['jk'] = 'which_key_ignore',
      ['kj'] = 'which_key_ignore',
      ['_>'] = 'which_key_ignore',
      ['_.'] = 'which_key_ignore',
      ['-.'] = 'which_key_ignore',
      ['+>'] = 'which_key_ignore',
      ['+.'] = 'which_key_ignore',
      ['=.'] = 'which_key_ignore',
      [';;'] = 'which_key_ignore',
      ['vv'] = 'which_key_ignore',
   })
end
