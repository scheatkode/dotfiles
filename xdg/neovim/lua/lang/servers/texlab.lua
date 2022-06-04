return {
	cmd = {
		vim.fn.expand(table.concat({
			vim.fn.stdpath('data'),
			'lsp_servers',
			'latex',
			'texlab',
		}, '/')),
	}
}
