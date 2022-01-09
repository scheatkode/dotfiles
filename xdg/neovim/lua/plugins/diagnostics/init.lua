local has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register({
      ['<leader>clt']  = { 'Enable diagnostics'           },
      ['<leader>cltw'] = { 'Enable workspace diagnostics' },
      ['<leader>cltd'] = { 'Enable document diagnostics'  },
      ['<leader>cltq'] = { 'Enable quickfix diagnostics'  },
      ['<leader>cltl'] = { 'Enable loclist diagnostics'   },
      ['<leader>cltr'] = { 'Enable references'            },
   })
end

return {'folke/lsp-trouble.nvim', opt = true,
   cmd = {
      'Trouble',
      'TroubleClose',
      'TroubleToggle',
      'LspTroubleToggle',
      'LspTroubleWorkspaceToggle',
   },
   keys = {
      '<leader>clt',
      '<leader>cltw',
      '<leader>cltd',
      '<leader>cltq',
      '<leader>cltl',
      '<leader>cltr',
   },
   module   = { 'trouble'               },
   wants    = { 'nvim-lspconfig'        },
   requires = { 'neovim/nvim-lspconfig' },
   config   = function ()
      require('plugins.diagnostics.config')
      require('plugins.diagnostics.keys')
      require('plugins.diagnostics.whichkey')
   end,
}
