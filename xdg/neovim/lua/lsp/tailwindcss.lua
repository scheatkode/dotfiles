return {
   cmd = {
      vim.fn.expand(table.concat({'~',
         '.local',
         'share',
         'nvim',
         'lsp_servers',
         'tailwindcss_npm',
         'node_modules',
         -- '@tailwindcss',
         -- 'language-server',
         '.bin',
         'tailwindcss-language-server',
      }, '/')),
      '--stdio',
   },
}
