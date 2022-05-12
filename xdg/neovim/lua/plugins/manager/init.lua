---check if packer is already installed
---@return boolean whether `packer` is already installed
local function is_installed(path)
	return vim.fn.isdirectory(path) == 1
end

---ask yourself. do you want more awesomeness ?
---@return boolean whether we want more awesomeness
local function should_install()
	local choice = vim.fn.input('Looks empty here, should I brighten the place up ? (yes/no): '):lower()

	while choice ~= 'yes' and choice ~= 'no' do
		choice = vim.fn.input('Just type the full word so that I make sure (yes/no): '):lower()
	end

	return choice == 'yes'
end

---auto installs packer when needed and returns true when a sync
---is required
---@return boolean whether a sync is required
local function auto_install(path)
	print('Installing packer.nvim ...')
	vim.api.nvim_command(
		'silent !git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. path
	)
end

local function setup(overrides)
	local defaults = {
		install_path = string.format(
			'%s/site/pack/packer/start/packer.nvim',
			vim.fn.stdpath('data')
		)
	}

	local options = require('tablex').deep_extend(
		'force',
		defaults,
		overrides or {}
	)

	if is_installed(options.install_path) then
		require('plugins.manager.config').setup()
		require('plugins.manager.register').setup()
		require('plugins.manager.keys').setup()
		return
	end

	if not should_install() then
		return
	end

	auto_install(options.install_path)

	-- `packadd` doesn't work in a `schedule_wrap`ped functions,
	-- this hack modifies `package.path` so that `require`ing
	-- `packer` still works.

	local packer_path = options.install_path .. '/lua'
	package.path      = string.format(
		'%s;%s/?.lua;%s/?/init.lua',
		package.path,
		packer_path,
		packer_path
	)

	require('plugins.manager.config').setup()
	require('plugins.manager.register').setup()
	require('plugins.manager.keys').setup()
	require('packer').sync()

	-- another hack to trigger `VimEnter` when `packer` completes
	-- its initial installation. this ensures that plugins
	-- lazy-loaded through said event are not forgotten.

	local augroup = vim.api.nvim_create_augroup('TriggerVimEnter', { clear = false })

	vim.api.nvim_create_autocmd('User', {
		once     = true,
		group    = augroup,
		pattern  = 'PackerComplete',
		callback = function()
			vim.api.nvim_command('doautocmd VimEnter')
			vim.api.nvim_del_augroup_by_id(augroup)
		end
	})
end

return {
	setup = setup
}
