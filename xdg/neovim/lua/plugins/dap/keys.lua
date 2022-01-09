local input = vim.fn.input
local dap   = require('dap')

return require('util').register_keymaps {
   {
      mode        = 'n',
      keys        = '<leader>dc',
      command     = dap.continue,
      description = 'Continue',
   },

   {
      mode        = 'n',
      keys        = '<leader>dC',
      command     = dap.run_to_cursor,
      description = 'Run to cursor',
   },

   {
      mode        = 'n',
      keys        = '<leader>db',
      command     = dap.toggle_breakpoint,
      description = 'Toggle breakpoint',
   },

   {
      mode        = 'n',
      keys        = '<leader>di',
      command     = dap.step_into,
      description = 'Step into',
   },

   {
      mode        = 'n',
      keys        = '<leader>do',
      command     = dap.step_over,
      description = 'Step over',
   },

   {
      mode        = 'n',
      keys        = '<leader>dO',
      command     = dap.step_out,
      description = 'Step out',
   },

   {
      mode        = 'n',
      keys        = '<leader>dp',
      command     = dap.step_back,
      description = 'Step back',
   },

   {
      mode        = 'n',
      keys        = '<leader>dP',
      command     = dap.pause,
      description = 'Pause',
   },

   {
      mode        = 'n',
      keys        = '<leader>dB',
      command     = function ()
         dap.set_breakpoint(input('Breakpoint condition : '))
      end,
      description = 'Set breakpoint with condition',
   },

   {
      mode        = 'n',
      keys        = '<leader>dl',
      command     = function ()
         dap.set_breakpoint(nil, nil, input('Log point message : '))
      end,
      description = 'Set log point',
   },

   {
      mode        = 'n',
      keys        = '<leader>dr',
      command     = dap.repl.toggle,
      description = 'Toggle REPL',
   },

   {
      mode        = 'n',
      keys        = '<leader>dR',
      command     = dap.run_last,
      description = 'Run last',
   },

   {
      mode        = 'n',
      keys        = '<leader>dQ',
      command     = dap.stop,
      description = 'Close session',
   },

   {
      mode        = 'n',
      keys        = '<leader>dD',
      command     = dap.disconnect,
      description = 'Disconnect from session',
   },

   {
      mode        = 'n',
      keys        = '<leader>dq',
      command     = dap.list_breakpoints,
      description = 'Send breakpoints to quicklist',
   },

   {
      mode        = 'n',
      keys        = '<leader>du',
      command     = dap.up,
      description = 'Go up in stacktrace',
   },

   {
      mode        = 'n',
      keys        = '<leader>dd',
      command     = dap.down,
      description = 'Go down in stacktrace',
   },
}
