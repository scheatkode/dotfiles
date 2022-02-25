return {
   'rcarriga/nvim-dap-ui',

   opt = true,

   keys = {
      '<leader>de',
      '<leader>dv',
   },

   modules = { 'dapui'    },
   after   = { 'nvim-dap' },

   config  = function ()
      require('plugins.dapui.config')
      require('plugins.dapui.keys')
   end,
}
