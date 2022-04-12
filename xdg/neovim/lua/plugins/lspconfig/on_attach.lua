--- localise vim globals

local vapi = vim.api
local vlsp = vim.lsp

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

local register_keymap = require('util').register_single_keymap

local normalize_keymaps = function (mappings)
   for _, mapping in ipairs(mappings) do
      local mode         = mapping.mode
      local keys         = mapping.keys
      -- local description  = mapping.description
      local command      = mapping.command
      local condition    = mapping.condition
      local options      = mapping.options

      local is_command_valid =
             command ~= nil
         and command ~= false
         and command ~= ''

      local is_condition_valid = condition ~= nil and condition ~= false

      if is_command_valid and is_condition_valid then
         register_keymap {
            mode    = mode,
            keys    = keys,
            command = command,
            options = options,
         }
      end
   end
end

return function (client, bufnr, settings)

   -- omnifunc setup {{{2

   vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

   -- border customization {{{2

   vlsp.handlers['textDocument/hover']         = vlsp.with(vlsp.handlers.hover, {border = border})
   vlsp.handlers['textDocument/signatureHelp'] = vlsp.with(vlsp.handlers.hover, {border = border})

   -- mappings {{{2

   normalize_keymaps {

      -- declaration {{{3

      {
         mode         = 'n',
         keys         = '<leader>cD',
         description  = 'Declaration',
         command      = '<cmd>lua vim.lsp.buf.declaration()<CR>',
         condition    = client.resolved_capabilities.declaration,
         options      = { buffer = bufnr },
      },

      -- definition {{{3

      {
         mode         = 'n',
         keys         = '<leader>cd',
         description  = 'Definition',
         command      = '<cmd>lua vim.lsp.buf.definition()<CR>',
         condition    = client.resolved_capabilities.goto_definition,
         options      = { buffer = bufnr },
      },

      -- type definition {{{3

      {
         mode         = 'n',
         keys         =  '<leader>cT',
         description  = 'Type definition',
         command      = '<cmd>lua vim.lsp.buf.type_definition()<CR>',
         condition    = client.resolved_capabilities.type_definition,
         options      = { buffer = bufnr },
      },

      -- implementation {{{3

      {
         mode         = 'n',
         keys         = '<leader>ci',
         description  = 'Implementation',
         command      = '<cmd>lua vim.lsp.buf.implementation()<CR>',
         condition    = client.resolved_capabilities.implementation,
         options      = { buffer = bufnr },
      },

      -- rename symbol {{{3

      {
         mode         = 'n',
         keys         = '<leader>cR',
         description  = 'Rename symbol',
         command      = extensions.rename,
         condition    = client.resolved_capabilities.rename,
         options      = { buffer = bufnr },
      },

      -- references {{{3

      {
         mode         = 'n',
         keys         = '<leader>cr',
         description  = 'References',
         command      = '<cmd>lua vim.lsp.buf.references()<CR>',
         condition    = client.resolved_capabilities.references,
         options      = { buffer = bufnr },
      },

      -- code action {{{3

      -- {
      --    mode         = 'n',
      --    keys         = '<leader>ca',
      --    description  = 'Code action',
      --    command      = '<cmd>lua vim.lsp.buf.code_action()<CR>',
      --    condition    = client.resolved_capabilities.code_action,
      --    options      = { buffer = bufnr },
      -- },

      {
         mode         = 'x',
         keys         = '<leader>ca',
         description  = 'Code action',
         command      = '<cmd>lua vim.lsp.buf.code_action()<CR>',
         condition    = client.resolved_capabilities.code_action,
         options      = { buffer = bufnr },
      },

      -- hover documentation {{{3

      {
         mode         = 'n',
         keys         = '<leader>ch',
         description  = 'Hover documentation',
         command      = '<cmd>lua vim.lsp.buf.hover()<CR>',
         condition    = client.resolved_capabilities.hover,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = 'K',
         description  = 'Hover documentation',
         command      = '<cmd>lua vim.lsp.buf.hover()<CR>',
         condition    = client.resolved_capabilities.hover,
         options      = { buffer = bufnr },
      },

      -- call hierarchy {{{3

      {
         mode         = 'n',
         keys         = '<leader>cI',
         description  = 'Incoming calls',
         command      = '<cmd>lua vim.lsp.buf.incoming_calls()<CR>',
         condition    = client.resolved_capabilities.call_hierarchy,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = '<leader>cO',
         description  = 'Outgoing calls',
         command      = '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>',
         condition    = client.resolved_capabilities.call_hierarchy,
         options      = { buffer = bufnr },
      },

      -- diagnostics {{{3

      {
         mode         = 'n',
         keys         = '<leader>cl',
         description  = 'Line diagnostics',
         command      = '<cmd>lua vim.diagnostic.open_float(nil, {border = "rounded"})<CR>',
         condition    = true,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = '<leader>cL',
         description  = 'Send diagnostics to loclist',
         command      = '<cmd>lua vim.diagnostic.setloclist()<CR>',
         condition    = true,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = '<leader>cq',
         description  = 'Send diagnostics to quickfix list',
         command      = '<cmd>lua vim.diagnostic.setqflist()<CR>',
         condition    = true,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = '[d',
         description  = 'Go to previous diagnostic',
         command      = '<cmd>lua vim.diagnostic.goto_prev({popup_opts = {border = "rounded"}})<CR>',
         condition    = true,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = ']d',
         description  = 'Go to next diagnostic',
         command      = '<cmd>lua vim.diagnostic.goto_next({popup_opts = {border = "rounded"}})<CR>',
         condition    = true,
         options      = { buffer = bufnr },
      },

      -- signature help {{{3

      {
         mode         = 'n',
         keys         = '<M-s>',
         description  = 'Signature help',
         command      = '<cmd>lua vim.lsp.buf.signature_help()<CR>',
         condition    = client.resolved_capabilities.signature_help,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'i',
         keys         = '<M-s>',
         description  = 'Signature help',
         command      = '<cmd>lua vim.lsp.buf.signature_help()<CR>',
         condition    = client.resolved_capabilities.signature_help,
         options      = { buffer = bufnr },
      },

      -- workspace management {{{3

      {
         mode         = 'n',
         keys         = '<leader>cwa',
         description  = 'Add folder to workspace',
         command      = '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
         condition    = client.resolved_capabilities.workspace_folder_properties,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = '<leader>cwd',
         description  = 'Remove folder from workspace',
         command      = '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
         condition    = client.resolved_capabilities.workspace_folder_properties,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = '<leader>cwl',
         description  = 'List folders in workspace',
         command      = '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
         condition    = client.resolved_capabilities.workspace_folder_properties,
         options      = { buffer = bufnr },
      },

      -- code formatting {{{3

      {
         mode         = 'n',
         keys         = '<leader>cf',
         description  = 'Format code',
         command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
         condition    = client.resolved_capabilities.document_formatting
            or client.resolved_capabilities.document_range_formatting,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = '<leader>=',
         description  = 'Format code',
         command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
         condition    = client.resolved_capabilities.document_formatting
            or client.resolved_capabilities.document_range_formatting,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'x',
         keys         = '<leader>cf',
         description  = 'Format code',
         command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
         condition    = client.resolved_capabilities.document_formatting
            or client.resolved_capabilities.document_range_formatting,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'x',
         keys         = '<leader>=',
         description  = 'Format code',
         command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
         condition    = client.resolved_capabilities.document_formatting
            or client.resolved_capabilities.document_range_formatting,
         options      = { buffer = bufnr },
      },

      -- }}}

   }

   -- autocommands {{{2

   if client.resolved_capabilities.document_highlight then
      vapi.nvim_exec([[
         :hi LspReferenceRead  cterm=bold ctermbg=red guibg=LightYellow
         :hi LspReferenceText  cterm=bold ctermbg=red guibg=LightYellow
         :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow

         augroup lsp_document_highlight
         autocmd! *           <buffer>
         autocmd  CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
         autocmd  CursorMoved <buffer> lua vim.lsp.buf.clear_references()
         augroup End
      ]], false)
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
