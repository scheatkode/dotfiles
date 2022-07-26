local tablex = require('tablex')

local defaults = {
	loaded_node_provider    = 0,
	loaded_perl_provider    = 0,
	loaded_python_provider  = 0,
	loaded_python3_provider = 0,
	loaded_ruby_provider    = 0,
}

---Disable neovim providers. By default, disables all providers.
---@param overrides? table providers to keep.
return {
	disable = function(overrides)
		local providers = tablex.deep_extend(
			'force',
			defaults,
			overrides or {}
		)

		for k, v in pairs(providers) do
			vim.g[k] = v
		end
	end
}
