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

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
