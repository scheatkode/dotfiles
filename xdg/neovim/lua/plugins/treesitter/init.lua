return { 'nvim-treesitter/nvim-treesitter', opt = true,
   as = 'treesitter',

   branch = '0.5-compat',

   cmd = {
      'TSUpdate',
      'TSInstall',
   },

   event  = {
      'VimEnter',
   },

   requires = {
      -- {'nvim-treesitter/nvim-tree-docs', after = 'nvim-treesitter'}, -- documentation generator
      {'nvim-treesitter/playground'},     -- playground for treesitter
      {'nvim-treesitter/nvim-treesitter-textobjects'}, -- "smart" textobjects
      -- {'romgrk/nvim-treesitter-context'},              -- keep current context visible
      {'JoosepAlviste/nvim-ts-context-commentstring'},
   },

   run = '<cmd>TSUpdate<CR>',

   config = function ()
      require('plugins.treesitter.config')
      require('plugins.treesitter.whichkey')
   end,
}
