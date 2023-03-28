return {
	"windwp/nvim-autopairs",

	event = "InsertEnter",

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},

	config = function()
		require("plugins.nvim-autopairs.config").setup()
		require("plugins.nvim-autopairs.rules").setup()
	end,
}
