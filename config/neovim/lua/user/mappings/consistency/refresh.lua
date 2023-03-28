return {
	---saner `ctrl-l`
	---https://github.com/mhinz/vim-galore#saner-ctrl-l
	setup = function()
		vim.keymap.set(
			"n",
			"<C-l>",
			":<C-u>nohlsearch<CR>:diffupdate<CR><C-l>",
			{ silent = true }
		)
	end,
}
