return {
	---shortcut for the current file's directory, better than
	---manually typing `%:p:h` every time.
	setup = function()
		vim.keymap.set("c", "<m-e>", [[<C-r>=fnameescape("")<left><left>]], {
			desc = [[Put fnameescape("…")]],
		})

		vim.keymap.set("c", "<m-t>", [[<C-r>=fnamemodify(@%, ":t")<CR>]], {
			desc = "Put filename tail",
		})

		vim.keymap.set("c", "<m-f>", [[<C-r>=expand("%:p:h") . "/"<CR>]], {
			desc = "Put path of folder containing file",
		})
	end,
}
