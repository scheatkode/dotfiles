return {'L3MON4D3/LuaSnip', opt = true,
   as     = 'luasnip',
   module = 'luasnip',

   requires = {
      {'rafamadriz/friendly-snippets', opt = true,
         after = 'luasnip',
         config = function ()
            require('luasnip.loaders.from_vscode').load()
         end
      },
   },
}
