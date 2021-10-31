--- localise vim globals

local api = vim.api
local lsp = vim.lsp

--- required and optional dependencies

local has_lspinstall, lspinstall = pcall(require, 'nvim-lsp-installer')
local has_lspconfig,  lspconfig  = pcall(require, 'lspconfig')
local has_whichkey,   whichkey   = pcall(require, 'which-key')

local register_keymap = require('util').register_single_keymap
local log             = require('log')

--- globals

local text_change_default_debounce = 150
local languages = {
   python = 'pyright',
   -- 'gopls',
   rust =  'rust_analyzer',
   -- javascript = 'tsserver',
   -- 'vimls',
   bash   = 'bashls',
   cpp    = 'ccls',
   deno   = 'denols',
   php    = 'intelephense',
   java   = 'jdtls',
   dart = 'dartls',
   json   = 'jsonls',
   csharp = 'omnisharp',
   -- 'perlls',
   -- 'perlpls',
   lua    = 'sumneko_lua',
   -- 'phpactor',
   yaml   = 'yamlls',

   tailwindcss = 'tailwindcss',

   generic = 'null-ls',

}

local border = {

   --- rounded border
   {'╭', 'FloatBorder'},
   {'─', 'FloatBorder'},
   {'╮', 'FloatBorder'},
   {'│', 'FloatBorder'},
   {'╯', 'FloatBorder'},
   {'─', 'FloatBorder'},
   {'╰', 'FloatBorder'},
   {'│', 'FloatBorder'},

   --- square border
   -- {'┌', 'FloatBorder'},
   -- {'─', 'FloatBorder'},
   -- {'┐', 'FloatBorder'},
   -- {'│', 'FloatBorder'},
   -- {'┘', 'FloatBorder'},
   -- {'─', 'FloatBorder'},
   -- {'└', 'FloatBorder'},
   -- {'│', 'FloatBorder'},

}

