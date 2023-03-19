return {
	---quick and convenient text movement that doesn't mess with
	---registers.
	setup = function()
		vim.keymap.set(
			"n",
			"<C-j>",
			'<cmd>execute "move .+" .  v:count1      . " <bar> normal! =="<CR>'
		)
		vim.keymap.set(
			"n",
			"<C-k>",
			'<cmd>execute "move .-" . (v:count1 + 1) . " <bar> normal! =="<CR>'
		)

		vim.keymap.set("i", "<M-j>", "<cmd>move .+1 <bar> normal! ==<CR>")
		vim.keymap.set("i", "<M-k>", "<cmd>move .-2 <bar> normal! ==<CR>")

		vim.keymap.set("x", "<C-j>", ":move '>+1<CR>gv=gv")
		vim.keymap.set("x", "<C-k>", ":move '<-2<CR>gv=gv")
	end,
}
