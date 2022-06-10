return {'machakann/vim-sandwich', opt = true,

   keys = {
      { 'n', '<leader>sa'  },
      { 'n', '<leader>sc'  },
      { 'n', '<leader>sd'  },
      { 'n', '<leader>sC'  },
      { 'n', '<leader>sD'  },
      { 'v', '<leader>sa'  },

      { 'n', '<leader>ts'  },
      { 'n', '<leader>tsa' },
      { 'n', '<leader>tsc' },
      { 'n', '<leader>tsC' },
      { 'n', '<leader>tsd' },
      { 'n', '<leader>tsD' },
      { 'v', '<leader>ts'  },
      { 'v', '<leader>tsa' },
   },

   setup  = function ()
      vim.g.sandwich_no_default_key_mappings = 1
   end,

   config = function ()
      require('plugins.surround.keys').setup()
   end,

}
