return { -- colorize hex/rgb/hsl values

   'norcalli/nvim-colorizer.lua',

   opt = true,
   ft  = {
      'html',
      'pug',

      'css',
      'sass',
      'scss',

      'lua',
   },

   config = function ()
      require('colorizer').setup()
   end
}
