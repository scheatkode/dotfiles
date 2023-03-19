return {
	---buffer operations
	setup = function()
		vim.keymap.set(
			"n",
			"<leader>bn",
			"<cmd>enew<CR>",
			{ desc = "New empty buffer" }
		)
		vim.keymap.set(
			"n",
			"<leader>bw",
			"<cmd>bwipeout!<CR>",
			{ desc = "Wipe buffer" }
		)
		vim.keymap.set(
			"n",
			"<leader>bq",
			"<cmd>bunload<CR>",
			{ desc = "Quit/Close buffer" }
		)
		vim.keymap.set(
			"n",
			"<leader>br",
			"<cmd>e<CR>",
			{ desc = "Reload buffer" }
		)
		vim.keymap.set(
			"n",
			"<leader>bR",
			"<cmd>e!<CR>",
			{ desc = "Reload buffer forcefully" }
		)
	end,
}
