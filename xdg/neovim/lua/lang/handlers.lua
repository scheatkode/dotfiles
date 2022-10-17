return {
	setup = function(options)
		local f           = require('f')
		local deep_extend = require('tablex.deep_extend')

		local defaults = {
			['textDocument/publishDiagnostics'] = vim.lsp.with(
				vim.lsp.diagnostic.on_publish_diagnostics, {
				virtual_text = {
				   prefix  = '»',
				   spacing = 3,
				},

				underline = true,

				signs = true,
				update_in_insert = false,
			}
			)
		}

		f
			 .iterate(deep_extend('force', defaults, options or {}))
			 :foreach(function( k, v) vim.lsp.handlers[k] = v end)
	end
}
