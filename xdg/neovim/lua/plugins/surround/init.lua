local has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register({
      ['<leader>ts']  = { 'Activate surrounding plugin' },
      ['<leader>tsa'] = { 'Activate surrounding plugin' },
      ['<leader>tsc'] = { 'Activate surrounding plugin' },
      ['<leader>tsC'] = { 'Activate surrounding plugin' },
      ['<leader>tsd'] = { 'Activate surrounding plugin' },
      ['<leader>tsD'] = { 'Activate surrounding plugin' },
   })

   whichkey.register({
      ['<leader>ts']  = { 'Activate surrounding plugin' },
      ['<leader>tsa'] = { 'Activate surrounding plugin' },
   }, {
      mode = 'v'
   })
end

return {'machakann/vim-sandwich', opt = true,

   keys = {
      { 'n', '<leader>ts'  },
      { 'n', '<leader>tsa' },
      { 'n', '<leader>tsc' },
      { 'n', '<leader>tsC' },
      { 'n', '<leader>tsd' },
      { 'n', '<leader>tsD' },
      { 'v', '<leader>ts'  },
      { 'v', '<leader>tsa' },
   },

   setup  = function ()
      vim.g.sandwich_no_default_key_mappings = 1
   end,

   config = function ()
      require('plugins.surround.whichkey')
      require('plugins.surround.keys')

      require('log').info('Plugin loaded', 'surround')
   end,

}
