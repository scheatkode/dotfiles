--- required and optional dependencies

local f     = require('f')
local typex = require('typex')()

local on_attach = require('plugins.lspconfig.on_attach')

local has_lspinstall, lspinstall = pcall(require, 'nvim-lsp-installer')
local has_lspconfig,  lspconfig  = pcall(require, 'lspconfig')

local log = require('log')

--- globals

local text_change_default_debounce = 150
local languages = {
   powershell = 'powershell_es',
   python = 'pyright',
   -- 'gopls',
   rust =  'rust_analyzer',
   javascript = 'tsserver',
   -- 'vimls',
   bash   = 'bashls',
   cpp    = 'ccls',
   -- deno   = 'denols',
   php    = 'intelephense',
   java   = 'jdtls',
   dart = 'dartls',
   json   = 'jsonls',
   -- csharp = 'csharp_ls',
   csharp = 'omnisharp',
   -- 'perlls',
   -- 'perlpls',
   lua    = 'sumneko_lua',
   -- 'phpactor',
   yaml   = 'yamlls',
   cmake = 'cmake',

   go = 'gopls',

   tailwindcss = 'tailwindcss',

   salt_ls = 'salt_ls',
   ltex = 'ltex',
}

-- server configuration {{{1

local configure_servers = function(language_list)
   local capabilities = require('lang.capabilities')
   local installer

   if not has_lspinstall then
      log.warn('Unable to install language servers automatically.', '‼ lsp')
   else
      installer = require('nvim-lsp-installer.servers')
   end

   f
   .iterate(language_list)
   :foreach(function (_, server)
      local has_settings, settings = pcall(require, 'lang.servers.' .. server)

      if not has_settings then
         log.error(
            'Missing configuration for language server ' .. server,
            '‼ lsp'
         )

         return
      end

      if has_lspinstall then
         local has_lsp_server, lsp_server = installer.get_server(server)

         if has_lsp_server and not lsp_server:is_installed() then
            lsp_server:install()
         end
      end

      local function run_hook (hook, client, bufnr, s)
         if typex(hook) == 'function' then
            hook(client, bufnr, s)
         elseif typex(hook) == 'table' then
            f
            .iterate(hook)
            :foreach(function (_, h)
               h(client, bufnr, s)
            end)
         end
      end

      settings.on_attach = function (client, bufnr)
         run_hook(settings.pre_attach,  client, bufnr, settings)
         run_hook(on_attach,            client, bufnr, settings)
         run_hook(settings.post_attach, client, bufnr, settings)

         log.info('Started ' .. server, ' lsp')
      end

      settings.flags = {
         debounce_text_changes = text_change_default_debounce,
      }

      settings.capabilities = capabilities

      -- TODO: refactor and use lspinstall's post install hook

      -- lspinstall.install_server(language)
      lspconfig[server].setup(settings)
   end)
end

-- main {{{1

if not has_lspconfig then
   log.error('Tried loading plugin ... unsuccessfully', '‼ lsp')
   return has_lspconfig
end

require('lang.protocol').setup()
require('lang.handlers').setup()

configure_servers(languages)

log.info('Plugin loaded', ' lsp')

return true

-- vim: set fdm=marker fdl=0:

