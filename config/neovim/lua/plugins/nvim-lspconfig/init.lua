return {
	"neovim/nvim-lspconfig",

	cmd = {
		"LspStatus",
		"LspStart",
		"LspInfo",
	},
	event = {
		"FileType",
	},

	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
}
