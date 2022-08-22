local ternary = require('f.function.ternary')

local extensions = require('lang.extensions')

local border = {

	--- rounded border
	{ '╭', 'FloatBorder' },
	{ '─', 'FloatBorder' },
	{ '╮', 'FloatBorder' },
	{ '│', 'FloatBorder' },
	{ '╯', 'FloatBorder' },
	{ '─', 'FloatBorder' },
	{ '╰', 'FloatBorder' },
	{ '│', 'FloatBorder' },

	--- square border
	-- {'┌', 'FloatBorder'},
	-- {'─', 'FloatBorder'},
	-- {'┐', 'FloatBorder'},
	-- {'│', 'FloatBorder'},
	-- {'┘', 'FloatBorder'},
	-- {'─', 'FloatBorder'},
	-- {'└', 'FloatBorder'},
	-- {'│', 'FloatBorder'},

}

return function(client, bufnr, settings)

	-- omnifunc setup {{{2

	vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

	-- border customization {{{2

	vim.lsp.handlers['textDocument/hover']         = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })

	-- mappings {{{2

	-- declaration {{{3
	vim.keymap.set('n', '<leader>cD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Go to declaration' })

	-- definition {{{3
	vim.keymap.set('n', '<leader>cd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to definition' })

	-- type definition {{{3
	vim.keymap.set('n', '<leader>cT', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'Go to type definition' })

	-- implementation {{{3
	vim.keymap.set('n', '<leader>ci', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Go to implementation' })

	-- rename symbol {{{3
	vim.keymap.set('n', '<leader>cR', extensions.rename, { buffer = bufnr, desc = 'Rename symbol under cursor' })

	-- references {{{3
	vim.keymap.set('n', '<leader>cr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Show references' })

	-- code action {{{3
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code actions' })
	vim.keymap.set('x', '<leader>ca', vim.lsp.buf.range_code_action, { buffer = bufnr, desc = 'Range code actions' })

	-- hover documentation {{{3
	vim.keymap.set('n', '<leader>ch', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Show documentation' })
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Show documentation' })

	-- call hierarchy {{{3
	vim.keymap.set('n', '<leader>cI', vim.lsp.buf.incoming_calls, { buffer = bufnr, desc = 'Incoming calls' })
	vim.keymap.set('n', '<leader>cO', vim.lsp.buf.outgoing_calls, { buffer = bufnr, desc = 'Outgoing calls' })

	-- diagnostics {{{3
	vim.keymap.set('n', '<leader>cl', function() vim.diagnostic.open_float(nil, { border = 'rounded' }) end,
		{ buffer = bufnr, desc = 'Show line diagnostics' })

	vim.keymap.set('n', '<leader>cL', vim.diagnostic.setloclist, { buffer = bufnr, desc = 'Send diagnostics to loclist' })
	vim.keymap.set('n', '<leader>cq', vim.diagnostic.setqflist, { buffer = bufnr, desc = 'Send diagnostics to qflist' })

	vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev({ float = false }) end,
		{ buffer = bufnr, desc = 'Go to previous diagnostic' })
	vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next({ float = false }) end,
		{ buffer = bufnr, desc = 'Go to next diagnostic' })

	-- signature help {{{3
	vim.keymap.set({ 'n', 'x' }, '<M-s>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Show signature help' })

	-- workspace management {{{3
	vim.keymap.set('n', '<leader>cwa', vim.lsp.buf.add_workspace_folder,
		{ buffer = bufnr, desc = 'Add folder to workspace' })
	vim.keymap.set('n', '<leader>cwd', vim.lsp.buf.remove_workspace_folder,
		{ buffer = bufnr, desc = 'Remove folder from workspace' })
	vim.keymap.set('n', '<leader>cwl', vim.lsp.buf.list_workspace_folders,
		{ buffer = bufnr, desc = 'Remove folder from workspace' })

	-- code formatting {{{3
	-- TODO(0.8): Remove the condition once `0.8` lands.
	local format = ternary(
		vim.lsp.buf.format == nil,
		function() return vim.lsp.buf.formatting end,
		function() return function()
			return vim.lsp.buf.format({ async = true })
		end end
	)

	vim.keymap.set({ 'n', 'x' }, '<leader>cf', format, { buffer = bufnr, desc = 'Format code in current buffer' })
	vim.keymap.set({ 'n', 'x' }, '<leader>=', format, { buffer = bufnr, desc = 'Format code in current buffer' })

	-- }}}

	-- autocommands {{{2

	if client.server_capabilities.documentHighlightProvider then
		local augroup = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
		vim.api.nvim_create_autocmd('CursorHold', { buffer = 0, group = augroup, callback = vim.lsp.buf.document_highlight })
		vim.api.nvim_create_autocmd('CursorMoved', { buffer = 0, group = augroup, callback = vim.lsp.buf.clear_references })
	end

	-- plugins {{{2

	local has_signature, signature = pcall(require, 'lsp_signature')

	if has_signature then
		signature.on_attach()
	end

	local has_status, status = pcall(require, 'lsp-status')

	if has_status and settings then
		vim.tbl_extend('keep', settings.capabilities or {}, status.capabilities)
		status.on_attach(client)
	end

	-- }}}

end
