local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return has_whichkey
end

whichkey.register {
   ['<leader>cd'] = {
      name = '+dap',

      B = { 'Set breakpoint with condition' },
      C = { 'Run to cursor'                 },
      D = { 'Disconnect from session'       },
      O = { 'Step out'                      },
      P = { 'Pause'                         },
      Q = { 'Close session'                 },
      R = { 'Run last'                      },
      b = { 'Toggle breakpoint'             },
      c = { 'Continue'                      },
      d = { 'Go down in stacktrace'         },
      i = { 'Step into'                     },
      l = { 'Set log point'                 },
      o = { 'Step over'                     },
      p = { 'Step back'                     },
      q = { 'Send breakpoints to quicklist' },
      r = { 'Toggle REPL'                   },
      u = { 'Go up in stacktrace'           },
   }
}
