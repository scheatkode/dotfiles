local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
   print('‼ Tried loading lspconfig for denols ... unsuccessfully.')
   return has_lspconfig
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
      enable   = true,
      lint     = true,
      unstable = false,
   },

   root_dir = lspconfig.util.root_pattern(
      'package.json',
      'tsconfig.json',
      '.git'
   )
}

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
