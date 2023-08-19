return {
	---workaround for going up/down the jump list since most terminal
	---multiplexers don't support `CSI u`.
	setup = function()
		vim.keymap.set("n", "]j", "<C-i>", { nowait = true })
		vim.keymap.set("n", "[j", "<C-o>", { nowait = true })
	end,
}
