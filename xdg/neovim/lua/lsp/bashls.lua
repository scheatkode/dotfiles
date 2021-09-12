local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
   print('‼ Tried loading lspconfig for bashls ... unsuccessfully.')
   return has_lspconfig
end

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
   cmd     = { vim.fn.expand('~/.yarn/bin/bash-language-server'), 'start' },
   cmd_env = {
      GLOB_PATTERN = '*@(.sh|.inc|.bash|.command)',
   },
   root_dir = lspconfig.util.root_pattern('main', '.git')
}
