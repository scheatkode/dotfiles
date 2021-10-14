local input = vim.fn.input
local dap   = require('dap')

return require('util').register_keymaps {
   {
      mode        = 'n',
      keys        = '<leader>cdc',
      command     = dap.continue,
      description = 'Continue',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdC',
      command     = dap.run_to_cursor,
      description = 'Run to cursor',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdb',
      command     = dap.toggle_breakpoint,
      description = 'Toggle breakpoint',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdi',
      command     = dap.step_into,
      description = 'Step into',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdo',
      command     = dap.step_over,
      description = 'Step over',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdO',
      command     = dap.step_out,
      description = 'Step out',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdp',
      command     = dap.step_back,
      description = 'Step back',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdP',
      command     = dap.pause,
      description = 'Pause',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdB',
      command     = function ()
         dap.set_breakpoint(input('Breakpoint condition : '))
      end,
      description = 'Set breakpoint with condition',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdl',
      command     = function ()
         dap.set_breakpoint(nil, nil, input('Log point message : '))
      end,
      description = 'Set log point',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdr',
      command     = dap.repl.toggle,
      description = 'Toggle REPL',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdR',
      command     = dap.run_last,
      description = 'Run last',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdQ',
      command     = dap.stop,
      description = 'Close session',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdD',
      command     = dap.disconnect,
      description = 'Disconnect from session',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdq',
      command     = dap.list_breakpoints,
      description = 'Send breakpoints to quicklist',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdu',
      command     = dap.up,
      description = 'Go up in stacktrace',
   },

   {
      mode        = 'n',
      keys        = '<leader>cdd',
      command     = dap.down,
      description = 'Go down in stacktrace',
   },
}
