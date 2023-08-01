-- Language: Shell scripts
vim.filetype.add({
	extension = {
		["sh"] = "bash",
		["bash"] = "bash",
		["csh"] = "bash",
		["ksh"] = "bash",
		["zsh"] = "bash",
	},
	filename = {
		[".zshrc"] = "bash",
	},
})

-- Language: Bazel/Please build definition file
vim.filetype.add({
	filename = {
		["BUILD"] = "starlark",
	},
	pattern = {
		[".*%.build_defs"] = "starlark",
		[".*%.bzl"] = "starlark",
		["BUILD%..*"] = "starlark",
	},
})

-- Language: Cisco configuration
vim.filetype.add({
	extension = {
		["cisco"] = "cisco",
		["ios"] = "cisco",
	},
})

-- Language: d2 diagram definition file
vim.filetype.add({
	extension = {
		["d2"] = "d2",
	},
})

-- Language: Git config file
vim.filetype.add({
	pattern = {
		[".*/?git/config"] = "gitconfig",
	},
})

-- Language: Git ignore file
vim.filetype.add({
	filename = {
		[".gitignore"] = "gitignore",
	},
})

-- Language: Jinja2 templates
vim.filetype.add({
	extension = {
		["jinja"] = "jinja",
		["jinja2"] = "jinja",
		["j2"] = "jinja",
	},
})

-- Language: TSConfig file
vim.filetype.add({
	extension = {
		["json5"] = "jsonc",
	},
	filename = {
		["tsconfig.json"] = "jsonc",
	},
	pattern = {
		["tsconfig%..+%.json"] = "jsonc",
	},
})

-- Language: SAS analytics programming language
vim.filetype.add({
	extension = {
		["sas"] = "sas",
	},
})

-- Language: Salt States template
vim.filetype.add({
	extension = {
		["sls"] = "sls.yaml",
	},
})

-- Language: SSH configuration
vim.filetype.add({
	filename = {
		["ssh_config"] = "sshconfig",
	},
	pattern = {
		[".*/%.?ssh/config"] = "sshconfig",
	},
})
