-- Language: Bazel/Please build definition file
vim.filetype.add({
	filename = {
		['BUILD'] = 'python.bzl',
	},
	pattern = {
		['.*%.build_defs'] = 'python.bzl',
		['.*%.bzl']        = 'python.bzl',
		['BUILD%..*']      = 'python.bzl',
	},
})

-- Language: Cisco configuration
vim.filetype.add({
	ext = {
		['cisco'] = 'cisco',
		['ios']   = 'cisco',
	},
})

-- Language: d2 diagram definition file
vim.filetype.add({
	ext = {
		['d2'] = 'd2',
	},
})

-- Language: Git config file
vim.filetype.add({
	pattern = {
		['.*/?git/config'] = 'gitconfig',
	},
})

-- Language: Git ignore file
vim.filetype.add({
	filename = {
		['.gitignore'] = 'gitignore',
	},
})

-- Language: Jinja2 templates
vim.filetype.add({
	ext = {
		['jinja']  = 'jinja',
		['jinja2'] = 'jinja',
		['j2']     = 'jinja',
	},
})

-- Language: TSConfig file
vim.filetype.add({
	filename = {
		['tsconfig.json'] = 'jsonc',
	},
	pattern = {
		['tsconfig%..+%.json'] = 'jsonc',
	},
})

-- Language: SAS analytics programming language
vim.filetype.add({
	ext = {
		['sas'] = 'sas',
	},
})

-- Language: Salt States template
vim.filetype.add({
	ext = {
		['sls'] = 'sls.yaml',
	},
})

-- Language: SSH configuration
vim.filetype.add({
	filename = {
		['ssh_config'] = 'sshconfig',
	},
	pattern = {
		['.*/%.?ssh/config'] = 'sshconfig',
	},
})
