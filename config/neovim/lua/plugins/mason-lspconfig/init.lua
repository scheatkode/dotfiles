return {
	"williamboman/mason-lspconfig.nvim",

	dependencies = {
		"williamboman/mason.nvim",
	},

	config = function()
		require("plugins.mason-lspconfig.config").setup()
	end,
}
