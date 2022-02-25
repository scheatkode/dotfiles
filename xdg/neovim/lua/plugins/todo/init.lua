return {'folke/todo-comments.nvim', opt = true,
   cmd = {
      'TodoQuickFix',
      'TodoTrouble',
      'TodoTelescope',
   },
   keys = {
      '<leader>ct',
      '<leader>ctt',
      '<leader>st',
      '<leader>ctq',
      '<leader>ctd',
   },
   requires = { 'folke/lsp-trouble.nvim' },
   config = function ()
      require('plugins.todo.config')
      require('plugins.todo.keys')
   end,
}
