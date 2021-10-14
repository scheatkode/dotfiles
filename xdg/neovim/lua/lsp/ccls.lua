-- TODO(scheatkode): Add autoinstall with spinner animation

local has_whichkey, whichkey = pcall(require, 'which-key')
local register_keymap = require('util').register_single_keymap
local has_saga = false

local normalize_keymaps = function (mappings)
   for _, mapping in ipairs(mappings) do
      local mode         = mapping.mode
      local keys         = mapping.keys
      local description  = mapping.description
      local command      = mapping.command
      local command_saga = mapping.command_saga
      local condition    = mapping.condition
      local options      = mapping.options

      if
             has_saga
         and command_saga ~= nil
      then
         command = command_saga
      end

      if
             command   ~= nil
         and command   ~= ''
         and command   ~= false
         and condition ~= nil
         and condition ~= false
      then
         register_keymap {
            mode    = mode,
            keys    = keys,
            command = command,
            options = options,
         }

         if has_whichkey then
            whichkey.register({
               [keys] = description
            }, {
               mode   = mode,
               buffer = options.buffer
            })
         end
      end
   end
end


return {
   -- cmd = { vim.fn.expand('~/repositories/stolen/ccls/Release/ccls') },
   cmd = { vim.fn.expand('/usr/bin/ccls') },

   post_attach = function (client, bufnr)
      normalize_keymaps {
         {
            mode         = 'n',
            keys         = '<leader>cf',
            description  = 'Format code',
            -- command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_csharp)<CR>',
            command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_uncrustify)<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
            command_saga = nil,
            condition    = client.resolved_capabilities.document_formatting
               or client.resolved_capabilities.document_range_formatting,
            options      = { buffer = bufnr },
         },

         {
            mode         = 'n',
            keys         = '<leader>=',
            description  = 'Format code',
            -- command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_csharp)<CR>',
            command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_uncrustify)<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
            command_saga = nil,
            condition    = client.resolved_capabilities.document_formatting
               or client.resolved_capabilities.document_range_formatting,
            options      = { buffer = bufnr },
         },

         {
            mode         = 'x',
            keys         = '<leader>cf',
            description  = 'Format code',
            -- command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_csharp)<CR>',
            command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_uncrustify)<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
            command_saga = nil,
            condition    = client.resolved_capabilities.document_formatting
               or client.resolved_capabilities.document_range_formatting,
            options      = { buffer = bufnr },
         },

         {
            mode         = 'x',
            keys         = '<leader>=',
            description  = 'Format code',
            -- command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_csharp)<CR>',
            command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_uncrustify)<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
            command_saga = nil,
            condition    = client.resolved_capabilities.document_formatting
               or client.resolved_capabilities.document_range_formatting,
            options      = { buffer = bufnr },
         },
      }

   end,
}
