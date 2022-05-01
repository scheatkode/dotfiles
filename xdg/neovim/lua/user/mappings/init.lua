return {
	setup = vim.schedule_wrap(function()
		require('user.mappings.consistency').setup()
		require('user.mappings.navigation').setup()
		require('user.mappings.textobjects').setup()

		require('user.mappings.custom').setup()
	end)
}
