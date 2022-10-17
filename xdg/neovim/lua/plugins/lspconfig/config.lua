--- required and optional dependencies

local f     = require('f')
local typex = require('typex')()

local on_attach = require('plugins.lspconfig.on_attach')

local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

local log = require('log')

--- globals

local text_change_default_debounce = 150
local languages = {
	bash        = 'bashls',
	cmake       = 'cmake',
	cpp         = 'ccls',
	csharp      = 'omnisharp',
	css         = 'cssls',
	dart        = 'dartls',
	eslint      = 'eslint',
	go          = 'gopls',
	golint      = 'golangci_lint_ls',
	html        = 'html',
	java        = 'jdtls',
	javascript  = 'tsserver',
	json        = 'jsonls',
	ltex        = 'ltex',
	lua         = 'sumneko_lua',
	php         = 'intelephense',
	powershell  = 'powershell_es',
	prisma      = 'prismals',
	python      = 'pyright',
	rust        = 'rust_analyzer',
	salt_ls     = 'salt_ls',
	svelte      = 'svelte',
	tailwindcss = 'tailwindcss',
	texlab      = 'texlab',
	yaml        = 'yamlls',
}

-- server configuration {{{1

local configure_servers = function(language_list)
	local capabilities = require('lang.capabilities')

	f
		 .iterate(language_list)
		 :foreach(function( _, server)
		    local has_settings, settings = pcall(require, 'lang.servers.' .. server)

		    if not has_settings then
		       log.error(
		          'Missing configuration for language server ' .. server,
		          '‼ lsp'
		       )

		       return
		    end

		    local function run_hook(    hook, client, bufnr, s)
		       if typex(hook) == 'function' then
		          hook(client, bufnr, s)
		       elseif typex(hook) == 'table' then
		          f
			           .iterate(hook)
			           :foreach(function(           _, h)
			              h(client, bufnr, s)
			           end)
		       end
		    end

		    settings.on_attach = function(    client, bufnr)
		       run_hook(settings.pre_attach, client, bufnr, settings)
		       run_hook(on_attach, client, bufnr, settings)
		       run_hook(settings.post_attach, client, bufnr, settings)

		       log.info('Started ' .. server, ' lsp')
		    end

		    settings.flags = {
		       debounce_text_changes = text_change_default_debounce,
		    }

		    settings.capabilities = capabilities

		    lspconfig[server].setup(settings)
		 end)
end

-- main {{{1

if not has_lspconfig then
	log.error('Tried loading plugin ... unsuccessfully', '‼ lsp')
	return has_lspconfig
end

require('lang.capabilities').setup()
require('lang.protocol').setup()
require('lang.handlers').setup()

configure_servers(languages)

log.info('Plugin loaded', ' lsp')

return true

-- vim: set fdm=marker fdl=0:
