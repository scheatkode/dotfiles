--- localise vim globals

local extensions = require('lang.extensions')

local border = {

   --- rounded border
   {'╭', 'FloatBorder'},
   {'─', 'FloatBorder'},
   {'╮', 'FloatBorder'},
   {'│', 'FloatBorder'},
   {'╯', 'FloatBorder'},
   {'─', 'FloatBorder'},
   {'╰', 'FloatBorder'},
   {'│', 'FloatBorder'},

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

return function (client, bufnr, settings)

   -- omnifunc setup {{{2

   vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

   -- border customization {{{2

   vim.lsp.handlers['textDocument/hover']         = vim.lsp.with(vim.lsp.handlers.hover, {border = border})
   vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.hover, {border = border})

   -- mappings {{{2

   -- declaration {{{3
   if client.resolved_capabilities.declaration then
      vim.keymap.set('n', '<leader>cD', vim.lsp.buf.declaration, {buffer = bufnr, desc = 'Go to declaration'})
   end

   -- definition {{{3
   if client.resolved_capabilities.goto_definition then
      vim.keymap.set('n', '<leader>cd', vim.lsp.buf.definition, {buffer = bufnr, desc = 'Go to definition'})
   end

   -- type definition {{{3
   if client.resolved_capabilities.type_definition then
      vim.keymap.set('n', '<leader>cT', vim.lsp.buf.type_definition, {buffer = bufnr, desc = 'Go to type definition'})
   end

   -- implementation {{{3
   if client.resolved_capabilities.implementation then
      vim.keymap.set('n', '<leader>ci', vim.lsp.buf.implementation, {buffer = bufnr, desc = 'Go to implementation'})
   end

   -- rename symbol {{{3
   if client.resolved_capabilities.rename then
      vim.keymap.set('n', '<leader>cR', extensions.rename, {buffer = bufnr, desc = 'Rename symbol under cursor'})
   end

   -- references {{{3
   if client.resolved_capabilities.references then
      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.references, {buffer = bufnr, desc = 'Show references'})
   end

   -- code action {{{3
   if client.resolved_capabilities.code_action then
      vim.keymap.set('x', '<leader>ca', vim.lsp.buf.code_action, {buffer = bufnr, desc = 'Code actions'})
   end

   -- hover documentation {{{3
   if client.resolved_capabilities.hover then
      vim.keymap.set('n', '<leader>ch', vim.lsp.buf.hover, {buffer = bufnr, desc = 'Show documentation'})
      vim.keymap.set('n', 'K',          vim.lsp.buf.hover, {buffer = bufnr, desc = 'Show documentation'})
   end

   -- call hierarchy {{{3
   if client.resolved_capabilities.call_hierarchy then
      vim.keymap.set('n', '<leader>cI', vim.lsp.buf.incoming_calls,    {buffer = bufnr, desc = 'Incoming calls'})
      vim.keymap.set('n', '<leader>cO', vim.lsp.buf.outoutgoing_calls, {buffer = bufnr, desc = 'Outgoing calls'})
   end

   -- diagnostics {{{3
   vim.keymap.set('n', '<leader>cl', function () vim.diagnostic.open_float(nil, {border = 'rounded'}) end, {buffer = bufnr, desc = 'Show line diagnostics'})

   vim.keymap.set('n', '<leader>cL', vim.diagnostic.setloclist, {buffer = bufnr, desc = 'Send diagnostics to loclist'})
   vim.keymap.set('n', '<leader>cq', vim.diagnostic.setqflist,  {buffer = bufnr, desc = 'Send diagnostics to qflist'})

   vim.keymap.set('n', '[d', function () vim.diagnostic.goto_prev({popup_opts = {border = 'ronded'}}) end, {buffer = bufnr, desc = 'Go to previous diagnostic'})
   vim.keymap.set('n', ']d', function () vim.diagnostic.goto_next({popup_opts = {border = 'ronded'}}) end, {buffer = bufnr, desc = 'Go to next diagnostic'})

   -- signature help {{{3
   if client.resolved_capabilities.signature_help then
      vim.keymap.set({'n', 'x'}, '<M-s>', vim.lsp.buf.signature_help, {buffer = bufnr, desc = 'Show signature help'})
   end

   -- workspace management {{{3
   if client.resolved_capabilities.workspace_folder_properties then
      vim.keymap.set('n', '<leader>cwa', vim.lsp.buf.add_workspace_folder,    {buffer = bufnr, desc = 'Add folder to workspace'})
      vim.keymap.set('n', '<leader>cwd', vim.lsp.buf.remove_workspace_folder, {buffer = bufnr, desc = 'Remove folder from workspace'})
      vim.keymap.set('n', '<leader>cwl', vim.lsp.buf.list_workspace_folders,  {buffer = bufnr, desc = 'Remove folder from workspace'})
   end

   -- code formatting {{{3
   if client.resolved_capabilities.document_formatting or client.resolved_capabilities.document_range_formatting then
      vim.keymap.set({'n', 'x'}, '<leader>cf', vim.lsp.buf.formatting, {buffer = bufnr, desc = 'Format code in current buffer'})
      vim.keymap.set({'n', 'x'}, '<leader>=',  vim.lsp.buf.formatting, {buffer = bufnr, desc = 'Format code in current buffer'})
   end

   -- }}}

   -- autocommands {{{2

   if client.resolved_capabilities.document_highlight then
      local augroup = vim.api.nvim_create_augroup('lsp_document_highlight', {clear = true})
      vim.api.nvim_create_autocmd('CursorHold',  {buffer = 0, group = augroup, callback = vim.lsp.buf.document_highlight})
      vim.api.nvim_create_autocmd('CursorMoved', {buffer = 0, group = augroup, callback = vim.lsp.buf.clear_references})
   end

   -- plugins {{{2

   local has_signature, signature = pcall(require, 'lsp_signature')

   if has_signature then
      signature.on_attach()
   end

   local has_status, status = pcall(require, 'lsp-status')

   if has_status then
      vim.tbl_extend('keep', settings.capabilities or {}, status.capabilities)
      status.on_attach(client)
   end

   -- }}}

end
