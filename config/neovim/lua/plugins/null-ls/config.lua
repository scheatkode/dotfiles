return {
	setup = function()
		local ls = require("null-ls")

		ls.setup({
			debounce = 500,
			default_timeout = 5000,
			diagnostics_format = "#{m}",
			root_dir = vim.loop.cwd,
			sources = {
				-- (t|j)s-specific
				ls.builtins.formatting.prettier.with({
					filetypes = {
						"typescript",
						"javascript",
						"svelte",
						"vue",
					},
				}),

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
				ls.builtins.formatting.ruff,
				ls.builtins.diagnostics.ruff,
				-- ls.builtins.diagnostics.pylint,

				-- shell-specific
				ls.builtins.formatting.shfmt,
				ls.builtins.formatting.shellharden,
				ls.builtins.diagnostics.shellcheck.with({
					args = {
						"--enable=all",
						"--severity=style",
						"--format",
						"json1",
						"--source-path=$DIRNAME",
						"--external-sources",
						"-",
					},

					filetypes = {
						"sh",
						"bash",
						"zsh",
					},
				}),
				ls.builtins.code_actions.shellcheck.with({
					args = {
						"--enable=all",
						"--severity=style",
						"--format",
						"json1",
						"--source-path=$DIRNAME",
						"--external-sources",
						"-",
					},

					filetypes = {
						"sh",
						"bash",
						"zsh",
					},
				}),

				-- github actions specific
				ls.builtins.diagnostics.actionlint,

				-- dockerfiles specific
				ls.builtins.diagnostics.hadolint.with({
					args = {
						"--no-fail",
						"--format=json",
						"$FILENAME",
					},
				}),

				-- template languages specific
				ls.builtins.formatting.djlint.with({
					args = {
						"--indent=2",
						"--preserve-blank-lines",
						"--preserve-leading-space",
						"--reformat",
						"--profile",
						"jinja",
						"-",
					},

					filetypes = {
						"jinja",
						"sls",
						"sls.jinja",
						"sls.yaml",
						"yaml",
					},
				}),

				ls.builtins.diagnostics.djlint.with({
					args = {
						"--profile",
						"jinja",
						"-",
					},

					filetypes = {
						"jinja",
						"sls",
						"sls.jinja",
						"sls.yaml",
						"yaml",
					},
				}),
			},
		})
	end,
}
