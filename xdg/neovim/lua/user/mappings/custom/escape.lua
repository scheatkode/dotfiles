return {
	---faster escaping
	setup = function()
		vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

		vim.keymap.set({ "i", "v", "c", "o" }, "jk", "<Esc>")
		vim.keymap.set({ "i", "v", "c", "o" }, "<C-c>", "<Esc>")
	end,
}
