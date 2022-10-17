return {
	setup = function(options)
		local f      = require('f')
		local tablex = require('tablex')

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
			 .iterate(tablex.deep_extend('force', defaults, options or {}))
			 :foreach(function( k, v) vim.lsp.handlers[k] = v end)
	end
}
