return {
	"numToStr/Comment.nvim",

	keys = {
		{ "<leader>/", mode = { "n", "x" } },
		{ "gb", mode = { "n", "x" } },
		{ "gc", mode = { "n", "x" } },
		"gcb",
		"gcc",
	},

	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},

	config = function()
		require("plugins.Comment.config").setup()
		require("plugins.Comment.keys").setup()
	end,
}
