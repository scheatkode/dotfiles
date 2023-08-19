return {
	---be consistent with shell mappings
	setup = function()
		vim.keymap.set("i", "<M-d>", "<C-o>dw", { nowait = true })

		vim.keymap.set("c", "<C-a>", "<Home>", { nowait = true })
		vim.keymap.set("c", "<C-e>", "<End>", { nowait = true })
	end,
}
