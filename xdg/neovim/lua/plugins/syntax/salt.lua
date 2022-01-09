return {'saltstack/salt-vim', opt = true,
   ft = {
      'sls',
      'Saltfile',
      'jinja'
   },
   wants    = { 'Vim-Jinja2-Syntax' },
   requires = { 'Glench/Vim-Jinja2-Syntax', opt = true },
   setup    = function () vim.g.sls_use_jinja_syntax = 1 end,
   config   = function ()
      require('log').info('Plugin loaded', 'saltstack-syntax')
   end,
}
