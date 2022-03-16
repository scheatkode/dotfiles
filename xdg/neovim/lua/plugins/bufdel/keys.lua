return require('util').register_keymaps {
   {
      mode        = 'n',
      keys        = '<leader>bk',
      command     = '<cmd>BufDel<CR>',
      description = 'Delete current buffer, keeping layout',
   },

   {
      mode        = 'n',
      keys        = '<leader>bK',
      command     = '<cmd>BufDel!<CR>',
      description = 'Force delete current buffer, keeping layout',
   },
}
