--- localise vim globals

local api = vim.api

--- required and optional plugins

local has_dap,      dap      = pcall(require, 'dap')
local has_dapui,    dapui    = pcall(require, 'dapui')
local has_whichkey, whichkey = pcall(require, 'which-key')

--- internal utilities

local apply_buffer_keymaps = require('sol.vim').apply_buffer_keymaps

--- mappings



--- mappings help

if has_whichkey then
   whichkey.register({
      ['<leader>cd'] = {
         name = '+dap',
      },
   })
end
