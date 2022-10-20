return {
	setup = function()
		require('git-conflict').setup({
			default_mappings = true,
			disable_diagnostics = true,
		})
	end
}
