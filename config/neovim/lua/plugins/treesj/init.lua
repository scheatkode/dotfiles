return {
	"Wansmer/treesj",

	keys = {
		"gS",
		"gJ",
	},

	config = function(_, opts)
		local tsj = require("treesj")

		tsj.setup(opts)

		vim.keymap.set({ "n" }, "gS", "<cmd>TSJSplit<CR>", {
			desc = "Split the block of code under the cursor",
		})

		vim.keymap.set({ "n" }, "gJ", "<cmd>TSJJoin<CR>", {
			desc = "Join the block of code under the cursor",
		})
	end,

	opts = {
		---Do not use default mappings.
		---@type boolean
		use_default_keymaps = false,

		---Nodes with syntax errors will not be formatted.
		---@type boolean
		check_syntax_error = true,

		---Joins resulting in lines longer than this will not
		--be formatted.
		---@type number
		max_join_length = 100,

		---Cursor position after formatting:
		--- - hold  → cursor follows its original position
		--- - start → cursor jumps to the first formatted symbol
		--- - end   → cursor jumps to the last formatted symbol
		---@type 'hold'|'start'|'end'
		cursor_behavior = "hold",

		---Notify about possible problems.
		---@type boolean
		notify = false,
	},
}
