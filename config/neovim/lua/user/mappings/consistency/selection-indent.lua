return {
	---don't lose selection when indenting or outdenting
	---https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
	setup = function()
		vim.keymap.set("x", "<", "<gv")
		vim.keymap.set("x", ">", ">gv")
	end,
}
