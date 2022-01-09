local has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register({
      ['<F1>'] = { 'Activate file tree explorer' }
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
      '<F1>',
   },

   wants    = { 'nvim-web-devicons'            },
   requires = { 'kyazdani42/nvim-web-devicons' },

   config = function ()
      require('plugins.explorer.config')
      require('plugins.explorer.keys')
      require('log').info('Plugin loaded', 'nvim-tree')
   end,
}
