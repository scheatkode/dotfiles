return { -- delete buffer without messing up layout
   'ojroques/nvim-bufdel',

   opt = true,
   cmd = {
      'BufDel',
   },
   keys = {
      '<leader>bk',
      '<leader>bK'
   },

   config = function ()
      require('plugins.bufdel.config')
      require('plugins.bufdel.keys').setup()
   end,
}
