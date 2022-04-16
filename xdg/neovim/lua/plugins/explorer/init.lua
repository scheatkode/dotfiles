return {'kyazdani42/nvim-tree.lua', opt = true,
   cmd = {
      'NvimTreeToggle',
      'NvimTreeOpen',
      'NvimTreeClose',
      'NvimTreeFindFile',
   },

   keys = {
      '<F1>',
   },

   wants    = { 'nvim-web-devicons'            },
   requires = { 'kyazdani42/nvim-web-devicons' },

   config = function ()
      require('plugins.explorer.config')
      require('plugins.explorer.keys').setup()
   end,
}
