return {'windwp/nvim-autopairs', opt = true,
   event    = { 'InsertEnter'        },
   -- wants    = { 'nvim-compe'         },
   -- requires = { 'hrsh7th/nvim-compe' },
   wants    = { 'nvim-cmp'         },
   requires = { 'hrsh7th/nvim-cmp' },
   config   = function ()
      require('plugins.pairs.config')
      -- require('plugins.pairs.keys')
   end,
}
