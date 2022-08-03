return {
	adapter = {},

	configuration = {
		{
			name       = 'Launch',
			type       = 'node2',
			request    = 'launch',
			program    = '${file}',
			cwd        = vim.loop.cwd(),
			sourceMaps = true,
			protocol   = 'inspector',
			console    = 'integratedTerminal'
		}, {
			-- For this to work, make sure the node process is started with
			-- the `--inspect` flag.
			name      = 'Attach to process',
			type      = 'node2',
			request   = 'attach',
			processId = require('dap.utils').pick_process,
		},
	}
}
