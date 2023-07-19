return {
	setup = function()
		vim.fn.sign_define("DapBreakpoint", {
			text = " ",
			texthl = "Error",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapBreakpointCondition", {
			text = " ",
			texthl = "Question",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapBreakpointRejected", {
			text = " ",
			texthl = "Warning",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapStopped", {
			text = " ",
			texthl = "Success",
			linehl = "CursorLine",
			numhl = "",
		})

		vim.fn.sign_define("DapLogPoint", {
			text = " ",
			texthl = "Question",
			linehl = "",
			numhl = "",
		})

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
