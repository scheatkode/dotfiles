return {
	"stevearc/oil.nvim",

	keys = {
		"-",
	},

	config = function()
		require("plugins.oil.config").setup()
		require("plugins.oil.keys").setup()
	end,
}
