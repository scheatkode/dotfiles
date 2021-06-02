local modifiers = {
   silent  = true,
   noremap = true
}

require('sol.vim').apply_keymaps({

   --- auto correct me please

   {'i', '_>',   '->',   modifiers},
   {'i', '+>',   '=>',   modifiers},
   {'i', 'htis', 'this', modifiers},

   --- when there is no need for modifier keys

   {'i', ';;',   '::',   modifiers},

   --- remove annoying ex-mode

   {'n', 'Q',  '<NOP>', modifiers},
   {'n', 'q:', '<NOP>', modifiers},

   --- make 'Y' behaviour more consistent with 'D'

   {'n', 'Y', 'y$', modifiers},

   --- faster escaping

   {'t', '<Esc>', '<C-\\><C-n>', modifiers},
   {'i', 'jk',    '<Esc>',       modifiers},
   {'i', 'kj',    '<Esc>',       modifiers},
   {'c', 'jk',    '<Esc>',       modifiers},
   {'c', 'kj',    '<Esc>',       modifiers},
   {'t', 'jk',    '<Esc>',       modifiers},
   {'t', 'kj',    '<Esc>',       modifiers},
   {'o', 'jk',    '<Esc>',       modifiers},
   {'o', 'kj',    '<Esc>',       modifiers},

   --- soft navigation by default

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

   --- don't lose selection when indenting or outdenting
   -- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards

   {'x', '<', '<gv', modifiers},
   {'x', '>', '>gv', modifiers},

   --- saner behavior of n and N (search forward and backward, respectively)
   -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n

   {'n', 'n', "'Nn'[v:searchforward]", {expr = true}},
   {'x', 'n', "'Nn'[v:searchforward]", {expr = true}},
   {'o', 'n', "'Nn'[v:searchforward]", {expr = true}},

   {'n', 'N', "'nN'[v:searchforward]", {expr = true}},
   {'x', 'N', "'nN'[v:searchforward]", {expr = true}},
   {'o', 'N', "'nN'[v:searchforward]", {expr = true}},

   --- saner behavior of ; and , (search character forward and backward, respectively)

   {'n', ';', "getcharsearch().forward ? ';':','", {expr = true, noremap = true}},
   {'x', ';', "getcharsearch().forward ? ';':','", {expr = true, noremap = true}},
   {'o', ';', "getcharsearch().forward ? ';':','", {expr = true, noremap = true}},

   {'n', ',', "getcharsearch().forward ? ',':';'", {expr = true, noremap = true}},
   {'x', ',', "getcharsearch().forward ? ',':';'", {expr = true, noremap = true}},
   {'o', ',', "getcharsearch().forward ? ',':';'", {expr = true, noremap = true}},

   --- remove annoying persistent search highlighting

   {'n', '<Esc>', ':let @/=""<CR>', {silent = true}},

   --- insert-mode quick navigation

   {'i', '<M-k>', '<Up>',    modifiers},
   {'i', '<M-j>', '<Down>',  modifiers},
   {'i', '<M-h>', '<Left>',  modifiers},
   {'i', '<M-l>', '<Right>', modifiers},

   --- insert-mode quick screen centering

   {'i', '<C-z><C-z>', '<C-o>zz', modifiers},

   --- making mappings more consistent for command-mode

   {'c', '<C-k>', '<Up>',   {}},
   {'c', '<C-j>', '<Down>', {}},

   --- window navigation with leader-key prefix

   {'n', '<leader>ww', '<cmd>wincmd w<CR>', modifiers},
   {'n', '<leader>wk', '<cmd>wincmd k<CR>', modifiers},
   {'n', '<leader>wj', '<cmd>wincmd j<CR>', modifiers},
   {'n', '<leader>wh', '<cmd>wincmd h<CR>', modifiers},
   {'n', '<leader>wl', '<cmd>wincmd l<CR>', modifiers},

   --- pane splitting

   {'n', '<leader>wv', '<cmd>wincmd v<CR>', modifiers},
   {'n', '<leader>ws', '<cmd>wincmd s<CR>', modifiers},

   --- window resizing

   {'n', '<leader>wr=', '<cmd>wincmd =<CR>', modifiers},
   {'n', '<leader>wr+', '<cmd>wincmd +<CR>', modifiers},
   {'n', '<leader>wr-', '<cmd>wincmd -<CR>', modifiers},
   {'n', '<leader>wr>', '<cmd>wincmd ><CR>', modifiers},
   {'n', '<leader>wr<', '<cmd>wincmd <<CR>', modifiers},

   --- window rotating

   {'n', '<leader>wRb', '<cmd>wincmd r<CR>', modifiers},
   {'n', '<leader>wRu', '<cmd>wincmd R<CR>', modifiers},

   --- window resizing with leader-key prefix

   {'n', '<leader>w+', '<cmd>wincmd +<CR>', modifiers},
   {'n', '<leader>w-', '<cmd>wincmd -<CR>', modifiers},
   {'n', '<leader>w<', '<cmd>wincmd <<CR>', modifiers},
   {'n', '<leader>w>', '<cmd>wincmd ><CR>', modifiers},
   {'n', '<leader>w=', '<cmd>wincmd =<CR>', modifiers},

   --- window movement

   {'n', '<leader>wmx', '<cmd>wincmd x<CR>', modifiers},
   {'n', '<leader>wmh', '<cmd>wincmd h<CR>', modifiers},
   {'n', '<leader>wmj', '<cmd>wincmd j<CR>', modifiers},
   {'n', '<leader>wmk', '<cmd>wincmd k<CR>', modifiers},
   {'n', '<leader>wml', '<cmd>wincmd l<CR>', modifiers},

   --- window deletion

   {'n', '<leader>wq', '<cmd>wincmd q<CR>', modifiers},

   --- file operations

   {'n', '<leader>fs', '<cmd>w<CR>', modifiers},
   {'n', '<leader>fS', ':w ',   {noremap = true}},

   --- buffer operations

   {'n', '<Tab>',      '<cmd>bnext<CR>',     modifiers},
   {'n', '<S-Tab>',    '<cmd>bprevious<CR>', modifiers},
   {'n', '<leader>bn', '<cmd>bnext<CR>',     modifiers},
   {'n', '<leader>bp', '<cmd>bprevious<CR>', modifiers},
   {'n', '<leader>bl', '<cmd>buffers<CR>',   modifiers},
   {'n', '<leader>bL', '<cmd>buffers!<CR>',  modifiers},
   {'n', '<leader>bN', '<cmd>enew<CR>',      modifiers},
   -- {'n', '<leader>bk', '<cmd>bwipeout<CR>',  modifiers},
   {'n', '<leader>bw', '<cmd>bwipeout!<CR>', modifiers},
   {'n', '<leader>bq', '<cmd>bunload<CR>',   modifiers},
   {'n', '<leader>br', '<cmd>e<CR>',         modifiers},
   {'n', '<leader>bR', '<cmd>e!<CR>',        modifiers},

   {'n', '<leader>bz',
      '<cmd>lua require("lib").vim.buffers.close_orphaned()<CR>',
      modifiers
   },
   {'n', '<leader>bZ',
      '<cmd>lua require("lib").vim.buffers.close_orphaned(true)<CR>',
      modifiers
   },

   --- tab operations

   {'n', '<leader>tf', '<cmd>tabfirst<CR>',    modifiers},
   {'n', '<leader>tl', '<cmd>tablast<CR>',     modifiers},
   {'n', '<leader>tL', '<cmd>tabs<CR>',        modifiers},
   {'n', '<leader>tN', '<cmd>tabnew<CR>',      modifiers},
   {'n', '<leader>tn', '<cmd>tabnext<CR>',     modifiers},
   {'n', '<leader>tp', '<cmd>tabprevious<CR>', modifiers},
   {'n', '<leader>tq', '<cmd>tabclose<CR>',    modifiers},

   --- closing operations

   {'n', '<leader>qq', '<cmd>quitall<CR>',  modifiers},
   {'n', '<leader>qQ', '<cmd>quitall!<CR>', modifiers},

   --- toggle operations

   {'n', '<leader>Ts', '<cmd>set scrollbind!<CR>', modifiers},
})

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
         name = '+tab',

         f = {'First tab'},
         l = {'Last tab'},
         L = {'List tabs'},
         N = {'New tab'},
         n = {'Next tab'},
         p = {'Prevous tab'},
         q = {'Delete tab'},
      },

      T = {
         name = '+toggle',

         s = {'Scroll bind toggle'},
      },

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
      ['q:']   = 'which_key_ignore',
      ['Q']    = 'which_key_ignore',
   })

end

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
