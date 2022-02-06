return {'nvim-lualine/lualine.nvim', opt = true,
   wants    = { 'nvim-web-devicons' },
   requires = { 'kyazdani42/nvim-web-devicons' },

   event = 'VimEnter',

   config = function ()
      require('plugins.statusline.config')
   end
}
