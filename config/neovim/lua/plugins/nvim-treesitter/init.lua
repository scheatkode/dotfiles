return {
	"nvim-treesitter/nvim-treesitter",

	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
	},

	event = {
		"FileType",
	},

	build = ":TSUpdate",

	config = function()
		require("plugins.nvim-treesitter.config").setup()
	end,
}
