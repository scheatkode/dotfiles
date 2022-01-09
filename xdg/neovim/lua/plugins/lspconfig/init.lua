return { 'neovim/nvim-lspconfig', opt = true,
   event = { 'BufReadPre' },
   cmd   = {
      'LspStatus',
      'LspStart',
      'LspInfo',
   },
   module = { 'lspconfig' },
   config = function ()
      require('plugins.lspconfig.config')
   end,
}
