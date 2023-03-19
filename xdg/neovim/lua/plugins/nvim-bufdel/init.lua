return { -- delete buffer without messing up layout
	"ojroques/nvim-bufdel",

	cmd = {
		"BufDel",
	},
	keys = {
		"<leader>bk",
		"<leader>bK",
	},

	config = function()
		require("plugins.nvim-bufdel.config").setup()
		require("plugins.nvim-bufdel.keys").setup()
	end,
}
