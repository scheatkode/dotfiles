local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
local has_whichkey,  whichkey  = pcall(require, 'which-key')

local register_keymap = require('util').register_single_keymap

local has_saga = false

if not has_lspconfig then
   print('‼ Tried loading lspconfig for denols ... unsuccessfully.')
   return has_lspconfig
end

-- TODO(scheatkode): Put this somewhere else

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

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
   cmd = { vim.fn.expand('~/.local/bin/deno'), 'lsp' },

   filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
   },

   init_options = {
         enable = true,
           lint = true,
       unstable = true,
      importMap = './lib/artificer/import_map.json',
         config = './tsconfig.json'
   },

   root_dir = lspconfig.util.root_pattern(
      -- 'import_map.json',
      'package.json',
      'tsconfig.json',
      '.git'
   ),

   post_attach = function (client, bufnr)
      client.resolved_capabilities.document_formatting       = false
      client.resolved_capabilities.document_range_formatting = false

      normalize_keymaps {
         {
            mode         = 'n',
            keys         = '<leader>cf',
            description  = 'Format code',
            command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options or {})<CR>',
            command_saga = nil,
            options      = { buffer = bufnr },
         },

         {
            mode         = 'n',
            keys         = '<leader>=',
            description  = 'Format code',
            command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options or {})<CR>',
            command_saga = nil,
            options      = { buffer = bufnr },
         },

         {
            mode         = 'x',
            keys         = '<leader>cf',
            description  = 'Format code',
            command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
            command_saga = nil,
            options      = { buffer = bufnr },
         },

         {
            mode         = 'x',
            keys         = '<leader>=',
            description  = 'Format code',
            command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
            command_saga = nil,
            options      = { buffer = bufnr },
         },
      }
   end,
}
