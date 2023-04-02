return {
	"ggandor/leap.nvim",

	keys = {
		"s",
		"S",
		"gs",
	},

	config = function()
		vim.keymap.set({ "n" }, "s", "<Plug>(leap-forward-to)")
		vim.keymap.set({ "n" }, "S", "<Plug>(leap-backward-to)")
		vim.keymap.set({ "n" }, "gs", "<Plug>(leap-from-window)")
		vim.keymap.set({ "o" }, "s", "<Plug>(leap-forward-x)")
		vim.keymap.set({ "o" }, "S", "<Plug>(leap-backward-x)")
		vim.keymap.set({ "x" }, "s", "<Plug>(leap-forward-till)")
		vim.keymap.set({ "x" }, "S", "<Plug>(leap-backward-till)")
	end,
}
