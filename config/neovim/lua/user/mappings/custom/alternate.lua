return {
	---faster alternate file switching
	setup = function()
		vim.keymap.set(
			"n",
			"<Tab>",
			"<C-^>",
			{ desc = "Switch to alternate file" }
		)
	end,
}
