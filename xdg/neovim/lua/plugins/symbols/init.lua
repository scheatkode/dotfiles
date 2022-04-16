return {'simrat39/symbols-outline.nvim',

   cmd      = { 'SymbolsOutline'        },
   keys     = { '<leader>co'            },

   wants    = { 'nvim-lspconfig'        },
   requires = { 'neovim/nvim-lspconfig' },

   config   = function ()
      require('plugins.symbols.config')
      require('plugins.symbols.keys').setup()
   end,
}
