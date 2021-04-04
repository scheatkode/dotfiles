-- treesitter-specific configuration
-- ensure plugins are loaded

vim.cmd [[packadd nvim-treesitter]]
vim.cmd [[packadd nvim-treesitter-textobjects]]

-- configure treesitter

require('nvim-treesitter.configs').setup {
   ensure_installed = 'maintained',

   autotag               = { enable = true },
   context_commentstring = { enable = true },
   highlight             = { enable = true },
   indent                = { enable = true },
   lsp_interop           = { enable = true },

   textobjects = {
      lsp_interop = {
         enable = true,
      },
      select = {
         enable  = true,
         keymaps = {
            ['ab'] = '@block.outer',
            ['ib'] = '@block.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
         },
      },
      swap = {
         enable    = true,
         swap_next = {
            ['<leader>cpa'] = '@parameter.inner',
         },
         swap_previous = {
            ['<leader>cpA'] = '@parameter.inner',
         },
      },
   },

   -- playground specific
   playground = {
      enable          = true,
      updatetime      = 25,    -- debounced time for highlighting nodes
      persist_queries = false, -- persistence across vim sessions
   },
}
