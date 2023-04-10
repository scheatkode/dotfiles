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
		vim.keymap.set({ "n", "x" }, "<leader>ta", "<Plug>(EasyAlign)", {
			remap = true,
			desc = "Align text",
		})

		vim.keymap.set({ "n", "x" }, "<leader>tl", "<Plug>(LiveEasyAlign)", {
			remap = true,
			desc = "Align text with preview",
		})
	end,
}
