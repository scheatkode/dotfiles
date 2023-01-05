return {
	'mxsdev/nvim-dap-vscode-js',

	config = function()
		require('dap-vscode-js').setup({
			adapters = {
				'node-terminal',
				'pwa-node',
				'pwa-chrome',
				'pwa-msedge',
				'pwa-extensionHost',
			},

			debugger_path = string.format(
				'%s/%s',
				vim.fn.stdpath('data'),
				'mason/bin/js-debug-adapter'
			),

			debugger_cmd = { 'js-debug-adapter' }
		})
	end,
}
