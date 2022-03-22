return {
   'windwp/nvim-ts-autotag',

   opt = true,

   ft = {
      'html',
      'javascript',
      'javascriptreact',
      'jsx',
      'rescript',
      'svelte',
      'tsx',
      'typescript',
      'typescriptreact',
      'vue',
      'xml',
   },

   config = function ()
      require('nvim-ts-autotag').setup()
   end
}
