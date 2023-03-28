return {
	"kevinhwang91/nvim-bqf",

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},

	ft = {
		"qf",
	},

	config = function()
		require("plugins.nvim-bqf.config").setup()
	end,
}
