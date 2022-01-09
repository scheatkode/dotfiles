return require('util').register_keymaps({
   {
      mode        = 'n',
      keys        = '<leader>cltw',
      command     = '<cmd>TroubleToggle workspace_diagnostics<CR>',
      description = 'Show trouble in workspace'
   },

   {
      mode        = 'n',
      keys        = '<leader>cltd',
      command     = '<cmd>TroubleToggle document_diagnostics<CR>',
      description = 'Show trouble in document'
   },

   {
      mode        = 'n',
      keys        = '<leader>cltq',
      command     = '<cmd>TroubleToggle quickfix<CR>',
      description = 'Show trouble in quickfix'
   },

   {
      mode        = 'n',
      keys        = '<leader>cltl',
      command     = '<cmd>TroubleToggle loclist<CR>',
      description = 'Show trouble in loclist'
   },

   {
      mode        = 'n',
      keys        = '<leader>cltr',
      command     = '<cmd>TroubleToggle lsp_references<CR>',
      description = 'Show references'
   },
})
