return {
	setup = function()
		local lazy        = require('load')
		local deep_extend = require('tablex.deep_extend')

		require('lang.protocol').setup()
		require('lang.handlers').setup()

		local flags        = require('lang.flags').setup()
		local on_attach    = require('lang.on_attach').setup()
		local capabilities = deep_extend(
			'force',
			require('lang.capabilities').setup(),
			vim.lsp.protocol.make_client_capabilities()
		)

		local lspconfig       = lazy.on_index('lspconfig')
		local mason_lspconfig = require('mason-lspconfig')

		local function run_hook(hook, client, bufnr, s)
			if type(hook) == 'function' then
				return hook(client, bufnr, s)
			end

			if type(hook) ~= 'table' then
				return
			end

			for _, h in pairs(hook) do
				h(client, bufnr, s)
			end
		end

		local function attach_hooks(config)
			return function(client, bufnr)
				run_hook(config.pre_attach, client, bufnr, config)
				run_hook(on_attach, client, bufnr, config)
				run_hook(config.post_attach, client, bufnr, config)
			end
		end

		local default_config = {
			capabilities = capabilities,
			flags        = flags,
			on_attach    = on_attach,
		}

		mason_lspconfig.setup()
		mason_lspconfig.setup_handlers({
			function(server)
				local has_config, config =
					pcall(require, 'lang.servers.' .. server)

				if not has_config then
					return lspconfig[server].setup(default_config)
				end

				config.on_attach = config.on_attach or attach_hooks(config)

				return lspconfig[server].setup(deep_extend('force', default_config, config))
			end,
		})
	end,
}
