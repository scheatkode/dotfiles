local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
   print('‼ Tried loading lspconfig for rust_analyzer ... unsuccessfully.')
   return has_lspconfig
end

return {
   cmd = { vim.fn.stdpath('data') .. '/lsp_servers/rust/rust-analyzer' },
   filetypes = { 'rust' },
   settings = {
      ['rust-analyzer'] = {},
   },
}
