local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
   print('‼ Tried loading lspconfig for jsonls ... unsuccessfully.')
   return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
   cmd       = { vim.fn.expand('~/.yarn/bin/jsonls'), '--stdio' },
   filetypes = { 'json' },
   root_dir  = lspconfig.util.root_pattern('.git', vim.fn.getcwd())
}
