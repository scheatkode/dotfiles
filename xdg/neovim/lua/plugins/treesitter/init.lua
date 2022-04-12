return { 'nvim-treesitter/nvim-treesitter', opt = true,
   as = 'treesitter',

   cmd = {
      'TSUpdate',
      'TSInstall',
   },

   event  = {
      'BufEnter',
   },

   requires = {
      {'nvim-treesitter/nvim-treesitter-textobjects'}, -- "smart" textobjects
      {'JoosepAlviste/nvim-ts-context-commentstring'},
   },

   run = ':TSUpdate',

   config = function ()
      require('plugins.treesitter.config')
   end,
}
