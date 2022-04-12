local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
   print('‼ Tried loading lspconfig for salt_ls ... unsuccessfully.')
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
         'salt_ls',
         'venv',
         'bin',
         'salt_lsp_server',
      }, '/')),
   }
}
