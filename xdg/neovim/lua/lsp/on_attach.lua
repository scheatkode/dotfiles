return {
	setup = function()
		local extensions = require('lsp.extensions')

		return function(_, bufnr, _)
			-- if client.supports_method('textDocument/completion') then
			-- 	require('lsp.completion').setup(client, bufnr)
			-- end

			-- go to declaration
			vim.keymap.set('n', '<leader>cD', vim.lsp.buf.declaration, {
				buffer = bufnr,
				desc   = 'Go to declaration',
			})
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {
				buffer = bufnr,
				desc   = 'Go to declaration',
			})

			-- go to definition
			vim.keymap.set('n', '<leader>cd', vim.lsp.buf.definition, {
				buffer = bufnr,
				desc   = 'Go to definition',
			})
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
				buffer = bufnr,
				desc   = 'Go to definition',
			})

			-- go to type definition
			vim.keymap.set('n', '<leader>cT', vim.lsp.buf.type_definition, {
				buffer = bufnr,
				desc   = 'Go to type definition',
			})

			-- go to implementation
			vim.keymap.set('n', '<leader>ci', vim.lsp.buf.implementation, {
				buffer = bufnr,
				desc   = 'Go to implementation',
			})

			-- rename symbol
			vim.keymap.set('n', '<leader>cR', extensions.rename, {
				buffer = bufnr,
				desc   = 'Rename symbol under cursor',
			})
			vim.keymap.set('n', 'gR', extensions.rename, {
				buffer = bufnr,
				desc   = 'Rename symbol under cursor',
			})

			-- references
			vim.keymap.set('n', '<leader>cr', vim.lsp.buf.references, {
				buffer = bufnr,
				desc   = 'Show references',
			})
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, {
				buffer = bufnr,
				desc   = 'Show references',
			})

			-- code action
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {
				buffer = bufnr,
				desc   = 'Code actions',
			})
			vim.keymap.set('x', '<leader>ca', vim.lsp.buf.code_action, {
				buffer = bufnr,
				desc   = 'Range code actions',
			})

			-- hover documentation
			vim.keymap.set('n', '<leader>ch', vim.lsp.buf.hover, {
				buffer = bufnr,
				desc   = 'Show documentation',
			})
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, {
				buffer = bufnr,
				desc   = 'Show documentation',
			})

			-- call hierarchy
			vim.keymap.set('n', '<leader>cI', vim.lsp.buf.incoming_calls, {
				buffer = bufnr,
				desc   = 'Incoming calls',
			})
			vim.keymap.set('n', '<leader>cO', vim.lsp.buf.outgoing_calls, {
				buffer = bufnr,
				desc   = 'Outgoing calls',
			})

			-- diagnostics
			vim.keymap.set('n', '<leader>cl', vim.diagnostic.open_float, {
				buffer = bufnr,
				desc   = 'Show line diagnostics',
			})

			vim.keymap.set('n', '<leader>cL', vim.diagnostic.setloclist, {
				buffer = bufnr,
				desc   = 'Send diagnostics to loclist',
			})
			vim.keymap.set('n', '<leader>cq', vim.diagnostic.setqflist, {
				buffer = bufnr,
				desc   = 'Send diagnostics to qflist',
			})

			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
				buffer = bufnr,
				desc   = 'Go to previous diagnostic',
			})
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
				buffer = bufnr,
				desc   = 'Go to next diagnostic',
			})

			-- signature help
			-- vim.keymap.set({ 'n', 'i' }, '<M-s>', vim.lsp.buf.signature_help, {
			-- 	buffer = bufnr,
			-- 	desc   = 'Show signature help',
			-- })

			-- workspace management
			vim.keymap.set('n', '<leader>cwa', vim.lsp.buf.add_workspace_folder, {
				buffer = bufnr,
				desc   = 'Add folder to workspace',
			})
			vim.keymap.set('n', '<leader>cwd', vim.lsp.buf.remove_workspace_folder, {
				buffer = bufnr,
				desc   = 'Remove folder from workspace',
			})
			vim.keymap.set('n', '<leader>cwl', vim.lsp.buf.list_workspace_folders, {
				buffer = bufnr,
				desc   = 'Remove folder from workspace',
			})

			-- code formatting

			-- Special case for `null-ls` since it usually runs along with
			-- another LSP in the same buffer, if `null-ls` can format, let
			-- it do its thing. Otherwise fall back to the main LSP.
			local format = function()
				local buf = vim.api.nvim_get_current_buf()
				local fmt = #require('null-ls.sources').get_available(
					vim.bo[buf].filetype,
					'NULL_LS_FORMATTING'
				) > 0

				return vim.lsp.buf.format({
					async  = true,
					filter = function(current_client)
						if fmt then
							return current_client.name == 'null-ls'
						end

						return current_client.name ~= 'null-ls'
					end,
				})
			end

			vim.keymap.set({ 'n', 'x' }, '<leader>cf', format, {
				buffer = bufnr,
				desc   = 'Format code in current buffer',
			})
			vim.keymap.set({ 'n', 'x' }, '<leader>=', format, {
				buffer = bufnr,
				desc   = 'Format code in current buffer',
			})
		end
	end,
}
