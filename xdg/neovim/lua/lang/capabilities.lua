return {
	setup = function()
		local wanted = {
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
								'documentation',
								'detail',
								'additionalTextEdits',
							},
						},
						snippetSupport = true,
						tagSupport     = {
							valueSet = {
								1,
							},
						},
					},
				},
			},
		}

		return wanted
	end,
}
