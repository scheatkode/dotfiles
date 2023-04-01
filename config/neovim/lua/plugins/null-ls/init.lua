return {
	"jose-elias-alvarez/null-ls.nvim",

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
		require("plugins.null-ls.config").setup()
	end,
}
