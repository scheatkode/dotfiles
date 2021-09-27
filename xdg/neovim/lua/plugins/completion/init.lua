-- return {'hrsh7th/nvim-compe', opt = true,
return {'hrsh7th/nvim-cmp', -- opt = true,
   event = { 'InsertEnter' },
   wants = {
      'nvim-lspconfig',
      'luasnip',
   },

   requires = {
      'neovim/nvim-lspconfig',
      {'L3MON4D3/LuaSnip',            as = 'luasnip'},
      {'hrsh7th/cmp-buffer',       after = 'nvim-cmp'},
      {'hrsh7th/cmp-path',         after = 'nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp',     after = 'nvim-cmp'},
      {'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp', wants = 'luasnip'},
   },

   config = function ()
      require('plugins.completion.config')
      -- require('plugins.completion.keys')
   end,
}
