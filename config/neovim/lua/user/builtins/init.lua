---Disable (mostly) unused Vim builtin plugins for better
---startup performance. Whenever needed, these can be manually
---loaded.
local function setup(overrides)
	local fmt = string.format
	local set = vim.api.nvim_set_var
	local defaults = {
		["2html_plugin"] = false,
		getscript = false,
		getscriptPlugin = false,
		gzip = false,
		logipat = false,
		man = false,
		matchit = false,
		matchparen = false,
		netrw = false,
		netrwFileHandlers = false,
		netrwPlugin = false,
		netrwSettings = false,
		rrhelper = false,
		spellfile_plugin = false,
		tar = false,
		tarPlugin = false,
		tutor_mode_plugin = false,
		vimball = false,
		vimballPlugin = false,
		zip = false,
		zipPlugin = false,
	}

	local builtins = vim.tbl_extend("force", defaults, overrides or {})

	for name, enabled in pairs(builtins) do
		if enabled == false then
			set(fmt("loaded_%s", name), 2)
		end
	end
end

return {
	setup = setup,
}
