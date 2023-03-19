return {
	setup = function()
		vim.keymap.set({ "n" }, "gS", "<cmd>TSJSplit<CR>", {
			desc = "Split the block of code under the cursor",
		})

		vim.keymap.set({ "n" }, "gJ", "<cmd>TSJJoin<CR>", {
			desc = "Join the block of code under the cursor",
		})
	end,
}
