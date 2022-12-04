return {
	'williamboman/mason.nvim',

	opt = true,

	cmd = {
		'Mason',
		'MasonInstall',
		'MasonUninstall',
		'MasonUninstallAll',
		'MasonLog'
	},

	module = { 'mason' },

	config = function()
		require('mason').setup()
	end
}
