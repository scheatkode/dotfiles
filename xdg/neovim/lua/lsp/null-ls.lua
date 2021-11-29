local has_null, null = pcall(require, 'null-ls')

if not has_null then
   print('something') -- TODO
   return has_null
end

local prettier = null.builtins.formatting.prettier.with({
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

local stylua = null.builtins.formatting.stylua.with({

})

local vale = null.builtins.diagnostics.vale.with({
   'markdown',
   'tex',
})

local hadolint = null.builtins.diagnostics.hadolint.with({
   command = 'podman',
   args = {
      'run',
      '--rm',
      '-iv',
      vim.loop.cwd() .. ':' .. vim.loop.cwd(),
      -- ':/data',
      -- '--workdir=/data',
      'docker.io/hadolint/hadolint',
      'hadolint',
      '--no-fail',
      '--format=json',
      '$FILENAME',
   },
})

null.config {
             debounce = 250,
      default_timeout = 5000,
   diagnostics_format = '#{m}',

   sources = {
      prettier,
      hadolint,
      -- stylua,
      -- vale,
   }
}

return {
   root_dir  = vim.loop.cwd,
   filetypes = require('plugins.lint.filetypes'),
}
