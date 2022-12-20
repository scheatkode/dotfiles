return {
	setup = function()
		require('neotest').setup({
			adapters = {
				require('neotest-plenary'),
			},
		})
	end,
}
