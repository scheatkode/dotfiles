return {
	"nvim-neotest/neotest",

	cmd = {
		"Neotest",
	},
	keys = {
		"<leader>ct",
	},

	dependencies = {
		"nvim-neotest/neotest-plenary",
	},

	config = function()
		require("plugins.neotest.config").setup()
		require("plugins.neotest.keys").setup()
	end,
}
