-- TODO(scheatkode): Add autoinstall with spinner animation

return {
   cmd = {
      vim.fn.stdpath('data') .. table.concat({
         '.local',
         'share',
         'nvim',
         'lsp_servers',
         'php',
         'node_modules',
         '.bin',
         'intelephense'
      })
   }
}
