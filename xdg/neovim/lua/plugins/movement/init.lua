return {'ggandor/lightspeed.nvim', opt = true,
   keys = {
      's',
      'S',
      'f',
      'F',
      't',
      'T',
   },

   config = function ()
      require('plugins.movement.config')
   end
}
