local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
   print('‼ Tried loading lspconfig for perlpls ... unsuccessfully.')
   return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
   root_dir = function (filename)
      return lspconfig.util.root_pattern(
         'cpanfile',
         'cpanfile.snapshot',
         '.git'
      )(filename)
   end,

   settings = {
      perl = {
         perlcritic = {
            enabled = true,
         },
      },
   },
}
