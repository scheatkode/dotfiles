return { -- ediff-like diff view
	'sindrets/diffview.nvim',

	cmd = {
		'DiffviewClose',
		'DiffviewFileHistory',
		'DiffviewFocusFiles',
		'DiffviewLog',
		'DiffviewOpen',
		'DiffviewRefresh',
		'DiffviewToggleFiles',
	},

	config = function()
		require('plugins.diffview.config').setup()
	end,
}
