return {
	---`;` is faster than `:` to run commands. win a keystroke,
	---profit.
	setup = function()
		vim.keymap.set({ 'n', 'x' }, ';', ':', { nowait = true })
	end
}
