return {
	---tab operations
	setup = function()
		vim.keymap.set("n", "<leader>tl", "<cmd>tabs<CR>", {
			desc = "List tabs",
		})
		vim.keymap.set("n", "<leader>tN", "<cmd>tabnew<CR>", {
			desc = "New tab",
		})
		vim.keymap.set("n", "<leader>tn", "<cmd>tabnext<CR>", {
			desc = "Next tab",
		})
		vim.keymap.set("n", "<leader>tp", "<cmd>tabprevious<CR>", {
			desc = "Prevous tab",
		})
		vim.keymap.set("n", "<leader>tq", "<cmd>tabclose<CR>", {
			desc = "Quit/Close tab",
		})

		for i = 1, 9 do
			vim.keymap.set(
				"n",
				string.format("<leader>t%d", i),
				string.format("<cmd>tab %d<CR>", i),
				{ desc = string.format("Go to tab %d", i) }
			)
		end
	end,
}
