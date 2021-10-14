local has_whichkey, whichkey = pcall(require, 'which-key')

if has_whichkey then
   whichkey.register({
      b = {
         name = '+buffers',

         b = {'Buffer search'},
      },

      c = {
         name = '+code',

         l = {
            name = '+lsp',

            c = {'Code actions'},
            d = {'Document symbols'},
            r = {'References'},
            w = {'Workspace symbols'},
         },
      },

      f = {
         name = '+files',

         F = {'Find file from here'},
         f = {'Find file'},
         g = {'Grep live'},
         r = {'Recent files'},
      },

      n = {
         name = '+notes',

         f = 'Find notes',
      },

      p = {
         name = '+projects',

         p = 'Project switch',
      },

      s = {
         name = '+search',

         h = {'Help tags'},
         l = {'Lines in current buffer'},
         m = {'Man pages'},
         q = {'Quickfix'},
         r = {'Registers'},
         t = {'Treesitter'},
      },

      ['<leader>'] = 'which_key_ignore',
      F = 'which_key_ignore',
   }, {
      prefix = '<leader>'
   })
end
