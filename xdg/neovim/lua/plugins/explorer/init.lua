local has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register({
      ['<leader>ft'] = { 'Activate file tree explorer' }
   })
end

return {'kyazdani42/nvim-tree.lua', opt = true,
   cmd = {
      'NvimTreeToggle',
      'NvimTreeOpen',
      'NvimTreeClose',
      'NvimTreeFindFile',
   },

   keys = {
      '<leader>ft',
   },

   wants    = { 'nvim-web-devicons'            },
   requires = { 'kyazdani42/nvim-web-devicons' },

   setup = function ()
      require('plugins.explorer.setup')
   end,
   config = function ()
      require('plugins.explorer.config')
      require('plugins.explorer.keys')
      require('log').info('Plugin loaded', 'nvim-tree')
   end,
}
