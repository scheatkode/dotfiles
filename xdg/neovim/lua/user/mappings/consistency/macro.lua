return {
	---disable autocommands when running macros for better
	---performance.
	setup = function()
		vim.keymap.set(
			"n",
			"@",
			'<cmd>execute "noautocmd normal! " . v:count1 . "@" . getcharstr()<CR>'
		)
	end,
}
