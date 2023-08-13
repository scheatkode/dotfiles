return {
	setup = function()
		local extensions = require("lsp.extensions")

		return function(_, bufnr, _)
			-- go to type definition
			vim.keymap.set("n", "<leader>cT", vim.lsp.buf.type_definition, {
				buffer = bufnr,
				desc = "Go to type definition",
			})

			-- go to implementation
			vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, {
				buffer = bufnr,
				desc = "Go to implementation",
			})

			-- rename symbol
			vim.keymap.set("n", "<leader>cR", extensions.rename, {
				buffer = bufnr,
				desc = "Rename symbol under cursor",
			})
			vim.keymap.set("n", "gR", extensions.rename, {
				buffer = bufnr,
				desc = "Rename symbol under cursor",
			})

			-- references
			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, {
				buffer = bufnr,
				desc = "Show references",
			})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {
				buffer = bufnr,
				desc = "Show references",
			})

			-- code action
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
				buffer = bufnr,
				desc = "Code actions",
			})
			vim.keymap.set("x", "<leader>ca", vim.lsp.buf.code_action, {
				buffer = bufnr,
				desc = "Range code actions",
			})

			-- hover documentation
			vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, {
				buffer = bufnr,
				desc = "Show documentation",
			})
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
