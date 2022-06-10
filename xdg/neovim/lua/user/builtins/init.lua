---Disable (mostly) unused Vim builtin plugins for better
---startup performance. Whenever needed, these can be manually
---loaded.
local function setup(overrides)
	local defaults = {
		['2html_plugin']  = false,
		getscript         = false,
		getscriptPlugin   = false,
		gzip              = false,
		logipat           = false,
		matchit           = false,
		matchparen        = false,
		netrw             = false,
		netrwFileHandlers = false,
		netrwPlugin       = false,
		netrwSettings     = false,
		rrhelper          = false,
		spellfile_plugin  = false,
		tar               = false,
		tarPlugin         = false,
		vimball           = false,
		vimballPlugin     = false,
		zip               = false,
		zipPlugin         = false,
	}

	local builtins = vim.tbl_extend('force', defaults, overrides or {})

	for _, plugin in ipairs(builtins) do
		vim.g['loaded_' .. plugin] = 2
	end
end

return {
	setup = setup
}
