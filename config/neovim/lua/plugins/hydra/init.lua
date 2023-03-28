return {
	"anuvyklack/hydra.nvim",

	keys = {
		"z",
		"<C-w>",
		"<leader>D",
	},

	config = function()
		require("plugins.hydra.config").setup()
	end,
}
