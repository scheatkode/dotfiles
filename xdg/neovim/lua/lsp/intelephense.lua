-- TODO(scheatkode): Add autoinstall with spinner animation

return {
   cmd = {
       table.concat({
         vim.fn.stdpath('data'),
         'lsp_servers',
         'php',
         'node_modules',
         '.bin',
         'intelephense'
      }, '/'),
      '--stdio'
   }
}
