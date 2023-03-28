return {
	---shortcut for the current file's directory, better than
	---manually typing `%:p:h` every time.
	setup = function()
		vim.keymap.set(
			"c",
			",,e",
			'<C-r>=expand("%:p:h") . "/"<CR>',
			{ nowait = true }
		)
	end,
}
