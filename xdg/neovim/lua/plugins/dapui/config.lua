-- localize globals {{{

local log = require('log')

-- }}}
-- check for plugin existence {{{

local has_dapui, dapui = pcall(require, 'dapui')

if not has_dapui then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'dap-ui')
   return has_dapui
end

-- }}}
-- configure plugin {{{

dapui.setup {
   icons = {
      expanded  = '▾',
      collapsed = '▸'
   },

   mappings = {
      expand = { '<Tab>' },
      open   = { 'o', '<CR>' },
      remove = 'd',
      edit   = 'e',
   },

   sidebar = {
      open_on_start = true,
      elements      = {
         'scopes',
         'breakpoints',
         'stacks',
         'watches',
      },
      position = 'left',
      width    = 40,
   },

   tray = {
      open_on_start = true,
      elements      = {
         'repl'
      },
      position = 'bottom',
      height   = 4,
   },

   floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width  = nil   -- Floats will be treated as percentage of your screen.
   }
}

-- }}}

-- vim: set fdm=marker fdl=0:
