local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
   print('‼ Tried loading lspconfig for denols ... unsuccessfully.')
   return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
   cmd = {
      vim.fn.expand('~/.yarn/bin/typescript-language-server'),
      '--stdio'
   },

   filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
   },

   root_dir = lspconfig.util.root_pattern(
      "package.json",
      "tsconfig.json",
      "jsconfig.json",
      ".git"
   )
}
