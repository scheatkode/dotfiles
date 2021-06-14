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

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
