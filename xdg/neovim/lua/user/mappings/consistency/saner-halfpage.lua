return {
	---add automatic screen centering when navigating by
	---half-page.
	setup = function()
		vim.keymap.set("n", "<C-u>", "<C-u>zz")
		vim.keymap.set("n", "<C-d>", "<C-d>zz")
	end,
}
