return {'nvim-telescope/telescope.nvim', opt = true,
   cmd = {
      'Telescope'
   },

   module_pattern = {
      'telescope.*'
   },

   keys = {
      '<leader>bb',
      '<leader>clr',
      '<leader>cld',
      '<leader>clw',
      '<leader>clc',
      '<leader>fF',
      '<leader>FF',
      '<leader><leader>',
      '<leader>ff',
      '<leader>Ff',
      '<leader>fr',
      '<leader>Fr',
      '<leader>fg',
      '<leader>Fg',
      '<leader>nf',
      '<leader>nF',
      '<leader>pp',
      '<leader>sh',
      '<leader>sl',
      '<leader>sr',
      '<leader>sq',
      '<leader>sm',
      '<leader>st',
   },

   requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-project.nvim'},   -- project picker
      {'nvim-telescope/telescope-fzf-native.nvim', -- better sorter
         run = 'make'
      },
      {'nvim-telescope/telescope-frecency.nvim',   -- frequency sorter
         requires = {'tami5/sqlite.lua'}
      },
   },

   wants = {
      'popup.nvim',
      'plenary',
      'telescope-frecency.nvim',
      'telescope-project.nvim',
      'telescope-fzf-native.nvim',
   },

   config = function ()
      require('plugins.telescope.config')
      require('plugins.telescope.keys')
      require('plugins.telescope.whichkey')
   end,
}
