return {
	'ggandor/leap.nvim',

	keys = {
		's',
		'S',
		'gs',
	},

	config = function()
		vim.keymap.set({ 'n' }, 's', '<Plug>(leap-forward-to)')
		vim.keymap.set({ 'n' }, 'S', '<Plug>(leap-backward-to)')
		vim.keymap.set({ 'n' }, 'gs', '<Plug>(leap-cross-window)')
		vim.keymap.set({ 'v', 'x' }, 's', '<Plug>(leap-forward-till)')
		vim.keymap.set({ 'v', 'x' }, 'S', '<Plug>(leap-backward-till)')
	end,
}