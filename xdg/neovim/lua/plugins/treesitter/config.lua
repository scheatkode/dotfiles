-- configure treesitter {{{1

local has_treesitter, treesitter = pcall(require, 'nvim-treesitter.configs')

if not has_treesitter then
   print('‼ Tried loading treesitter ... unsuccessfully.')
   return has_treesitter
end

-- additional parsers {{{1

local treesitter_configs = require('nvim-treesitter.parsers').get_parser_configs()

treesitter_configs.norg = {
   install_info = {
         url = 'https://github.com/vhyrro/tree-sitter-norg',
       files = { 'src/parser.c', 'src/scanner.cc' },
      branch = 'main'
   }
}

-- setup {{{1

treesitter.setup({
   ensure_installed = 'maintained',

   autopairs             = { enable = true },
   autotag               = { enable = true },
   context_commentstring = { enable = true },
   highlight             = { enable = true },
   indent                = { enable = true },
   lsp_interop           = { enable = true },

   incremental_selection = {
      enable = true,

      keymaps = {
         init_selection    = '<leader>v',
         node_incremental  = '+',
         scope_incremental = 'R',
         node_decremental  = '-',
      }
   },

   tree_docs = {
      enable  = true,
      keymaps = {
         doc_all_in_range   = '<leader>cgd',
         doc_node_at_cursor = '<leader>cgd',
      },
   },

   textobjects = {
      lookahead = true,

      lsp_interop = {
         enable = true,
         border = 'single',

         peek_definition_code = {
            ['<leader>cpf'] = '@function.outer',
            ['<leader>cpc'] = '@class.outer',
         },
      },

      move = {
         enable    = true,
         set_jumps = true,

         goto_next_start = {
            [']f'] = '@function.inner',
            [']c'] = '@class.outer',
            [']b'] = '@block.outer',
            [']C'] = '@comment.outer',
            [']i'] = '@conditional.outer',
            [']l'] = '@loop.outer',
         },

         goto_next_end = {

         },

         goto_previous_start = {
            ['[f'] = '@function.inner',
            ['[c'] = '@class.outer',
            ['[b'] = '@block.outer',
            ['[C'] = '@comment.outer',
            ['[i'] = '@conditional.outer',
            ['[l'] = '@loop.outer',
         },

         goto_previous_end = {

         },
      },

      select = {
         enable  = true,

         keymaps = {
            ['ab'] = '@block.outer',
            ['ib'] = '@block.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['aC'] = '@comment.outer',
            ['iC'] = '@comment.inner',
            ['ai'] = '@conditional.outer',
            ['ii'] = '@conditional.inner',
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',
            ['aP'] = '@parameter.outer',
            ['iP'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
         },
      },

      swap = {
         enable    = true,

         swap_next = {
            ['<leader>cps'] = '@parameter.inner',
         },

         swap_previous = {
            ['<leader>cpS'] = '@parameter.inner',
         },
      },
   },

})

-- whichkey setup {{{1

local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return has_whichkey
end

whichkey.register({
   ['<leader>c'] = {
      name = '+code',

      g = {
         name = '+generate',

         d = 'Generate documentation',
      },

      p = {
         name = '+parameter',

         s = {'Swap next parameter'},
         S = {'Swap previous parameter'},
      },
   }
})

-- vim: set ft=lua fdm=marker fdl=0:
