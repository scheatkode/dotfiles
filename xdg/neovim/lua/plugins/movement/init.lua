return {
	'ggandor/leap.nvim',

	opt  = true,
	keys = {
		's',
		'S',
		'f',
		'F',
		't',
		'T',
	},

	config = function()
		require('leap').add_default_mappings()
	end
}
