return {
	---fast window resizing, optimized for dvorak
	setup = function()
		vim.keymap.set("n", "<M-->", "<cmd>wincmd -<CR>")
		vim.keymap.set("n", "<M-=>", "<cmd>wincmd +<CR>")
		vim.keymap.set("n", "<M-.>", "<cmd>wincmd ><CR>")
		vim.keymap.set("n", "<M-,>", "<cmd>wincmd <<CR>")
	end,
}
