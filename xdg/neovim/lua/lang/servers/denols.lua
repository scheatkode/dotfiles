local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
   print('‼ Tried loading lspconfig for denols ... unsuccessfully.')
   return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
   -- cmd = { vim.fn.expand('~/.local/bin/deno'), 'lsp' },
   cmd = { 'deno', 'lsp' },

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
      'deno.json',
      'deno.jsonc',
      'package.json',
      'tsconfig.json',
      '.git'
   ),

   post_attach = function (client, _)
      client.resolved_capabilities.document_formatting       = false
      client.resolved_capabilities.document_range_formatting = false
   end,
}
