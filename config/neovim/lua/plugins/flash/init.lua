local lazy = require("load.on_member_call")

return {
	"folke/flash.nvim",

	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			lazy("flash").jump,
			desc = "Flash to position",
		},
		{
			"S",
			mode = { "n", "o", "x" },
			lazy("flash").treesitter,
			desc = "Flash to position using Treesitter",
		},
	},

	opts = {
		labels = "aoeuidhtnspyfgcrl/",
		search = {
			multi_window = false,
		},
		jump = {
			autojump = true,
		},
	},
}
