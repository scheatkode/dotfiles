return {
	"nvimtools/none-ls.nvim",

	ft = {
		"bash",
		"css",
		"go",
		"html",
		"javascript",
		"javascript.jsx",
		"javascriptreact",
		"jinja",
		"json",
		"lua",
		"markdown",
		"python",
		"scss",
		"sh",
		"sls",
		"sls.yaml",
		"svelte",
		"typescript",
		"typescript.tsx",
		"typescriptreact",
		"yaml",
	},

	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("plugins.none-ls.config").setup()
	end,
}
