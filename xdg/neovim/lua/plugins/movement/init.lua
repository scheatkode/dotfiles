return {'ggandor/lightspeed.nvim', opt = true,
   keys = {
      's',
      'S',
      'f',
      'F',
      't',
      'T',
   },

   commit = '4d8359a30b26ee5316d0e7c79af08b10cb17a57b',

   config = function ()
      require('plugins.movement.config')
   end
}
