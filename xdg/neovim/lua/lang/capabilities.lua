return {
	---@param overrides table|nil
	setup = function(overrides)
		local deep_extend = require('tablex.deep_extend')

		local capabilities = {
			textDocument = {
				completion = {
					completionItem = {
						commitCharactersSupport = true,
						deprecatedSupport       = true,
						documentationFormat     = {
							'markdown',
							'plaintext',
						},
						insertReplaceSupport = true,
						labelDetailsSupport  = true,
						preselectSupport     = true,
						resolveSupport       = {
							properties = {
								'additionalTextEdits',
								'documentation',
								'detail',
								'edit',
							},
						},
						snippetSupport = true,
						tagSupport     = {
							valueSet = {
								1,
							},
						},
					},
					completionList = {
						itemDefaults = {
							'editRange',
							'data',
							'insertTextFormat',
							'insertTextMode',
						},
					},
				},
			},
		}

		return deep_extend(
			'force',
			vim.lsp.protocol.make_client_capabilities(),
			capabilities,
			overrides or {}
		)
	end,
}
