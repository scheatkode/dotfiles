return {'folke/which-key.nvim', opt = true,
   disable = true,

   config = function ()
      require('plugins.whichkey.config')
   end,
}
