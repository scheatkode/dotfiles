return {'digitaltoad/vim-pug', opt = true,
   ft     = { 'pug' },
   config = function ()
      require('log').info('Plugin loaded', 'pug-syntax')
   end,
}
