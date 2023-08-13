return {
	setup = function()
		---Setup mappings and behavior for every attached language server.
		---@param client lsp.Client
		---@param bufnr number
		return function(client, bufnr)
			-- codelens
			if client.server_capabilities.codeLensProvider then
				vim.api.nvim_create_autocmd("InsertLeave", {
					group = vim.api.nvim_create_augroup(
						string.format("UserLspCodelens-%s", bufnr),
						{ clear = true }
					),
					buffer = bufnr,
					callback = vim.lsp.codelens.refresh,
				})
			end

			-- go to implementation
			-- Most LSPs don't bother with "textDocument/declaration", and
			-- rightfully so, it doesn't provide that much benefit. Prefer using
			-- "textDocument/implementation", which is more useful in certain
			-- cases. The go-to method remains "textDocument/definition".
			if client.server_capabilities.implementationProvider then
				vim.keymap.set("n", "gD", vim.lsp.buf.implementation, {
					buffer = bufnr,
					desc = "Go to implementation",
				})
			elseif client.server_capabilities.declarationProvider then
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
					buffer = bufnr,
					desc = "Go to declaration",
				})
			end

			-- signature help
			vim.keymap.set({ "i", "n" }, "<M-s>", vim.lsp.buf.signature_help, {
				buffer = bufnr,
				desc = "Show signature help",
			})

			-- rename symbol
			vim.keymap.set("n", "gR", require("lsp.extensions").rename, {
				buffer = bufnr,
				desc = "Rename symbol",
			})

			-- references
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {
				buffer = bufnr,
				desc = "Show references",
			})

			-- code action
			vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, {
				buffer = bufnr,
				desc = "Code actions",
			})

			-- hover documentation
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {
				buffer = bufnr,
				desc = "Show documentation",
			})

			-- call hierarchy
			vim.keymap.set("n", "<leader>cI", vim.lsp.buf.incoming_calls, {
				buffer = bufnr,
				desc = "Incoming calls",
			})
			vim.keymap.set("n", "<leader>cO", vim.lsp.buf.outgoing_calls, {
				buffer = bufnr,
				desc = "Outgoing calls",
			})

			-- workspace management
			vim.keymap.set(
				"n",
				"<leader>cwa",
				vim.lsp.buf.add_workspace_folder,
				{
					buffer = bufnr,
					desc = "Add folder to workspace",
				}
			)
			vim.keymap.set(
				"n",
				"<leader>cwd",
				vim.lsp.buf.remove_workspace_folder,
				{
					buffer = bufnr,
					desc = "Remove folder from workspace",
				}
			)
			vim.keymap.set(
				"n",
				"<leader>cwl",
				vim.lsp.buf.list_workspace_folders,
				{
					buffer = bufnr,
					desc = "Remove folder from workspace",
				}
			)

			-- code formatting

			-- Special case for `null-ls` since it usually runs along with
			-- another LSP in the same buffer, if `null-ls` can format, let
			-- it do its thing. Otherwise fall back to the main LSP.
			local format = function()
				local buf = vim.api.nvim_get_current_buf()
				local fmt = #require("null-ls.sources").get_available(
					vim.bo[buf].filetype,
					"NULL_LS_FORMATTING"
				) > 0

				return vim.lsp.buf.format({
					async = true,
					filter = function(current_client)
						if fmt then
							return current_client.name == "null-ls"
						end

						return current_client.name ~= "null-ls"
					end,
				})
			end

			vim.keymap.set({ "n", "x" }, "<leader>=", format, {
				buffer = bufnr,
				desc = "Format code in current buffer",
			})
		end
	end,
}
