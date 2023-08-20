return {
	---workaround for going up/down the jump list since most terminal
	---multiplexers don't support `CSI u`.
	setup = function()
		vim.keymap.set("n", "]j", "<C-i>", {
			desc = "Go to [count] older cursor position in jump list",
			nowait = true,
		})
		vim.keymap.set("n", "[j", "<C-o>", {
			desc = "Go to [count] newer cursor position in jump list",
			nowait = true,
		})
	end,
}
