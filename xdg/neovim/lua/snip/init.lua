return {
	setup = vim.schedule_wrap(function()
		for _, f in
			ipairs(vim.api.nvim_get_runtime_file('lua/snip/*/*.lua', true))
		do
			loadfile(f)().setup()
		end
	end),
}
