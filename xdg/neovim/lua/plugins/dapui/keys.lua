return require('util').register_keymaps {
   {
      mode        = 'n',
      keys        = '<leader>cdv',
      command     = require('dapui').toggle,
      description = 'Toggle visuals',
   },

   -- {
   --    mode        = 'n',
   --    keys        = '<leader>cdk',
   --    command     = require('dapui').close,
   --    description = 'Close visuals',
   -- },

   {
      mode        = 'n',
      keys        = '<leader>cde',
      command     = require('dapui').eval,
      description = 'Evaluate',
   },

   {
      mode        = 'v',
      keys        = '<leader>cde',
      command     = require('dapui').eval,
      description = 'Evaluate',
   },
}
