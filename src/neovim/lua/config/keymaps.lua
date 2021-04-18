local modifiers = {
   silent  = true,
   noremap = true
}

require('lib.config').keymaps.use({

   --- remove annoying ex-mode

   {'n', 'Q',  '<NOP>', modifiers},
   {'n', 'q:', '<NOP>', modifiers},

   --- make 'Y' behaviour more consistent with 'D'

   {'n', 'Y', 'y$', modifiers},

   --- soft navigation by default

   {'n', 'j', 'gj', modifiers},
   {'x', 'j', 'gj', modifiers},
   {'n', 'k', 'gk', modifiers},
   {'x', 'k', 'gk', modifiers},
   {'n', '0', 'g0', modifiers},
   {'x', '0', 'g0', modifiers},
   {'n', '^', 'g^', modifiers},
   {'x', '^', 'g^', modifiers},
   {'n', '$', 'g$', modifiers},
   {'x', '$', 'g$', modifiers},

   --- don't lose selection when indenting or outdenting
   -- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards

   {'x', '<', '<gv', modifiers},
   {'x', '>', '>gv', modifiers},

   --- saner behavior of n and N (search forward and backward, respectively)
   -- https://github.com/mhinz/vim-galore#go-to-other-end-of-selected-text

   {'n', 'n', "'Nn'[v:searchforward]", modifiers},
   {'x', 'n', "'Nn'[v:searchforward]", modifiers},
   {'o', 'n', "'Nn'[v:searchforward]", modifiers},

   {'n', 'N', "'nN'[v:searchforward]", modifiers},
   {'x', 'N', "'nN'[v:searchforward]", modifiers},
   {'o', 'N', "'nN'[v:searchforward]", modifiers},

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

   {'n', '<tab>',      '<cmd>bnext<CR>',     modifiers},
   {'n', '<s-tab>',    '<cmd>bprevious<CR>', modifiers},
   {'n', '<leader>bn', '<cmd>bnext<CR>',     modifiers},
   {'n', '<leader>bp', '<cmd>bprevious<CR>', modifiers},
   {'n', '<leader>bl', '<cmd>buffers<CR>',   modifiers},
   {'n', '<leader>bL', '<cmd>buffers!<CR>',  modifiers},
   {'n', '<leader>bN', '<cmd>enew<CR>',      modifiers},
   {'n', '<leader>bk', '<cmd>bwipeout<CR>',  modifiers},
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

   --- closing operations

   {'n', '<leader>qq', '<cmd>quitall<CR>',  modifiers},
   {'n', '<leader>qQ', '<cmd>quitall!<CR>', modifiers},
})

--- whichkey setup

local ok, whichkey = pcall(require, 'whichkey_setup')

if ok then
   whichkey.register_keymap('leader', {
      b = {
         name = '+buffers',

         k = 'Kill buffer',
         K = 'Kill buffer forcefully',
         l = 'List buffers',
         L = 'List all buffers',
         n = 'Next buffer',
         p = 'Previous buffer',
         N = 'New buffer',
         r = 'Reload buffer',
         R = 'Reload buffer forcefully',
         u = 'Unload buffer',
      },

      f = {
         name = '+files',

         s = 'Save file',
         S = 'Save file as',
      },

      q = {
         name = '+quit',

         q    = 'Quit Neovim',
         Q    = 'Force quit Neovim',
      },

      w = {
         name = '+windows',

         h = 'Go to window left',
         j = 'Go to window below',
         k = 'Go to window above',
         l = 'Go to window right',

         r = {
            name = '+resize',

            ['='] = 'Balance windows',
            ['+'] = 'Increase window height',
            ['-'] = 'Decrease window height',
            ['>'] = 'Increase window width',
            ['<'] = 'Decrease window width',
         },

         R = {
            name = '+rotate',

            b = 'Rotate down/right',
            u = 'Rotate up/left',
         },

         m = {
            name = '+move',

            x = 'Exchange windows',
            h = 'Move window left',
            j = 'Move window below',
            k = 'Move window above',
            l = 'Move window right',
         },

         q = 'Delete window',
         s = 'Split horizontally',
         v = 'Split vertically',
      },
   })
end

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80
