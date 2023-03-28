return {
	--- making mappings more consistent for command-mode
	setup = function()
		vim.keymap.set("c", "<C-k>", "<Up>", { nowait = true })
		vim.keymap.set("c", "<C-j>", "<Down>", { nowait = true })
	end,
}
