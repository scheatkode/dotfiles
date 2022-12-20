---check if lazy is already installed
---@return boolean whether `lazy` is already installed
local function is_installed(path)
	return vim.loop.fs_stat(path)
end

---ask yourself. do you want more awesomeness ?
---@return boolean whether we want more awesomeness
local function should_install()
	local choice = vim.fn
		.input('Looks empty here, should I brighten the place up ? (yes/no): ')
		:lower()

	while choice ~= 'yes' and choice ~= 'no' do
		choice = vim.fn
			.input('Just type the full word so that I make sure (yes/no): ')
			:lower()
	end

	return choice == 'yes'
end

---auto installs lazy when needed
local function auto_install(path)
	print('Installing lazy.nvim ...')

	vim.api.nvim_command(table.concat({
		'silent',
		'!git',
		'clone',
		'--filter=blob:none',
		'--single-branch',
		'https://github.com/folke/lazy.nvim',
		path,
	}, ' '))
end

return {
	setup = function(overrides)
		local deep_extend = require('tablex.deep_extend')

		local defaults = {
			install_path = string.format(
				'%s/lazy/lazy.nvim',
				vim.fn.stdpath('data')
			),
		}

		local options = deep_extend('force', defaults, overrides or {})

		if not is_installed(options.install_path) and should_install() then
			auto_install(options.install_path)
		end

		vim.opt.runtimepath:prepend(options.install_path)

		require('lazy').setup('plugins', {
			defaults = { lazy = true },
			lockfile = vim.fn.stdpath('data') .. 'lazy-lock.json',
		})
	end,
}
