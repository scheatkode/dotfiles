return {
	---current line text object
	setup = function()
		vim.keymap.set("x", "iL", "<cmd>normal! ^o$<CR>")
		vim.keymap.set("x", "aL", "<cmd>normal! 0o$<CR>")

		vim.keymap.set("o", "iL", "<cmd>normal! $v^<CR>", { silent = true })
		vim.keymap.set("o", "aL", "<cmd>normal! $v0<CR>", { silent = true })
	end,
}
