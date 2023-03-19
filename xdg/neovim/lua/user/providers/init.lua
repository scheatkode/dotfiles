return {
	---Disable neovim providers. By default, disables all providers.
	---@param overrides? table providers to keep.
	setup = function(overrides)
		local defaults = {
			loaded_node_provider = 0,
			loaded_perl_provider = 0,
			loaded_python_provider = 0,
			loaded_python3_provider = 0,
			loaded_ruby_provider = 0,
		}

		local deep_extend = require("tablex.deep_extend")
		local providers = deep_extend("force", defaults, overrides or {})

		for k, v in pairs(providers) do
			vim.g[k] = v
		end
	end,
}
