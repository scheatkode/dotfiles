return {
	setup = function(options)
		local extend = require("tablex.extend")

		local defaults = {
			"", -- Text        = 1
			"ƒ", -- Method      = 2
			"", -- Function    = 3
			"", -- Constructor = 4
			"", -- Variable    = 5
			"", -- Class       = 6
			"ﰮ", -- Interface   = 7
			"", -- Module      = 8
			"ﰠ", -- Property    = 9
			"", -- Unit        = 10
			"", -- Value       = 11
			"", -- Enum        = 12
			"", -- Keyword     = 13
			"", -- Snippet     = 14
			"", -- Color       = 15
			"", -- File        = 16
			"", -- Folder      = 17
			"", -- EnumMember  = 18
			"", -- Constant    = 19
			"פּ", -- Struct      = 20
		}

		vim.lsp.protocol.CompletionItemKind = extend(defaults, options)
	end,
}
