return {
	setup = function()
		local dap = require("dap")
		local dapwid = require("dap.ui.widgets")

		vim.keymap.set("n", "<leader>dc", dap.continue, {
			desc = "Continue",
		})

		vim.keymap.set("n", "<F5>", dap.continue, {
			desc = "Continue",
		})

		vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, {
			desc = "Run to cursor",
		})

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {
			desc = "Toggle breakpoint",
		})

		vim.keymap.set("n", "<leader>di", dap.step_into, {
			desc = "Step into",
		})

		vim.keymap.set("n", "<F10>", dap.step_into, {
			desc = "Step into",
		})

		vim.keymap.set("n", "<leader>do", dap.step_over, {
			desc = "Step over",
		})

		vim.keymap.set("n", "<F11>", dap.step_over, {
			desc = "Step over",
		})

		vim.keymap.set("n", "<leader>dO", dap.step_out, {
			desc = "Step out",
		})

		vim.keymap.set("n", "<F12>", dap.step_out, {
			desc = "Step out",
		})

		vim.keymap.set("n", "<leader>dp", dap.step_back, {
			desc = "Step back",
		})

		vim.keymap.set("n", "<leader>dP", dap.pause, {
			desc = "Pause",
		})

		vim.keymap.set("n", "<leader>dr", dap.repl.toggle, {
			desc = "Toggle REPL",
		})

		vim.keymap.set("n", "<leader>dR", dap.run_last, {
			desc = "Run last",
		})

		vim.keymap.set("n", "<leader>dQ", dap.close, {
			desc = "Close session",
		})

		vim.keymap.set("n", "<leader>dD", dap.disconnect, {
			desc = "Disconnect from session",
		})

		vim.keymap.set("n", "<leader>du", dap.up, {
			desc = "Go up in stacktrace",
		})

		vim.keymap.set("n", "<leader>dd", dap.down, {
			desc = "Go down in stacktrace",
		})

		vim.keymap.set("n", "<leader>dk", dapwid.hover, { desc = "Hover" })

		vim.keymap.set("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, {
			desc = "Set breakpoint with condition",
		})
	end,
}
