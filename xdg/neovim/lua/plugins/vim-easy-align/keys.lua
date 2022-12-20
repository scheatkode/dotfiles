return {
	setup = function()
		vim.keymap.set({ 'n', 'x' }, '<leader>ta', '<Plug>(EasyAlign)', {
			remap = true,
			desc  = 'Align text',
		})

		vim.keymap.set({ 'n', 'x' }, '<leader>tl', '<Plug>(LiveEasyAlign)', {
			remap = true,
			desc  = 'Align text with preview',
		})
	end,
}
