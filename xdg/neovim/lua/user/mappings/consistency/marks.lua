return {
	---swap ` and ' for marks
	setup = function()
		vim.keymap.set("n", "'", "`", { nowait = true })
		vim.keymap.set("n", "`", "'", { nowait = true })
	end,
}
