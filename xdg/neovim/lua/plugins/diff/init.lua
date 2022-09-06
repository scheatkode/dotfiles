return { -- ediff-like diff view
	'sindrets/diffview.nvim',

	opt = true,
	cmd = {
		'DiffviewClose',
		'DiffviewFileHistory',
		'DiffviewFocusFiles',
		'DiffviewLog',
		'DiffviewOpen',
		'DiffviewRefresh',
		'DiffviewToggleFiles',
	},

	module_pattern = {
		'diffview.*'
	},

	config = function()
		require('plugins.diff.config').setup()
	end
}
