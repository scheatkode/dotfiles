return {'nvim-telescope/telescope.nvim', opt = true,
   cmd = {
      'Telescope'
   },

   module_pattern = {
      'telescope.*'
   },

   keys = {
      {'c', '<c-r><c-r>'},
      '<leader><leader>',
      '<leader>bb',
      '<leader>Bb',
      '<leader>bB',
      '<leader>BB',
      '<leader>ca',
      '<leader>f/',
      '<leader>F/',
      '<leader>fa',
      '<leader>Fa',
      '<leader>fb',
      '<leader>Fb',
      '<leader>fB',
      '<leader>FB',
      '<leader>fc',
      '<leader>Fc',
      '<leader>fd',
      '<leader>Fd',
      '<leader>fdd',
      '<leader>Fdd',
      '<leader>fds',
      '<leader>Fds',
      '<leader>fe',
      '<leader>Fe',
      '<leader>ff',
      '<leader>Ff',
      '<leader>fF',
      '<leader>FF',
      '<leader>fg',
      '<leader>Fg',
      '<leader>fG',
      '<leader>FG',
      '<leader>fgb',
      '<leader>fgc',
      '<leader>fgf',
      '<leader>fh',
      '<leader>Fh',
      '<leader>fi',
      '<leader>Fi',
      '<leader>Fi',
      '<leader>fk',
      '<leader>Fk',
      '<leader>fl',
      '<leader>Fl',
      '<leader>fM',
      '<leader>FM',
      '<leader>fm',
      '<leader>Fm',
      '<leader>fn',
      '<leader>Fn',
      '<leader>fo',
      '<leader>Fo',
      '<leader>fp',
      '<leader>Fp',
      '<leader>fq',
      '<leader>Fq',
      '<leader>fr',
      '<leader>Fr',
      '<leader>fR',
      '<leader>FR',
      '<leader>fR',
      '<leader>FR',
      '<leader>fR',
      '<leader>FR',
      '<leader>fS',
      '<leader>FS',
      '<leader>ft',
      '<leader>Ft',
      '<leader>fT',
      '<leader>FT',
      '<leader>fwd',
      '<leader>Fwd',
      '<leader>fws',
      '<leader>Fws',
      '<leader>gb',
      '<leader>Gb',
      '<leader>gc',
      '<leader>Gc',
      '<leader>gf',
      '<leader>Gf',
      '<leader>pp',
      '<leader>Pp',
   },

   requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-project.nvim'},   -- project picker
      {'nvim-telescope/telescope-fzf-native.nvim', -- better sorter
         run = 'make'
      },
      {'nvim-telescope/telescope-frecency.nvim',   -- frequency sorter
         requires = {'tami5/sqlite.lua'}
      },
   },

   wants = {
      'popup.nvim',
      'plenary.nvim',
      'telescope-frecency.nvim',
      'telescope-project.nvim',
      'telescope-fzf-native.nvim',
   },

   config = function ()
      require('plugins.telescope.config')
      require('plugins.telescope.keys')
      require('plugins.telescope.whichkey')
   end,
}
