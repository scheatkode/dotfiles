return {
	setup = function()
		local log = require('log')
		local dap = require('dap')

		local debuggers = {
			'go',
			'node2',
			'javascript',
			'typescript',
		}

		local function configure_debuggers(debugger_list)
			for _, debugger in ipairs(debugger_list) do
				local has_settings, settings = pcall(require, 'dbg.' .. debugger)

				if not has_settings then
					log.error(
						'Missing configuration for debugger ' .. debugger,
						'‼ dap'
					)
					goto continue
				end

				if type(settings.before) == 'function' then
					settings.before()
				end

				dap.adapters[debugger]       = settings.adapter
				dap.configurations[debugger] = settings.configuration

				::continue::
			end
		end

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

		configure_debuggers(debuggers)
	end
}
