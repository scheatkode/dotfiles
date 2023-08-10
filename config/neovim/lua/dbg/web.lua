return function()
	local pick = require("user.utils.pick_process")

	local registry = require("mason-registry")
	local has_adapter, adapter =
		pcall(registry.get_package, "js-debug-adapter")

	if not has_adapter or not adapter:is_installed() then
		return
	end

	local shared = {
		{
			name = "Debug current test file (pwa-node with vitest)",
			type = "pwa-node",
			request = "launch",
			cwd = "${workspaceFolder}",
			rootPath = "${workspaceFolder}",
			program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
			console = "integratedTerminal",
			args = {
				"--threads",
				"false",
				"run",
				"${relativeFile}",
			},

			autoAttachChildProcesses = true,
			smartStep = true,
			sourceMaps = true,

			skipFiles = {
				"<node_internals>/**",
				"node_modules/**",
			},
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
		},
		{
			name = "Attach to running remote process",
			type = "pwa-node",
			request = "attach",
			cwd = "${workspaceFolder}",
			processId = pick(),
			skipFiles = {
				"<node_internals>/**",
				"node_modules/**",
			},
			autoAttachChildProcesses = true,
			sourceMaps = true,
		},
		{
			name = "Debug frontend in browser",
			type = "pwa-chrome",
			request = "launch",
			url = "http://localhost:5173",
			sourceMaps = true,
			protocol = "inspector",
			port = 9222,
			webRoot = "${workspaceFolder}/src",
			skipFiles = {
				"**/node_modules/**/*",
				"**/@vite/*",
				"**/src/client/*",
				"**/src/*",
			},
		},
	}

	return {
		adapters = {
			["pwa-node"] = {
				type = "server",
				host = "127.0.0.1",
				port = "${port}",
				executable = {
					command = vim.fn.exepath("js-debug-adapter"),
					args = {
						"${port}",
					},
				},
			},
		},

		configurations = {
			["javascript"] = shared,
			["typescript"] = shared,
		},
	}
end
