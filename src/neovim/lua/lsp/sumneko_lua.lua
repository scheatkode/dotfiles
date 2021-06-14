local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
local fn = vim.fn

if not has_lspconfig then
   print('‼ Tried loading lspconfig for lua-language-server ... unsuccessfully.')
   return has_lspconfig
end

local system_name

if fn.has('mac') == 1 then
   system_name = 'macOS'
elseif fn.has('unix') == 1 then
   system_name = 'Linux'
elseif fn.has('win32') == 1 then
   system_name = 'Windows'
else
   print('‼ Unsupported system for sumneko\'s lua-language-server')
end

-- set the path to the sumneko installation; if you previously installed via
-- the now deprecated :LspInstall, use
local sumneko_root_path = fn.stdpath('data')
   .. '/lsp/lua-language-server'

local sumneko_binary = sumneko_root_path
   .. '/bin/' .. system_name
   .. '/lua-language-server'

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
   cmd      = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
   settings = {

      Lua = {
         runtime = {
            -- Tell the language server which version of Lua you're using (most
            -- likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path    = vim.split(package.path, ';'),
         },

         diagnostics = {
            enable = true,
            -- Get the language server to recognize the `vim` global
            globals = {
               'vim',
               --'describe',
               --'it',
               --'before_each',
               --'after_each',
            },
         },

         workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
               [fn.expand('$VIMRUNTIME/lua')]         = true,
               [fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            },
         },
      },
   },
}

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
