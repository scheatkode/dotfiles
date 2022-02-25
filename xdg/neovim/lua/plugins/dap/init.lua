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

   modules  = { 'dap' },

   config  = function ()
      require('plugins.dap.config')
      require('plugins.dap.keys')
   end,
}
