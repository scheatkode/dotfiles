return {
	cmd = {
		vim.fn.expand(table.concat({
			vim.fn.stdpath('data'),
			'lsp_servers',
			'vscode-eslint',
			'node_modules',
			'.bin',
			'vscode-eslint-language-server',
		}, '/')),
		'--stdio'
	},

	filetypes = {
		'javascript',
		'javascriptreact',
		'javascript.jsx',
		'svelte',
		'typescript',
		'typescriptreact',
		'typescript.jsx',
		'vue',
	}
}
