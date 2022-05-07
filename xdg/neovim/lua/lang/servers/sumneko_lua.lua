local fn = vim.fn

local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

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

local sumneko_root_path = fn.stdpath('data')
   .. '/lsp_servers'
   .. '/sumneko_lua'
   .. '/extension'
   .. '/server'

-- local sumneko_binary = sumneko_root_path
--    .. '/bin/' .. system_name
--    .. '/lua-language-server'

local sumneko_binary = sumneko_root_path
   .. '/bin'
   .. '/lua-language-server'

local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- TODO(scheatkode): Add autoinstall with spinner animation

return {
   cmd      = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
   settings = {

      Lua = {
         telemetry = {
            enable = false,
         },

         runtime = {
            -- Tell the language server which version of Lua you're using (most
            -- likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path    = runtime_path,
         },

         diagnostics = {
            enable = true,
            -- Get the language server to recognize the `vim` global
            globals = {
               -- Neovim specific
               'vim',
               'use', -- Packer `use` keyword

               -- Busted specific
               'describe',
               'it',
               'before_each',
               'after_each',

               -- AwesomeWM specific
               'awesome',
               'client',
               'root',
               'screen',
            },
         },

         hint = {
         	enable = true,
         },

         workspace = {
            -- Make the server aware of Neovim runtime files
            -- library = vim.api.nvim_get_runtime_file('', true),
            library = {
               [fn.expand('$VIMRUNTIME/lua')]         = true,
               -- [fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
               [fn.expand('$VIMRUNTIME/lua/lsp')] = true,
               [fn.expand('/usr/share/awesome/lib')] = true,
            },
         },
      },
   },
}
