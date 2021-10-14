local has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register {
      ['<leader>cd'] = {
         e = 'Activate UI for debugging',
         v = 'Activate UI for debugging',
      },
   }
end
return { 'rcarriga/nvim-dap-ui', opt = true,
   keys = {
      '<leader>cde',
      '<leader>cdv',
   },
   modules = { 'dapui'    },
   after   = { 'nvim-dap' },
   config  = function ()
      require('plugins.dapui.config')
      require('plugins.dapui.keys')
      require('plugins.dapui.whichkey')
   end,
}
