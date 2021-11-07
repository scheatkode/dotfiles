return require('util').register_keymaps {
   {
      mode        = 'n',
      keys        = '<leader>dv',
      command     = require('dapui').toggle,
      description = 'Toggle visuals',
   },

   {
      mode        = 'n',
      keys        = '<leader>de',
      command     = require('dapui').eval,
      description = 'Evaluate',
   },

   {
      mode        = 'v',
      keys        = '<leader>de',
      command     = require('dapui').eval,
      description = 'Evaluate',
   },
}
