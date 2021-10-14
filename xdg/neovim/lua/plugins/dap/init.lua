local has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register {
      ['<leader>c'] = {
         d = 'Activate debugging',
      },

      ['<leader>cd'] = {
         C = 'which_key_ignore',
         D = 'which_key_ignore',
         O = 'which_key_ignore',
         P = 'which_key_ignore',
         Q = 'which_key_ignore',
         b = 'which_key_ignore',
         c = 'which_key_ignore',
         d = 'which_key_ignore',
         i = 'which_key_ignore',
         l = 'which_key_ignore',
         o = 'which_key_ignore',
         p = 'which_key_ignore',
         q = 'which_key_ignore',
         r = 'which_key_ignore',
         u = 'which_key_ignore',
      },
   }
end

return { 'mfussenegger/nvim-dap', opt = true,
   keys = {
      '<leader>cd',
      '<leader>cdC',
      '<leader>cdD',
      '<leader>cdO',
      '<leader>cdP',
      '<leader>cdQ',
      '<leader>cdb',
      '<leader>cdc',
      '<leader>cdd',
      '<leader>cdi',
      '<leader>cdl',
      '<leader>cdo',
      '<leader>cdp',
      '<leader>cdq',
      '<leader>cdr',
      '<leader>cdu',
   },
   modules  = { 'dap' },
   -- wants    = { 'nvim-dap-ui'          },
   -- requires = { 'rcarriga/nvim-dap-ui' },
   config  = function ()
      require('plugins.dap.config')
      require('plugins.dap.keys')
      require('plugins.dap.whichkey')
   end,
}
