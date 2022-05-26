local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
   print('‼ Tried loading lspconfig for jsonls ... unsuccessfully.')
   return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

local has_schemastore, schemastore = pcall(require, 'schemastore')

if not has_schemastore then
   print('! Schemastore not found, autocompletion will be unavailable.')
end

return {
   cmd = {
      vim.fn.expand(table.concat({'~',
         '.local',
         'share',
         'nvim',
         'lsp_servers',
         'jsonls',
         'node_modules',
         '.bin',
         'vscode-json-language-server',
      }, '/')),
      '--stdio'
   },

   filetypes = {
   	'json',
   	'jsonc',
   },

   root_dir  = lspconfig.util.root_pattern('.git', vim.fn.getcwd()),

   settings = (function ()
      if not has_schemastore then
         return nil
      end

      return {
         json = {
            schemas = schemastore.json.schemas(),
         },
      }
   end)(),
}
