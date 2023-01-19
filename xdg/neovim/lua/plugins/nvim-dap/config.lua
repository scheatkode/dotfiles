return {
	setup = function()

		vim.fn.sign_define('DapBreakpointRejected', {
			text   = '🛑',
			texthl = '',
			linehl = '',
			numhl  = '',
		})

		vim.fn.sign_define('DapBreakpoint', {
			text   = '→',
			texthl = 'Error',
			linehl = '',
			numhl  = '',
		})

		vim.fn.sign_define('DapStopped', {
			text   = '→',
			texthl = 'Success',
			linehl = '',
			numhl  = '',
		})

		vim.fn.sign_define('DapLogPoint', {
			text   = '',
			texthl = 'Question',
			linehl = '',
			numhl  = '',
		})

		local dap = require('dap')

		for _, config in
			ipairs(vim.api.nvim_get_runtime_file('lua/dbg/*/init.lua', true))
		do
			local name     = string.match(config, '(%w+)/init.lua$')
			local settings = loadfile(config)()

			if type(settings.before) == 'function' then
				settings.before()
			end

			dap.adapters[name]       = settings.adapter
			dap.configurations[name] = settings.configuration
		end
	end,
}
