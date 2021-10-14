return {'nelsyeung/twig.vim', opt = true,
   ft     = { 'twig' },
   config = function ()
      require('log').info('Plugin loaded', 'twig-syntax')
   end,
}
