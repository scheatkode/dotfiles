return {
	setup = function()
		local ls = require('null-ls')

		local djlint = ls.builtins.formatting.djlint.with({
			args = {
				'--indent=2',
				'--preserve-blank-lines',
				'--preserve-leading-space',
				'--reformat',
				'-',
			},

			filetypes = {
				'jinja',
				'sls',
				'yaml',
			},
		})

		local hadolint = ls.builtins.diagnostics.hadolint.with({
			command = 'hadolint',
			args = {
				'--no-fail',
				'--format=json',
				'$FILENAME',
			},
		})

		local shellcheck_diagnostics = ls.builtins.diagnostics.shellcheck.with({
			command = 'shellcheck',

			args = {
				'--enable=all',
				'--severity=style',
				'--format',
				'json1',
				'--source-path=$DIRNAME',
				'--external-sources',
				'-',
			},
		})

		local shellcheck_codeactions =
			ls.builtins.code_actions.shellcheck.with({
				command = 'shellcheck',

				args = {
					'--enable=all',
					'--severity=style',
					'--format',
					'json1',
					'--source-path=$DIRNAME',
					'--external-sources',
					'-',
				},
			})

		ls.setup({
			debounce = 250,
			default_timeout = 5000,
			diagnostics_format = '#{m}',
			on_attach = require('plugins.lspconfig.on_attach'),
			root_dir = vim.loop.cwd,
			sources = {
				djlint,
				hadolint,
				shellcheck_diagnostics,
				shellcheck_codeactions,

				-- (t|j)s-specific
				ls.builtins.formatting.prettier,

				-- generic
				ls.builtins.diagnostics.vale,

				-- yaml-specific
				ls.builtins.diagnostics.yamllint,

				-- go-specific
				ls.builtins.diagnostics.golangci_lint,
				ls.builtins.diagnostics.staticcheck,
				ls.builtins.formatting.gofumpt,
				ls.builtins.formatting.goimports_reviser,
				ls.builtins.formatting.golines,

				-- lua-specific
				ls.builtins.diagnostics.luacheck,
				ls.builtins.diagnostics.selene,
				ls.builtins.formatting.stylua,

				-- python-specific
				ls.builtins.formatting.black,
				-- ls.builtins.diagnostics.pylint,

				-- shell-specific
				ls.builtins.formatting.shfmt,
				ls.builtins.formatting.shellharden,

				-- github actions specific
				ls.builtins.diagnostics.actionlint,
			},
		})
	end,
}
