return {
	'tamago324/lir-git-status.nvim',

	opt   = true,
	after = 'lir.nvim',

	config = function()
		require('plugins.explorer-git.config').setup()
	end,
}
