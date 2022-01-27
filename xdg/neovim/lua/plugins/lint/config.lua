local has_ls, ls = pcall(require, 'null-ls')
local log = require('log')

if not has_ls then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'null-ls')
   return has_ls
end

local prettier = ls.builtins.formatting.prettier.with({
   command = vim.fn.expand('./node_modules/.bin/prettier'),

   args = {
      '--stdin-filepath', '$FILENAME',
      '--tab-width', '3',
      '--no-semi',
      '--single-quote',
      '--jsx-single-quote',
   },

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

local eslint_diagnostics = ls.builtins.diagnostics.eslint.with({
   command = vim.fn.expand('./node_modules/.bin/eslint_d'),

   args = {
      '-f',
      'json',
      '--config', './eslint.config.js',
      '--stdin',
      '--stdin-filename', '$FILENAME',
   },

   filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
   },
})

local eslint_codeactions = ls.builtins.code_actions.eslint.with({
   command = vim.fn.expand('./node_modules/.bin/eslint_d'),

   args = {
      '-f',
      'json',
      '--config', './eslint.config.js',
      '--stdin',
      '--stdin-filename', '$FILENAME',
   },

   filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
   },
})


local stylua = ls.builtins.formatting.stylua.with({

})

local vale = ls.builtins.diagnostics.vale.with({
   'markdown',
   'tex',
})

local hadolint = ls.builtins.diagnostics.hadolint.with({
   command = 'podman',
   args = {
      'run',
      '--rm',
      '-iv',
      vim.loop.cwd() .. ':' .. vim.loop.cwd(),
      'docker.io/hadolint/hadolint',
      'hadolint',
      '--no-fail',
      '--format=json',
      '$FILENAME',
   },
})

ls.setup({
             debounce = 250,
      default_timeout = 5000,
   diagnostics_format = '#{m}',

   on_attach = require('plugins.lspconfig.on_attach'),

   root_dir = vim.loop.cwd,

   sources = {
      eslint_codeactions,
      eslint_diagnostics,
      hadolint,
      prettier,
      -- stylua,
      -- vale,
   }
})
