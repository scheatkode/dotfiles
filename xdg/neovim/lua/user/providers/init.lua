return {
	---Disable neovim providers. By default, disables all providers.
	---@param overrides? table providers to keep.
	disable = function(overrides)
		local defaults = {
			loaded_node_provider    = 0,
			loaded_perl_provider    = 0,
			loaded_python_provider  = 0,
			loaded_python3_provider = 0,
			loaded_ruby_provider    = 0,
		}

		local extend    = require('tablex').deep_extend
		local providers = extend('force', defaults, overrides or {})

		for k, v in pairs(providers) do
			vim.g[k] = v
		end
	end
}
