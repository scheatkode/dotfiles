return {
	setup = function()
		local signs = {
			DapBreakpoint = { text = " ", texthl = "Error" },
			DapBreakpointCondition = { text = " ", texthl = "Question" },
			DapBreakpointRejected = { text = " ", texthl = "Warning" },
			DapLogPoint = { text = " ", texthl = "Question" },
			DapStopped = {
				text = " ",
				texthl = "Success",
				linehl = "CursorLine",
			},
		}

		for sign, opts in pairs(signs) do
			vim.fn.sign_define(sign, {
				text = opts.text,
				texthl = opts.texthl,
				linehl = opts.linehl or "",
				numhl = opts.numhl or "",
			})
		end

		local dap = require("dap")

		for _, config in
			ipairs(vim.api.nvim_get_runtime_file("lua/dbg/*/init.lua", true))
		do
			local name = string.match(config, "(%w+)/init.lua$")
			local settings = loadfile(config)()

			if type(settings.setup) == "function" then
				settings.setup()
			end

			for adapter, conf in pairs(settings.adapters or {}) do
				dap.adapters[adapter] = conf
			end

			dap.adapters[name] = settings.adapter
			dap.configurations[name] = settings.configuration
		end
	end,
}
