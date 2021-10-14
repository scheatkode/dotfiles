return {'simrat39/symbols-outline.nvim',
   cmd      = { 'SymbolsOutline'        },
   keys     = { '<leader>cls'           },
   wants    = { 'nvim-lspconfig'        },
   requires = { 'neovim/nvim-lspconfig' },
   config   = function ()
      require('plugins.symbols.config')
      require('plugins.symbols.keys')
      require('plugins.symbols.whichkey')
   end,
}
