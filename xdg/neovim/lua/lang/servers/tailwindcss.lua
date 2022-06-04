return {
	-- This server gets spawned all over the place while being useless most of
	-- the time. Starting it manually so I don't have to manage 15 running
	-- servers at once.
	autostart = false,

	cmd = {
		vim.fn.expand(table.concat({
			vim.fn.stdpath('data'),
			'lsp_servers',
			'tailwindcss_npm',
			'node_modules',
			'.bin',
			'tailwindcss-language-server',
		}, '/')),
		'--stdio',
	},
}
