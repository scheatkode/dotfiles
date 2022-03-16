local vg     = vim.g
local tablex = require('tablex')

local defaults = {
   loaded_node_provider    = 0,
   loaded_perl_provider    = 0,
   loaded_python_provider  = 0,
   loaded_python3_provider = 0,
   loaded_ruby_provider    = 0,
}

---disable neovim providers. by default, disables all providers.
---@param overrides table providers to keep.
local function disable(overrides)
   local providers = tablex.deep_extend('force', defaults, overrides or {})

   for k, v in pairs(providers) do
      vg[k] = v
   end
end

return {
   disable = disable
}
