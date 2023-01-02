return {
	'nvim-telescope/telescope.nvim',

	cmd = {
		'Telescope',
	},

	keys = {
		'<leader><leader>',
		'<leader>;',
		'<leader>sp',
		'<leader>se',
		'<leader>sE',
		'<leader>sg',
		'<leader>sG',
		'<leader>st',
		'<leader>ss',
		'<leader>sf',
		'<leader>sF',
		'<leader>sn',
		'<leader>sb',
		'<leader>sB',
		'<leader>sgc',
		'<leader>sgf',
		'<leader>sgb',
		'<leader>sc',
		'<leader>sq',
		'<leader>sl',
		'<leader>so',
		'<leader>sh',
		'<leader>sM',
		'<leader>sm',
		'<leader>sR',
		'<leader>svr',
		'<leader>sk',
		'<leader>sva',
		'<leader>sS',
		'<leader>sr',
		'<leader>sd',
		'<leader>sT',
		'<leader>si',
		'<leader>sds',
		'<leader>sws',
		'<leader>sdd',
		'<leader>su',
	},

	dependencies = {
		'nvim-lua/popup.nvim',
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-project.nvim',
		'nvim-telescope/telescope-file-browser.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
		},
		'debugloop/telescope-undo.nvim',
	},

	config = function()
		require('plugins.telescope.config').setup()
		require('plugins.telescope.keys').setup()
	end,
}
