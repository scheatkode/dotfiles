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
				culhl = "DiagnosticCulError"
			},
			DiagnosticSignWarn = {
				text = "‼",
				texthl = "DiagnosticWarn",
				linehl = "DiagnosticLineBackgroundWarn",
				culhl = "DiagnosticCulWarn"
			},
			DiagnosticSignInfo = {
				text = "ℹ",
				texthl = "DiagnosticInfo",
				linehl = "DiagnosticLineBackgroundInfo",
				culhl = "DiagnosticCulWarn"
			},
			DiagnosticSignHint = {
				text = "",
				texthl = "DiagnosticHint",
				linehl = "DiagnosticLineBackgroundHint",
				culhl = "DiagnosticCulWarn"
			},
		}

		local options = deep_extend("force", defaults, overrides or {})

		for k, v in pairs(options) do
			vim.fn.sign_define(k, v)
		end
	end,
}
