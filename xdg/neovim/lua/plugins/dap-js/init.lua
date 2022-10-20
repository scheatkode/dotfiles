return {
	'mxsdev/nvim-dap-vscode-js',

	opt = true,

	-- after = {
	-- 	'mfussenegger/nvim-dap',
	-- }

	config = function()
		require('plugins.dap-js.config').setup()
	end
}
