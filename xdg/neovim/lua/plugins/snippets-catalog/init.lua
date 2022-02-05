return {'rafamadriz/friendly-snippets', opt = true,
   after  = 'luasnip',
   config = function ()
      require('luasnip.loaders.from_vscode').load()
   end
}
