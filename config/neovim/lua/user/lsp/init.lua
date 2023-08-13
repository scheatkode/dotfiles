return {
	---Setup LSP related stuff.
	setup = function()
		local hooks = require("user.lsp.hooks")

		--- protocol tweaks
		vim.lsp.protocol.CompletionItemKind = {
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

		-- custom lsp handlers
		vim.lsp.handlers["textDocument/publishDiagnostics"] =
			vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
				signs = true,
				underline = true,
				update_in_insert = false,
			})
		vim.lsp.handlers["textDocument/codeLens"] =
			vim.lsp.with(vim.lsp.codelens.on_codelens, {
				virtual_text = {
					prefix = "»",
					spacing = 3,
				},
				update_in_insert = false,
			})

		-- lsp hooks & config
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = hooks["on_attach"],
			group = vim.api.nvim_create_augroup(
				"UserLspAttach",
				{ clear = true }
			),
		})
		vim.api.nvim_create_autocmd("LspDetach", {
			callback = hooks["on_detach"],
			group = vim.api.nvim_create_augroup(
				"UserLspDetach",
				{ clear = true }
			),
		})
	end,
}
