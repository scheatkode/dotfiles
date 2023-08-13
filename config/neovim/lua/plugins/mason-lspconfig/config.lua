return {
	setup = function()
		local lazy = require("load")
		local lspconfig = lazy.on_index("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup({
			handlers = {
				function(server)
					local has_config, config =
						pcall(require, "lsp.servers." .. server)

					if not has_config then
						return lspconfig[server].setup({})
					end

					if type(config) == "function" then
						config = config()
					end

					return lspconfig[server].setup(config)
				end,
			},
		})
	end,
}
