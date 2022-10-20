return {
	setup = function(overrides)
		local deep_extend = require('tablex.deep_extend')

		local defaults = {
			['textDocument/publishDiagnostics'] = vim.lsp.with(
				vim.lsp.diagnostic.on_publish_diagnostics,
				{
					signs            = true,
					underline        = true,
					update_in_insert = false,
				}
			)
		}

		local options = deep_extend('force', defaults, overrides or {})

		for k, v in pairs(options) do
			vim.lsp.handlers[k] = v
		end
	end
}
