return {
	setup = function()
		-- Ensure debugger config is loaded.
		require('dap-vscode-js')
	end,

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
			name              = 'Debug current file (pwa-node with deno)',
			type              = 'pwa-node',
			request           = 'launch',
			cwd               = vim.loop.cwd(),
			runtimeArgs       = { 'run', '--inspect-brk', '--allow-all', '${file}' },
			runtimeExecutable = 'deno',
			attachSimplePort  = 9229,
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
			-- If using in a monorepo, don't forget to `:h :cd` into the package
			-- directory.
			name    = 'Debug current test file (pwa-node with vitest)',
			type    = 'pwa-node',
			request = 'launch',
			cwd     = vim.loop.cwd(),
			program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
			console = 'integratedTerminal',
			args    = { '--threads', 'false', 'run', '${relativeFile}' },

			autoAttachChildProcesses = true,
			smartStep                = true,
			sourceMaps               = true,

			skipFiles                 = { '<node_internals>/**', 'node_modules/**' },
			resolveSourceMapLocations = {
				'${workspaceFolder}/**',
				'!**/node_modules/**',
			},
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
