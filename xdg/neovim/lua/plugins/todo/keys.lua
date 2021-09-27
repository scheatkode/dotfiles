return require('util').register_keymaps {
   {
      mode        = 'n',
      keys        = '<leader>ctq',
      command     = '<cmd>TodoQuickFix<CR>',
      description = 'Show todos in quickfix window',
   },

   {
      mode        = 'n',
      keys        = '<leader>ctd',
      command     = '<cmd>TodoTrouble<CR>',
      description = 'Show todos in diagnostics buffer',
   },

   {
      mode        = 'n',
      keys        = '<leader>ctt',
      command     = '<cmd>TodoTelescope<CR>',
      description = 'Show todos in Telescope',
   },

   {
      mode        = 'n',
      keys        = '<leader>st',
      command     = '<cmd>TodoTelescope<CR>',
      description = 'Search todos',
   },
}
