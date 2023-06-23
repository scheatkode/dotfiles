return {
	---faster escaping
	setup = function()
		vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
	end,
}
