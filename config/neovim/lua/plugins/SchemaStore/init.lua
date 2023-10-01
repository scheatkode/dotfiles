return { -- Access to the SchemaStore catalog.

	"b0o/SchemaStore.nvim",

	ft = {
		"json",
		"yaml",
	},

	dependencies = {
		"neovim/nvim-lspconfig",
	},

	config = function()
		local schemastore = require("schemastore")

		require("lspconfig").jsonls.setup({
			settings = {
				json = {
					schemas = schemastore.json.schemas(),
					valibate = {
						enable = true,
					},
				},
			},
		})

		require("lspconfig").yamlls.setup({
			settings = {
				yaml = {
					customTags = {
						-- GitLab CI specific
						"!reference sequence",
					},
					schemaStore = {
						enable = false,
						url = "",
					},
					schemas = schemastore.yaml.schemas(),
				},
			},
		})
	end,
}
