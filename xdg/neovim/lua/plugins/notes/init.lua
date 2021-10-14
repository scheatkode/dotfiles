return {'nvim-neorg/neorg', opt = true,
   ft = 'norg',
   requires = {
      'nvim-lua/plenary.nvim',
   },
   wants = {
      'plenary',
   },
   config = function ()
      require('plugins.notes.config')
   end,
}
