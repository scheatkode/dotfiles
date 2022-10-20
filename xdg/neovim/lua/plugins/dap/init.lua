return {
   'mfussenegger/nvim-dap',

   opt = true,

   keys = {
      '<leader>d',
      '<leader>dC',
      '<leader>dD',
      '<leader>dO',
      '<leader>dP',
      '<leader>dQ',
      '<leader>db',
      '<leader>dc',
      '<leader>dd',
      '<leader>di',
      '<leader>dl',
      '<leader>do',
      '<leader>dp',
      '<leader>dq',
      '<leader>dr',
      '<leader>du',
   },

   modules = { 'dap' },

   wants = { 'nvim-dap-vscode-js' },

   config = function ()
      require('plugins.dap.config').setup()
      require('plugins.dap.keys').setup()
   end,
}
