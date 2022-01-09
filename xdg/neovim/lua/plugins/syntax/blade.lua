return {'jwalton512/vim-blade', opt = true,
   ft     = { 'blade' },
   config = function ()
      require('log').info('Plugin loaded', 'blade-syntax')
   end,
}
