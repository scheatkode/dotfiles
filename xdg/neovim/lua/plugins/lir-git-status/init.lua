return {
	'tamago324/lir-git-status.nvim',

	config = function()
		require('plugins.lir-git-status.config').setup()
	end,
}
