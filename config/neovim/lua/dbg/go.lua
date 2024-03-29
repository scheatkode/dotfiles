return {
	["go"] = {
		adapter = function(callback, config)
			local handle
			local pid_or_err

			local host = config.host or "127.0.0.1"
			local port = config.port or 8087
			local stdout = vim.loop.new_pipe(false)
			local options = {
				stdio = { nil, stdout },
				args = { "dap", "-l", string.format("%s:%s", host, port) },
				detached = true,
			}

			handle, pid_or_err = vim.loop.spawn("dlv", options, function(code)
				stdout:close()
				handle:close()

				if code ~= 0 then
					print("dlv exited with code", code)
				end
			end)

			assert(handle, "Error running dlv: " .. tostring(pid_or_err))

			stdout:read_start(function(err, chunk)
				assert(not err, err)

				if chunk then
					vim.schedule(function()
						require("dap.repl").append(chunk)
					end)
				end
			end)

			-- wait for delve to start
			vim.defer_fn(function()
				callback({
					type = "server",
					host = host,
					port = port,
				})
			end, 100)
		end,

		configuration = {
			{
				type = "go",
				name = "Debug",
				request = "launch",
				program = "${file}",
			},
			{
				type = "go",
				name = "Attach",
				mode = "local",
				request = "attach",
				processId = require("dap.utils").pick_process,
			},
			{
				-- configuration for debugging test files
				type = "go",
				name = "Debug test",
				request = "launch",
				showLog = true,
				mode = "test",
				program = "${file}",
				dlvToolPath = vim.fn.exepath("dlv"),
			},
			{
				-- works with go.mod packages and sub packages
				type = "go",
				name = "Debug test (go.mod)",
				request = "launch",
				mode = "test",
				program = "./${relativeFileDirname}",
				dlvToolPath = vim.fn.exepath("dlv"),
			},
		},
	},
}
