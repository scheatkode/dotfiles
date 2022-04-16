return {
   'danymat/neogen',

   opt = true,

   tag = '*',

   keys = {
      '<leader>cn',
   },

   cmd = {
      'Neogen',
   },

   config = function ()
      require('plugins.annotation.config')
      require('plugins.annotation.keys').setup()
   end
}
