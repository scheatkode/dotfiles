return {
	---Apply the given diagnostic signs configuration, or the
	---defaults otherwise.
	---
	---@param overrides? table options table
	setup = function(overrides)
		local tx = require("tablex")

		vim.diagnostic.config({
			signs = true,
			underline = false,
			update_in_insert = false,
			virtual_text = false,
			float = {
				source = "always",
			},
		})

		local defaults = {
			DiagnosticSignError = {
				text = " ",
				texthl = "DiagnosticError",
				linehl = "DiagnosticLineBackgroundError",
				culhl = "DiagnosticCulError",
			},
			DiagnosticSignWarn = {
				text = " ",
				texthl = "DiagnosticWarn",
				linehl = "DiagnosticLineBackgroundWarn",
				culhl = "DiagnosticCulWarn",
			},
			DiagnosticSignInfo = {
				text = " ",
				texthl = "DiagnosticInfo",
				linehl = "DiagnosticLineBackgroundInfo",
				culhl = "DiagnosticCulWarn",
			},
			DiagnosticSignHint = {
				text = " ",
				texthl = "DiagnosticHint",
				linehl = "DiagnosticLineBackgroundHint",
				culhl = "DiagnosticCulWarn",
			},
		}

		local options = tx.deep_extend("force", defaults, overrides or {})

		for k, v in pairs(options) do
			vim.fn.sign_define(k, v)
		end

		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
			desc = "Go to previous diagnostic",
		})
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
			desc = "Go to next diagnostic",
		})

		vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, {
			desc = "Show line diagnostics",
		})
		vim.keymap.set("n", "<leader>dL", vim.diagnostic.setloclist, {
			desc = "Send diagnostics to loclist",
		})
		vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, {
			desc = "Send diagnostics to qflist",
		})
	end,
}
