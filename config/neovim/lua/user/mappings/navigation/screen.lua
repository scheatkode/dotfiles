return {
	---insert-mode quick screen centering
	setup = function()
		vim.keymap.set("i", "<M-z><M-z>", "<C-o>zz")
	end,
}
