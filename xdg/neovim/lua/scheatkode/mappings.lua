--- TODO(scheatkode): Add soft navigation toggle

local function setup ()
   local tmux = require('scheatkode.tmux')
   local qf   = require('quickfix')

   --- shortcut for the current file's directory, better than
   --- manually typing `%:p:h` every time.

   vim.keymap.set('c', ',,e', '<C-r>=expand("%:p:h") . "/"<CR>', {nowait = true})

   --- Swap ` and ' for marks

   vim.keymap.set('n', "'", '`', {nowait = true})
   vim.keymap.set('n', "`", "'", {nowait = true})

   --- be consistent with the shell

   vim.keymap.set('i', '<M-d>', '<Esc>ldwi', {nowait = true})

   --- auto correct me please

   vim.keymap.set('i', '!+', '!=', {nowait = true, silent = true})
   vim.keymap.set('i', '_>', '->', {nowait = true, silent = true})
   vim.keymap.set('i', '+>', '=>', {nowait = true, silent = true})

   --- when modifier keys are redundant

   vim.keymap.set('i', ',-',  '<-',  {nowait = true, silent = true})
   vim.keymap.set('i', ';=',  ':=',  {nowait = true, silent = true})
   vim.keymap.set('i', ';;',  '::',  {nowait = true, silent = true})
   vim.keymap.set('i', ';//', '://', {nowait = true, silent = true})

   --- faster escaping

   vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
   vim.keymap.set({'i', 'v', 'c', 'o'}, 'jk', '<Esc>')
   vim.keymap.set({'i', 'v', 'c', 'o'}, '<C-c>', '<Esc>')

   --- visual 'shorthand'

   vim.keymap.set('n', 'vv',  'V',     {desc = 'visual line shorthand'})
   vim.keymap.set('n', 'vvv', '<C-v>', {desc = 'visual block shorthand'})

   --- macro

   -- disable autocommands when running macros for better
   -- performance.

   vim.keymap.set('n', '@', '<cmd>execute "noautocmd normal! " . v:count1 . "@" . getcharstr()<CR>')

   --- soft navigation

   -- vim.keymap.set({'n', 'x'}, 'j', 'gj')
   -- vim.keymap.set({'n', 'x'}, 'k', 'gk')
   -- vim.keymap.set({'n', 'x'}, '0', 'g0')
   -- vim.keymap.set({'n', 'x'}, '^', 'g^')
   -- vim.keymap.set({'n', 'x'}, '$', 'g$')

   --- better line navigation

   vim.keymap.set({'n', 'x', 'o'}, 'H', "col('.') == match(getline('.'), '\\S')+1 ? '0' : '^'", {expr = true})
   vim.keymap.set({'n', 'x', 'o'}, 'L', '$')

   --- don't lose selection when indenting or outdenting
   -- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards

   vim.keymap.set('x', '<', '<gv')
   vim.keymap.set('x', '>', '>gv')

   --- saner behavior of n and N (search forward and backward,
   --- respectively)
   -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n

   vim.keymap.set('', '<Plug>(search-forward)',  "'Nn'[v:searchforward]", {expr = true})
   vim.keymap.set('', '<Plug>(search-backward)', "'nN'[v:searchforward]", {expr = true})

   vim.keymap.set({'n', 'x', 'o'}, 'n', '<Plug>(search-forward)zzzv')
   vim.keymap.set({'n', 'x', 'o'}, 'N', '<Plug>(search-backward)zzzv')

   --- saner behavior of ; and , (search character forward and
   --- backward, respectively)

   vim.keymap.set('', '<Plug>(user-character-search-forward)',  "getcharsearch().forward ? ';':','", {expr = true})
   vim.keymap.set('', '<Plug>(user-character-search-backward)', "getcharsearch().forward ? ',':';'", {expr = true})

   vim.keymap.set({'n', 'x', 'o'}, ':', '<Plug>(user-character-search-forward)')
   vim.keymap.set({'n', 'x', 'o'}, ',', '<Plug>(user-character-search-backward)')

   --- ; is faster than : to run commands

   vim.keymap.set({'n', 'x'}, ';', ':', {nowait = true})

   --- saner behavior of J

   vim.keymap.set('n', 'J', 'mzJ\'z')

   --- remove search highlighting

   vim.keymap.set('n', '<Esc>', '<cmd>let @/=""<CR>', {remap = true, silent = true})

   --- saner undo break points

   vim.keymap.set('i', ',', ',<C-g>u')
   vim.keymap.set('i', '!', '!<C-g>u')
   vim.keymap.set('i', '?', '?<C-g>u')

   --- jumplist triggers

   vim.keymap.set('n', 'k', '(v:count1 > 5 ? "m\'" . v:count : "") . "k"', {expr = true})
   vim.keymap.set('n', 'j', '(v:count1 > 5 ? "m\'" . v:count : "") . "j"', {expr = true})

   --- insert-mode quick navigation

   vim.keymap.set('i', '<M-h>', '<Left>')
   vim.keymap.set('i', '<M-l>', '<Right>')

   --- insert-mode quick screen centering

   vim.keymap.set('i', '<M-z><M-z>', '<C-o>zz')

   --- quick and convenient text movement that doesn't mess with
   --- registers.

   vim.keymap.set('n', '<C-j>', '<cmd>execute "move .+" .  v:count1      . " <bar> normal! =="<CR>')
   vim.keymap.set('n', '<C-k>', '<cmd>execute "move .-" . (v:count1 + 1) . " <bar> normal! =="<CR>')

   vim.keymap.set('i', '<M-j>', '<cmd>move .+1 <bar> normal! ==<CR>')
   vim.keymap.set('i', '<M-k>', '<cmd>move .-2 <bar> normal! ==<CR>')

   vim.keymap.set('x', '<C-j>', ':move \'>+1<CR>gv=gv')
   vim.keymap.set('x', '<C-k>', ':move \'<-2<CR>gv=gv')

   --- making mappings more consistent for command-mode

   vim.keymap.set('c', '<C-k>', '<Up>',   {nowait = true})
   vim.keymap.set('c', '<C-j>', '<Down>', {nowait = true})

   --- fast window and buffer movement

   vim.keymap.set('n', '<Tab>', '<C-^>', {desc = 'Switch to alternate file'})

   vim.keymap.set('n', '<M-h>', tmux.jump('h'), {nowait = true, desc = 'Go to the pane on the left'})
   vim.keymap.set('n', '<M-l>', tmux.jump('l'), {nowait = true, desc = 'Go to the pane on the right'})
   vim.keymap.set('n', '<M-j>', tmux.jump('j'), {nowait = true, desc = 'Go to the pane below'})
   vim.keymap.set('n', '<M-k>', tmux.jump('k'), {nowait = true, desc = 'Go to the pane above'})

   --- fast window resizing, optimized for dvorak

   vim.keymap.set('n', '<M-->', '<cmd>wincmd -<CR>')
   vim.keymap.set('n', '<M-=>', '<cmd>wincmd +<CR>')
   vim.keymap.set('n', '<M-.>', '<cmd>wincmd ><CR>')
   vim.keymap.set('n', '<M-,>', '<cmd>wincmd <<CR>')

   --- window deletion

   vim.keymap.set('n', '<leader>wq', '<cmd>wincmd q<CR>', {desc = 'Close/Quit window'})

   --- buffer operations

   vim.keymap.set('n', '<leader>bn', '<cmd>bnext<CR>',     {desc = 'Next buffer'})
   vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<CR>', {desc = 'Previous buffer'})
   vim.keymap.set('n', '<leader>bl', '<cmd>buffers<CR>',   {desc = 'List buffers'})
   vim.keymap.set('n', '<leader>bL', '<cmd>buffers!<CR>',  {desc = 'List all buffers'})
   vim.keymap.set('n', '<leader>bN', '<cmd>enew<CR>',      {desc = 'New empty buffer'})
   vim.keymap.set('n', '<leader>bw', '<cmd>bwipeout!<CR>', {desc = 'Wipe buffer'})
   vim.keymap.set('n', '<leader>bq', '<cmd>bunload<CR>',   {desc = 'Quit/Close buffer'})
   vim.keymap.set('n', '<leader>br', '<cmd>e<CR>',         {desc = 'Reload buffer'})
   vim.keymap.set('n', '<leader>bR', '<cmd>e!<CR>',        {desc = 'Reload buffer forcefully'})

   --- tab operations

   vim.keymap.set('n', '<leader>TL', '<cmd>tabs<CR>',        {desc = 'List tabs'})
   vim.keymap.set('n', '<leader>TN', '<cmd>tabnew<CR>',      {desc = 'New tab'})
   vim.keymap.set('n', '<leader>Tn', '<cmd>tabnext<CR>',     {desc = 'Next tab'})
   vim.keymap.set('n', '<leader>Tp', '<cmd>tabprevious<CR>', {desc = 'Prevous tab'})
   vim.keymap.set('n', '<leader>Tq', '<cmd>tabclose<CR>',    {desc = 'Quit/Close tab'})

   --- shame on you

   vim.keymap.set('n', '<leader>qq', '<cmd>quitall<CR>',  {desc = 'Quit Neovim'})
   vim.keymap.set('n', '<leader>qQ', '<cmd>quitall!<CR>', {desc = 'Quit Neovim forcefully'})

   --- qf operations

   vim.keymap.set('n', '<leader>qf', qf.setup(),       {desc = 'Toggle quickfix list'})
   vim.keymap.set('n', '<leader>qo', '<cmd>copen<CR>', {desc = 'Open quickfix list'})
end

return {
   setup = setup
}
