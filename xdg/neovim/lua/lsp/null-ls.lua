local has_ls, ls = pcall(require, 'null-ls')

if not has_ls then
   print('something') -- TODO
   return has_ls
end

local prettier = ls.builtins.formatting.prettier.with({
   command = vim.fn.expand('~/.yarn/bin/prettier'),

   filetypes = {
      'html',
      'css',
      'scss',

      'markdown',

      'javascript',
      'javascript.jsx',
      'javascriptreact',

      'json',

      'typescript',
      'typescript.tsx',
      'typescriptreact',

      'vue',
      'svelte',

      'yaml',
}})

local stylua = ls.builtins.formatting.stylua.with({

})

local vale = ls.builtins.diagnostics.vale.with({
   'markdown',
   'tex',
})

ls.config {
             debounce = 250,
      default_timeout = 5000,
   diagnostics_format = '#{m}',

   sources = {
      prettier,
      -- stylua,
      -- vale,
   }
}

return {
   root_dir  = vim.loop.cwd,
   filetypes = require('plugins.lint.filetypes'),
}
