require('lib.config').keymaps.use({

   --- semicolon is never used in normal mode anyway, win a keystroke

   {'n', ';', ':', {noremap = true}},
   {'x', ';', ':', {noremap = true}},

   --- remove annoying ex-mode

   {'n', 'Q',  '<nop>', {noremap = true}},
   {'n', 'q:', '<nop>', {noremap = true}},

   --- better yank behaviour, more consistent with 'D'

   {'n', 'Y', 'y$', {noremap = true}},

   --- easier vertical navigation

   {'n', 'j', 'gj', {silent = true, noremap = true}},
   {'x', 'j', 'gj', {silent = true, noremap = true}},
   {'n', 'k', 'gk', {silent = true, noremap = true}},
   {'x', 'k', 'gk', {silent = true, noremap = true}},

   --- don't lose selection when indenting or outdenting
   -- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards

   {'x', '<', '<gv', {silent = true, noremap = true}},
   {'x', '>', '>gv', {silent = true, noremap = true}},

   --- saner behavior of n and N (search forward and backward, respectively)
   -- https://github.com/mhinz/vim-galore#go-to-other-end-of-selected-text

   {'n', 'n', "'Nn'[v:searchforward]", {noremap = true, expr = true}},
   {'x', 'n', "'Nn'[v:searchforward]", {noremap = true, expr = true}},
   {'o', 'n', "'Nn'[v:searchforward]", {noremap = true, expr = true}},

   {'n', 'N', "'nN'[v:searchforward]", {noremap = true, expr = true}},
   {'x', 'N', "'nN'[v:searchforward]", {noremap = true, expr = true}},
   {'o', 'N', "'nN'[v:searchforward]", {noremap = true, expr = true}},

   --- remove annoying persistent search highlighting

   {'n', '<esc>', ':let @/=""<cr>', {silent = true}},

   --- insert-mode quick navigation

   {'i', '<m-k>', '<up>',    {noremap = true}},
   {'i', '<m-j>', '<down>',  {noremap = true}},
   {'i', '<m-h>', '<left>',  {noremap = true}},
   {'i', '<m-l>', '<right>', {noremap = true}},

   --- insert-mode quick screen centering

   {'i', '<c-z><c-z>', '<c-o>zz', {noremap = true}},

   --- making mappings more consistent for command-mode

   -- <c-k>      - show previous command
   -- <c-j>      - show next command
   -- <c-r><c-r> - fuzzy search history

   {'c', '<c-k>', '<up>',   {noremap = true}},
   {'c', '<c-j>', '<down>', {noremap = true}},

   --- pane navigation with leader-key prefix

   -- <leader>ww - move to next pane
   -- <leader>wk - move to upper pane
   -- <leader>wj - move to lower pane
   -- <leader>wh - move to left pane
   -- <leader>wl - move to right pane
   -- <leader>wv - split pane vertically   → create pane to the right
   -- <leader>ws - split pane horizontally → create pane below

   {'n', '<leader>ww', '<c-w><c-w>',   {silent = true, noremap = true}},
   {'n', '<leader>wk', '<c-w><up>',    {silent = true, noremap = true}},
   {'n', '<leader>wj', '<c-w><down>',  {silent = true, noremap = true}},
   {'n', '<leader>wh', '<c-w><left>',  {silent = true, noremap = true}},
   {'n', '<leader>wl', '<c-w><right>', {silent = true, noremap = true}},
   {'n', '<leader>wv', '<c-w>v',       {silent = true, noremap = true}},
   {'n', '<leader>ws', '<c-w>s',       {silent = true, noremap = true}},

   --- pane resizing with leader-key prefix

   -- <leader>w+ - increase height
   -- <leader>w- - decrease height
   -- <leader>w< - resize width
   -- <leader>w> - resize width

   {'n', '<leader>w+', '<c-w>+',       {silent = true, noremap = true}},
   {'n', '<leader>w-', '<c-w>-',       {silent = true, noremap = true}},
   {'n', '<leader>w<', '<c-w><',       {silent = true, noremap = true}},
   {'n', '<leader>w>', '<c-w>>',       {silent = true, noremap = true}},

   --- file operations

   -- <leader>fs - save current file
   -- <leader>fS - save current file as ...
   -- <leader>ft - open tree file explorer
   -- <leader>ff - browse files in the current directory
   -- <leader>fF - fuzzy search files in current directory
   -- <leader>fr - fuzzy search mru files
   -- <leader>fg - live fuzzy search in files in current directory

   {'n', '<leader>fs', ':w<CR>', {silent = true, noremap = true}},
   {'n', '<leader>fS', ':w ',    {silent = true, noremap = true}},

   -- {'n', '<leader>ft', ':NvimTreeToggle<CR>', {silent = true, noremap = true}},
   -- {'n', '<leader>ff', '<cmd>Telescope find_files<CR>',   {silent = true, noremap = true}},
   -- {'n', '<leader>fF', '<cmd>Telescope file_browser<CR>', {silent = true, noremap = true}},
   -- {'n', '<leader>fr', '<cmd>Telescope oldfiles<CR>',     {silent = true, noremap = true}},
   -- {'n', '<leader>fg', '<cmd>Telescope live_grep<CR>',    {silent = true, noremap = true}},

   --- search operations

   -- <leader>sl - fuzzy search lines in the current buffer
   -- <leader>sr - fuzzy search registers
   -- <leader>sq - fuzzy search quickfix
   -- <leader>sm - fuzzy search man pages
   -- <leader>sh - search help tags

   -- {'n', '<leader>sh', '<cmd>Telescope help_tags                 theme=get_dropdown<CR>', {silent = true, noremap = true}},
   -- {'n', '<leader>sl', '<cmd>Telescope current_buffer_fuzzy_find theme=get_dropdown<CR>', {silent = true, noremap = true}},
   -- {'n', '<leader>sr', '<cmd>Telescope registers                 theme=get_dropdown<CR>', {silent = true, noremap = true}},
   -- {'n', '<leader>sq', '<cmd>Telescope quickfix                  theme=get_dropdown<CR>', {silent = true, noremap = true}},
   -- {'n', '<leader>sm', '<cmd>Telescope man_pages                 theme=get_dropdown<CR>', {silent = true, noremap = true}},

   --- buffer operations

   -- <leader>bb - fuzzy search buffers
   -- <tab>      - quick jump to next buffer
   -- <s-tab>    - quick jump to previous buffer
   -- <leader>bn - next buffer
   -- <leader>bp - previous buffer
   -- <leader>bl - list buffers
   -- <leader>bL - list all buffers
   -- <leader>bN - new empty buffer
   -- <leader>bk - kill current buffer
   -- <leader>bK - kill all buffers → TODO
   -- <leader>bw - force kill current buffer, losing changes
   -- <leader>bq - quit current buffer
   -- <leader>bz - kill (free) orphaned buffers
   -- <leader>bZ - kill (free) orphaned buffers forcefully
   -- <leader>br - reload current buffer from file
   -- <leader>bR - force reload current buffer from file, losing changes

   {'n', '<tab>',      '<cmd>bnext<cr>',     {silent = true, noremap = true}},
   {'n', '<s-tab>',    '<cmd>bprevious<cr>', {silent = true, noremap = true}},
   {'n', '<leader>bn', '<cmd>bnext<CR>',     {silent = true, noremap = true}},
   {'n', '<leader>bp', '<cmd>bprevious<CR>', {silent = true, noremap = true}},
   {'n', '<leader>bl', '<cmd>buffers<CR>',   {silent = true, noremap = true}},
   {'n', '<leader>bL', '<cmd>buffers!<CR>',  {silent = true, noremap = true}},
   {'n', '<leader>bN', '<cmd>enew<CR>',      {silent = true, noremap = true}},
   {'n', '<leader>bk', '<cmd>bwipeout<CR>',  {silent = true, noremap = true}},
   {'n', '<leader>bk', '<cmd>bwipeout<CR>',  {silent = true, noremap = true}},
   {'n', '<leader>bw', '<cmd>bwipeout!<CR>', {silent = true, noremap = true}},
   {'n', '<leader>bq', '<cmd>bunload<CR>',   {silent = true, noremap = true}},
   {'n', '<leader>br', '<cmd>e<CR>',         {silent = true, noremap = true}},
   {'n', '<leader>bR', '<cmd>e!<CR>',        {silent = true, noremap = true}},

   {'n', '<leader>bz',
      '<cmd>lua require("lib").vim.buffers.close_orphaned()<CR>',
      {silent = true, noremap = true}
   },
   {'n', '<leader>bZ',
      '<cmd>lua require("lib").vim.buffers.close_orphaned(true)<CR>',
      {silent = true, noremap = true}
   },

   -- {'n', '<leader>bb', '<cmd>Telescope buffers<CR>', {silent = true, noremap = true}},

   --- closing operations

   -- <leader>qq - quit neovim
   -- <leader>qQ - forcefully quit neovim

   {'n', '<leader>qq', '<cmd>qall<CR>',  {silent = true, noremap = true}},
   {'n', '<leader>qQ', '<cmd>qall!<CR>', {silent = true, noremap = true}},

   --- package manager operations

   -- <leader>pc - compile package list
   -- <leader>pC - clean packages directory
   -- <leader>pi - install packages
   -- <leader>pu - update packages
   -- <leader>ps - synchronize packages

   -- {'n', '<leader>pc', '<cmd>PackerCompile<CR>', {silent = true, noremap = true}},
   -- {'n', '<leader>pC', '<cmd>PackerClean<CR>',   {silent = true, noremap = true}},
   -- {'n', '<leader>pi', '<cmd>PackerInstall<CR>', {silent = true, noremap = true}},
   -- {'n', '<leader>pu', '<cmd>PackerUpdate<CR>',  {silent = true, noremap = true}},
   -- {'n', '<leader>ps', '<cmd>PackerSync<CR>',    {silent = true, noremap = true}},

   --- alignment operations

   -- <leader>ta - text align

   -- {'n', '<leader>ta', '<Plug>(EasyAlign)', {}},
   -- {'x', '<leader>ta', '<Plug>(EasyAlign)', {}},

   --- surrounding operations

   -- <leader>tsd - delete surrounding character
   -- <leader>tsc - change surrounding character
   -- <leader>tsi - interactive changing
   -- <leader>tsv - visual modification

   -- {'n', '<leader>tsd',  '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)',  {}},
   -- {'n', '<leader>tsdd', '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)',   {}},
   -- {'n', '<leader>tsc',  '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)', {}},
   -- {'n', '<leader>tsc',  '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)',  {}},

   -- {'n', '<leader>tsa', '<Plug>(operator-sandwich-add)', {}},
   -- {'x', '<leader>tsa', '<Plug>(operator-sandwich-add)', {}},

   --- text object definition

   -- {'x', 'is', '<Plug>(textobj-sandwich-query-i)', {}},
   -- {'x', 'as', '<Plug>(textobj-sandwich-query-a)', {}},
   -- {'o', 'is', '<Plug>(textobj-sandwich-query-i)', {}},
   -- {'o', 'as', '<Plug>(textobj-sandwich-query-a)', {}},

   -- text object to select nearest surrounded text automatically

   -- {'x', 'iss', '<Plug>(textobj-sandwich-auto-i)', {}},
   -- {'x', 'ass', '<Plug>(textobj-sandwich-auto-a)', {}},
   -- {'o', 'iss', '<Plug>(textobj-sandwich-auto-i)', {}},
   -- {'o', 'ass', '<Plug>(textobj-sandwich-auto-a)', {}},

   -- text objects to select a text surronded by user input character

   -- {'x', 'im', '<Plug>(textobj-sandwich-literal-query-i)', {}},
   -- {'x', 'am', '<Plug>(textobj-sandwich-literal-query-a)', {}},
   -- {'o', 'im', '<Plug>(textobj-sandwich-literal-query-i)', {}},
   -- {'o', 'am', '<Plug>(textobj-sandwich-literal-query-a)', {}},

   --- lsp operations

   -- <leader>lr   - fuzzy search references
   -- <leader>lsd  - fuzzy search symbols in document
   -- <leader>lsw  - fuzzy search symbols in workspace
   -- <leader>lca  - fuzzy search code actions
   -- <leader>lrca - fuzzy search range code actions
   -- <leader>lts  - fuzzy search treesitter symbols

   -- {'n', '<leader>lr',   '<cmd>Telescope lsp_references         theme=get_dropdown<CR>', {silent = true, noremap = true}},
   -- {'n', '<leader>lsd',  '<cmd>Telescope lsp_document_symbols   theme=get_dropdown<CR>', {silent = true, noremap = true}},
   -- {'n', '<leader>lsw',  '<cmd>Telescope lsp_workspace_symbols  theme=get_dropdown<CR>', {silent = true, noremap = true}},
   -- {'n', '<leader>lca',  '<cmd>Telescope lsp_code_actions       theme=get_dropdown<CR>', {silent = true, noremap = true}},
   -- {'n', '<leader>lrca', '<cmd>Telescope lsp_range_code_actions theme=get_dropdown<CR>', {silent = true, noremap = true}},
   -- {'n', '<leader>lts',  '<cmd>Telescope treesitter                theme=get_dropdown<CR>', {silent = true, noremap = true}},

})

-- vim: set sw=3 ts=3 sts=3 et tw=80 fmr={{{,}}} fdl=0 fdm=marker:
