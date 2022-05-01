return {
	---jumplist triggers
	setup = function()
		vim.keymap.set('n', 'k', '(v:count1 > 5 ? "m\'" . v:count : "") . "k"', { expr = true })
		vim.keymap.set('n', 'j', '(v:count1 > 5 ? "m\'" . v:count : "") . "j"', { expr = true })
	end
}
