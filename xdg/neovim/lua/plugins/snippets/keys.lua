return {
	setup = function()
		vim.keymap.set({ 'i' }, '<M-CR>', require('luasnip').expand_or_jump, { desc = 'Expand current snippet or jump' })
	end,
}
