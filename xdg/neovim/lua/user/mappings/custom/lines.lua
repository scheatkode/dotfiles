return {
	---add empty lines
	---https://github.com/mhinz/vim-galore#quickly-add-empty-lines
	setup = function()
		vim.keymap.set(
			"n",
			"[<space>",
			"<cmd>put! =repeat(nr2char(10), v:count1)<CR>'[",
			{ desc = "Add lines below" }
		)
		vim.keymap.set(
			"n",
			"]<space>",
			"<cmd>put  =repeat(nr2char(10), v:count1)<CR>",
			{ desc = "Add lines above" }
		)
	end,
}
