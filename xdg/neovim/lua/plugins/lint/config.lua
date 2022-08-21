local has_ls, ls = pcall(require, 'null-ls')
local log        = require('log')

if not has_ls then
	log.error('Tried loading plugin ... unsuccessfully ‼', 'null-ls')
	return has_ls
end

local prettier = ls.builtins.formatting.prettier.with({
	filetypes = {
		'css',
		'html',
		'javascript',
		'javascript.jsx',
		'javascriptreact',
		'json',
		'jsonc',
		'markdown',
		'scss',
		'svelte',
		'typescript',
		'typescript.tsx',
		'typescriptreact',
		'yaml',
	}
})

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
	}
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
		'-'
	}
})

local shellcheck_codeactions = ls.builtins.code_actions.shellcheck.with({
	command = 'shellcheck',

	args = {
		'--enable=all',
		'--severity=style',
		'--format',
		'json1',
		'--source-path=$DIRNAME',
		'--external-sources',
		'-'
	}
})

local luacheck = ls.builtins.diagnostics.luacheck.with({
	args = {
		'--formatter',
		'plain',
		'--codes',
		'--ranges',
		'--std',
		'max+busted',
		'--globals',
		'vim',
		'--filename',
		'$FILENAME',
		'-'
	}
})

ls.setup({
	debounce           = 250,
	default_timeout    = 5000,
	diagnostics_format = '#{m}',
	on_attach          = require('plugins.lspconfig.on_attach'),
	root_dir           = vim.loop.cwd,
	sources            = {
		djlint,
		hadolint,
		prettier,
		shellcheck_diagnostics,
		shellcheck_codeactions,
		luacheck,

		ls.builtins.diagnostics.vale,
		ls.builtins.diagnostics.yamllint,

		ls.builtins.formatting.black,
		ls.builtins.formatting.shfmt,
		ls.builtins.formatting.shellharden,
	}
})