-- mappings registration shorthand {{{1

local normalize_keymaps = function (mappings)
   for _, mapping in ipairs(mappings) do
      local mode         = mapping.mode
      local keys         = mapping.keys
      local description  = mapping.description
      local command      = mapping.command
      local condition    = mapping.condition
      local options      = mapping.options

      local is_command_valid =
             command ~= nil
         and command ~= false
         and command ~= ''

      local is_condition_valid = condition ~= nil and condition ~= false

      if is_command_valid and is_condition_valid then
         register_keymap {
            mode    = mode,
            keys    = keys,
            command = command,
            options = options,
         }

         if has_whichkey then
            whichkey.register({
               [keys] = description
            }, {
               mode   = mode,
               buffer = options.buffer
            })
         end
      end
   end
end

-- on attach {{{1

local on_attach = function (client, bufnr)

   -- omnifunc setup {{{2

   vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

   -- border customization {{{2

   lsp.handlers['textDocument/hover']         = lsp.with(lsp.handlers.hover, {border = border})
   lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.hover, {border = border})

   -- mappings {{{2

   normalize_keymaps {

      -- declaration {{{3

      {
         mode         = 'n',
         keys         = '<leader>clD',
         description  = 'Declaration',
         command      = '<cmd>lua vim.lsp.buf.declaration()<CR>',
         condition    = client.resolved_capabilities.declaration,
         options      = { buffer = bufnr },
      },

      -- definition {{{3

      {
         mode         = 'n',
         keys         = '<leader>cld',
         description  = 'Definition',
         command      = '<cmd>lua vim.lsp.buf.definition()<CR>',
         condition    = client.resolved_capabilities.goto_definition,
         options      = { buffer = bufnr },
      },

      -- type definition {{{3

      {
         mode         = 'n',
         keys         =  '<leader>clT',
         description  = 'Type definition',
         command      = '<cmd>lua vim.lsp.buf.type_definition()<CR>',
         condition    = client.resolved_capabilities.type_definition,
         options      = { buffer = bufnr },
      },

      -- implementation {{{3

      {
         mode         = 'n',
         keys         = '<leader>cli',
         description  = 'Implementation',
         command      = '<cmd>lua vim.lsp.buf.implementation()<CR>',
         condition    = client.resolved_capabilities.implementation,
         options      = { buffer = bufnr },
      },

      -- rename symbol {{{3

      {
         mode         = 'n',
         keys         = '<leader>clR',
         description  = 'Rename symbol',
         command      = '<cmd>lua vim.lsp.buf.rename()<CR>',
         condition    = client.resolved_capabilities.rename,
         options      = { buffer = bufnr },
      },

      -- references {{{3

      {
         mode         = 'n',
         keys         = '<leader>clr',
         description  = 'References',
         command      = '<cmd>lua vim.lsp.buf.references()<CR>',
         condition    = client.resolved_capabilities.references,
         options      = { buffer = bufnr },
      },

      -- code action {{{3

      {
         mode         = 'n',
         keys         = '<leader>cla',
         description  = 'Code action',
         command      = '<cmd>lua vim.lsp.buf.code_action()<CR>',
         condition    = client.resolved_capabilities.code_action,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'x',
         keys         = '<leader>cla',
         description  = 'Code action',
         command      = '<cmd>lua vim.lsp.buf.code_action()<CR>',
         condition    = client.resolved_capabilities.code_action,
         options      = { buffer = bufnr },
      },

      -- hover documentation {{{3

      {
         mode         = 'n',
         keys         = '<leader>clh',
         description  = 'Hover documentation',
         command      = '<cmd>lua vim.lsp.buf.hover()<CR>',
         condition    = client.resolved_capabilities.hover,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = 'K',
         description  = 'Hover documentation',
         command      = '<cmd>lua vim.lsp.buf.hover()<CR>',
         condition    = client.resolved_capabilities.hover,
         options      = { buffer = bufnr },
      },

      -- call hierarchy {{{3

      {
         mode         = 'n',
         keys         = '<leader>clI',
         description  = 'Incoming calls',
         command      = '<cmd>lua vim.lsp.buf.incoming_calls()<CR>',
         condition    = client.resolved_capabilities.call_hierarchy,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = '<leader>clO',
         description  = 'Outgoing calls',
         command      = '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>',
         condition    = client.resolved_capabilities.call_hierarchy,
         options      = { buffer = bufnr },
      },

      -- diagnostics {{{3

      {
         mode         = 'n',
         keys         = '<leader>cll',
         description  = 'Line diagnostics',
         command      = '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border = "rounded"})<CR>',
         condition    = true,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = '<leader>clL',
         description  = 'Send diagnostics to loclist',
         command      = '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',
         condition    = true,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = '[d',
         description  = 'Go to previous diagnostic',
         command      = '<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = "rounded"}})<CR>',
         condition    = true,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = ']d',
         description  = 'Go to next diagnostic',
         command      = '<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = "rounded"}})<CR>',
         condition    = true,
         options      = { buffer = bufnr },
      },

      -- signature help {{{3

      {
         mode         = 'n',
         keys         = '<leader>clS',
         description  = 'Signature help',
         command      = '<cmd>lua vim.lsp.buf.signature_help()<CR>',
         condition    = client.resolved_capabilities.signature_help,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'i',
         keys         = '<M-s>',
         description  = 'Signature help',
         command      = '<cmd>lua vim.lsp.buf.signature_help()<CR>',
         condition    = client.resolved_capabilities.signature_help,
         options      = { buffer = bufnr },
      },

      -- workspace management {{{3

      {
         mode         = 'n',
         keys         = '<leader>clwa',
         description  = 'Add folder to workspace',
         command      = '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
         condition    = client.resolved_capabilities.workspace_folder_properties,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = '<leader>clwd',
         description  = 'Remove folder from workspace',
         command      = '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
         condition    = client.resolved_capabilities.workspace_folder_properties,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = '<leader>clwl',
         description  = 'List folders in workspace',
         command      = '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
         condition    = client.resolved_capabilities.workspace_folder_properties,
         options      = { buffer = bufnr },
      },

      -- code formatting {{{3

      {
         mode         = 'n',
         keys         = '<leader>cf',
         description  = 'Format code',
         command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
         condition    = client.resolved_capabilities.document_formatting
            or client.resolved_capabilities.document_range_formatting,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'n',
         keys         = '<leader>=',
         description  = 'Format code',
         command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
         condition    = client.resolved_capabilities.document_formatting
            or client.resolved_capabilities.document_range_formatting,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'x',
         keys         = '<leader>cf',
         description  = 'Format code',
         command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
         condition    = client.resolved_capabilities.document_formatting
            or client.resolved_capabilities.document_range_formatting,
         options      = { buffer = bufnr },
      },

      {
         mode         = 'x',
         keys         = '<leader>=',
         description  = 'Format code',
         command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
         condition    = client.resolved_capabilities.document_formatting
            or client.resolved_capabilities.document_range_formatting,
         options      = { buffer = bufnr },
      },

      -- }}}

   }

   -- mapping category names

   if has_whichkey then
      whichkey.register({
         ['<leader>cl'] = {
            name = '+lsp',
            w = {
               name = '+workspace',
            },
         },
      }, {
         buffer = bufnr
      })
   end

   -- autocommands {{{2

   if client.resolved_capabilities.document_highlight then
      api.nvim_exec([[
         :hi LspReferenceRead  cterm=bold ctermbg=red guibg=LightYellow
         :hi LspReferenceText  cterm=bold ctermbg=red guibg=LightYellow
         :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow

         augroup lsp_document_highlight
         autocmd! *           <buffer>
         autocmd  CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
         autocmd  CursorMoved <buffer> lua vim.lsp.buf.clear_references()
         augroup End
      ]], false)
   end

   -- }}}

end

-- server configuration {{{1

local configure_servers = function(language_list)
   local capabilities = require('lsp.capabilities')
   local installer

   if not has_lspinstall then
      log.warn('Unable to install language servers automatically.', '‼ lsp')
   else
      installer = require('nvim-lsp-installer.servers')
   end

   for _, server in pairs(language_list) do
      local has_settings, settings = pcall(require, 'lsp.' .. server)

      if not has_settings then
         log.error(
            'Missing configuration for language server ' .. server,
            '‼ lsp'
         )
         goto continue
      end

      if has_lspinstall then
         local has_lsp_server, lsp_server = installer.get_server(server)

         if has_lsp_server and not lsp_server:is_installed() then
            lsp_server:install()
         end
      end

      settings.on_attach = function (client, bufnr)
         if type(settings.pre_attach) == 'function' then
            settings.pre_attach(client, bufnr)
         end

         on_attach(client, bufnr)

         if type(settings.post_attach) == 'function' then
            settings.post_attach(client, bufnr)
         end

         log.info('Started ' .. server, ' lsp')
      end

      settings.flags = {
         debounce_text_changes = text_change_default_debounce,
      }

      settings.capabilities = capabilities

      -- TODO: refactor and use lspinstall's post install hook

      -- lspinstall.install_server(language)
      lspconfig[server].setup(settings)

      ::continue::
   end
end

-- main {{{1

if not has_lspconfig then
   log.error('Tried loading plugin ... unsuccessfully', '‼ lsp')
   return has_lspconfig
end

require('lsp.protocol').setup()
require('lsp.handlers').setup()
require('lsp.signs').setup()

configure_servers(languages)

log.info('Plugin loaded', ' lsp')

return true

-- vim: set fdm=marker fdl=0:

