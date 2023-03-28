return {
	"junegunn/vim-easy-align",

	cmd = {
		"EasyAlign",
	},
	keys = {
		{ "<leader>t", mode = { "n", "x" } },
		{ "<leader>ta", mode = { "n", "x" } },
		{ "<leader>tl", mode = { "n", "x" } },
		{ "<Plug>(EasyAlign)", mode = { "n", "x" } },
		{ "<Plug>(LiveEasyAlign)", mode = { "n", "x" } },
	},

	config = function()
		require("plugins.vim-easy-align.keys").setup()
	end,
}
