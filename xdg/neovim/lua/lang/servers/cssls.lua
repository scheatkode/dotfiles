return {
	cmd = {
		vim.fn.expand(table.concat({
			vim.fn.stdpath('data'),
			'lsp_servers',
			'cssls',
			'node_modules',
			'.bin',
			'vscode-css-language-server',
		}, '/')),
		'--stdio'
	}
}
