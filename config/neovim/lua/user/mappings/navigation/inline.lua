return {
	---better line navigation
	setup = function()
		vim.keymap.set(
			{ "n", "x", "o" },
			"H",
			"col('.') == match(getline('.'), '\\S')+1 ? '0' : '^'",
			{ expr = true }
		)
		vim.keymap.set({ "n", "x", "o" }, "L", "$")
	end,
}
