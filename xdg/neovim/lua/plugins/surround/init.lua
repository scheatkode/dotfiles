return {'machakann/vim-sandwich', opt = true,

   keys = {
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
      require('plugins.surround.keys')
   end,

}
