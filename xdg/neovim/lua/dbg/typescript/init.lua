return {
	adapter = {},

	configuration = {
		{
			name        = 'ts-node (Node2 with ts-node)',
			type        = 'node2',
			request     = 'launch',
			cwd         = vim.loop.cwd(),
			runtimeArgs = { '-r', 'ts-node/register' },
			args        = { '--inspect', '${file}' },
			sourceMaps  = true,
			skipFiles   = { '<node_internals>/**', 'node_modules/**' },
		}, {
			name              = 'Jest (Node2 with ts-node)',
			type              = 'node2',
			request           = 'launch',
			cwd               = vim.loop.cwd(),
			runtimeArgs       = { '--inspect-brk', '${workspaceFolder}/node_modules/.bin/jest' },
			runtimeExecutable = 'node',
			args              = { '${file}', '--runInBand', '--coverage', 'false' },
			sourceMaps        = true,
			port              = 9229,
			skipFiles         = { '<node_internals>/**', 'node_modules/**' },
		}, {
			name                     = 'Attach to running remote process',
			type                     = 'pwa-node',
			request                  = 'attach',
			cwd                      = '${workspaceFolder}',
			port                     = 9229,
			skipFiles                = { '<node_internals>/**', 'node_modules/**' },
			autoAttachChildProcesses = true,
			sourceMaps               = true,
		}
	}
}
