return {
	'akinsho/git-conflict.nvim',

	opt = true,

	cmd = {
		'GitConflictListQf',
	},

	config = function()
		require('plugins.git-conflict.config').setup()
	end
}
