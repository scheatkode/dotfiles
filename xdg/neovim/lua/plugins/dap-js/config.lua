return {
	setup = function()
		local js = require('dap-vscode-js')

		js.setup({
			adapters = {
				'node-terminal',
				'pwa-node',
				'pwa-chrome',
				'pwa-msedge',
				'pwa-extensionHost',
			},

			debugger_path = string.format('%s/%s', vim.fn.stdpath('data'), 'mason/packages/js-debug-adapter'),
		})
	end
}
