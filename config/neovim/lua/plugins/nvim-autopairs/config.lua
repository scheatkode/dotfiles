return {
	setup = function()
		local pairs = require("nvim-autopairs")

		pairs.setup({
			check_ts = true,
			disable_in_macro = true,
		})
	end,
}
