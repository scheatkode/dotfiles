local vfun   = vim.fn
local tablex = require('tablex')

local defaults = {
   DiagnosticSignError = { text = '', texthl = 'DiagnosticError' },
   DiagnosticSignWarn  = { text = '‼', texthl = 'DiagnosticWarn'  },
   DiagnosticSignInfo  = { text = 'ℹ', texthl = 'DiagnosticInfo'  },
   DiagnosticSignHint  = { text = '', texthl = 'DiagnosticHint'  },
}

vim.diagnostic.config({
   signs            = true,
   underline        = false,
   update_in_insert = false,
   virtual_text     = {
      spacing = 3,
   },
   float = {
   	source = 'always',
   },
})

---apply the given diagnostic signs configuration, or the
---defaults otherwise.
---
---@param overrides? table options table
local function setup (overrides)
   local options = tablex.deep_extend('force', defaults, overrides or {})

   for k, v in pairs(options) do
      vfun.sign_define(k, v)
   end
end

return {
   setup = setup
}
