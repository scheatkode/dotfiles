return { 'scrooloose/vim-slumlord', opt = true,
   ft       = { 'plantuml' },
   wants    = { 'plantuml-syntax' },
   requires = { 'aklt/plantuml-syntax' },
   config = function ()
      require('log').info('Plugin loaded', 'plantuml-syntax')
   end
}
