return {
	---Apply the given diagnostic signs configuration, or the
	---defaults otherwise.
	---
	---@param overrides? table options table
	setup = function(overrides)
		vim.diagnostic.config({
			signs = true,
			underline = false,
			update_in_insert = false,
			virtual_text = false,
			float = {
				source = "always",
			},
		})

		local deep_extend = require("tablex.deep_extend")
		local defaults = {
			DiagnosticSignError = {
				text = "",
				texthl = "DiagnosticError",
				linehl = "DiagnosticLineBackgroundError",
			},
			DiagnosticSignWarn = {
				text = "‼",
				texthl = "DiagnosticWarn",
				linehl = "DiagnosticLineBackgroundWarn",
			},
			DiagnosticSignInfo = {
				text = "ℹ",
				texthl = "DiagnosticInfo",
				linehl = "DiagnosticLineBackgroundInfo",
			},
			DiagnosticSignHint = {
				text = "",
				texthl = "DiagnosticHint",
				linehl = "DiagnosticLineBackgroundHint",
			},
		}

		local options = deep_extend("force", defaults, overrides or {})

		for k, v in pairs(options) do
			vim.fn.sign_define(k, v)
		end
	end,
}
