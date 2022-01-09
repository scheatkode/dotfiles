local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
   print('‼ Tried loading lspconfig for jsonls ... unsuccessfully.')
   return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

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
   filetypes = { 'json' },
   root_dir  = lspconfig.util.root_pattern('.git', vim.fn.getcwd())
}
