return {
	setup = function()
		vim.keymap.set("n", "-", require("oil").open, {
			desc = "Toggle file explorer",
		})
	end,
}
