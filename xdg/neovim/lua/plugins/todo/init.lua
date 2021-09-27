local has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register({
      ['<leader>ct'] = { 'Activate code todo' },
      ['<leader>st'] = { 'Activate code todo' },
   })
end

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
      require('plugins.todo.whichkey')
   end,
}
