-- TODO(scheatkode): Add autoinstall with spinner animation

-- local formatters = {
--    'phpstan',
--    'psalm',
-- }

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
   cmd = { vim.fn.stdpath('data') .. '/lspinstall/efm/efm-langserver' },
   init_options = { documentFormatting = true },
   root_dir     = vim.loop.cwd,

   filetypes = {
      'lua',
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
   },

   settings     = {
      rootMarkers = { '.git/' },
      languages   = {

         c  = { require 'format.uncrustify' },
         cs = { require 'format.uncrustify' },

         css        = { require 'format.prettier' },
         html       = { require 'format.prettier' },
         javascript = { require 'format.prettier' },
         json       = { require 'format.prettier' },
         markdown   = { require 'format.prettier' },
         scss       = { require 'format.prettier' },
         typescript = { require 'format.prettier' },
         yaml       = { require 'format.prettier' },

         twig = { require 'format.twigcs' },

         -- sh = { require 'format.shellcheck'   },

         -- lua = { require 'format.luafmt'   },
         -- python = { require 'format.black' },

         php  = {
            require 'format.phpstan',
            require 'format.prettier',
            require 'format.psalm',
         },

         sql = { require 'format.sql-formatter' }
      }
   },

   post_attach = function (client, bufnr)
      normalize_keymaps {
         {
            mode         = 'n',
            keys         = '<leader>cf',
            description  = 'Format code',
            command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options)<CR>',
            command_saga = nil,
            condition    = client.resolved_capabilities.document_formatting
               or client.resolved_capabilities.document_range_formatting,
            options      = { buffer = bufnr },
         },

         {
            mode         = 'n',
            keys         = '<leader>=',
            description  = 'Format code',
            command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options)<CR>',
            command_saga = nil,
            condition    = client.resolved_capabilities.document_formatting
               or client.resolved_capabilities.document_range_formatting,
            options      = { buffer = bufnr },
         },

         {
            mode         = 'x',
            keys         = '<leader>cf',
            description  = 'Format code',
            command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
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
            command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
            command_saga = nil,
            condition    = client.resolved_capabilities.document_formatting
               or client.resolved_capabilities.document_range_formatting,
            options      = { buffer = bufnr },
         },
      }

   end,
}
