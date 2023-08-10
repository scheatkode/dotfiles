---@class user.dap.DapSimpleSetting
---@field adapter? Adapter
---@field configuration? Configuration[]

---@class user.dap.DapMultiSetting
---@field adapters? table<string, Adapter>
---@field configurations? table<string, Configuration[]>

---@alias user.dap.DapSetting table<string, user.dap.DapSimpleSetting> | user.dap.DapMultiSetting

return {
	setup = function()
		local dap = require("dap")
		local tx = require("tablex")

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

		for _, path in
			ipairs(vim.api.nvim_get_runtime_file("lua/dbg/**/*.lua", true))
		do
			---@type user.dap.DapSetting | (fun(): user.dap.DapSetting)
			local cfg = loadfile(path)()

			if not cfg then
				goto continue
			end

			if type(cfg) == "function" then
				cfg = cfg()
			end

			if cfg.adapters or cfg.configurations then
				dap.adapters = tx.extend(dap.adapters, cfg.adapters or {})
				dap.configurations =
					tx.extend(dap.configurations, cfg.configurations or {})
				goto continue
			end

			for name, subcfg in pairs(cfg) do
				dap.adapters[name] = subcfg.adapter
				dap.configurations[name] = subcfg.configuration
			end

			::continue::
		end
	end,
}
