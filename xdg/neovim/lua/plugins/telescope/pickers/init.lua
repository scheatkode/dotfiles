local lazy         = require('load.on_module_call')
local lazy_default = require('load.on_member_call')

local builtin = lazy_default('telescope.builtin')

return setmetatable({
	buffers    = lazy('plugins.telescope.pickers.buffers'),
	find_files = lazy('plugins.telescope.pickers.find_files'),
	find_notes = lazy('plugins.telescope.pickers.find_notes'),
	live_grep  = lazy('plugins.telescope.pickers.live_grep'),

	lsp_document_symbols          = lazy('plugins.telescope.pickers.lsp_document_symbols'),
	lsp_workspace_symbols         = lazy('plugins.telescope.pickers.lsp_workspace_symbols'),
	lsp_workspace_dynamic_symbols = lazy('plugins.telescope.pickers.lsp_workspace_dynamic_symbols'),

	project_or_find_files    = lazy('plugins.telescope.pickers.project_or_find_files'),
	git_current_file_commits = lazy('plugins.telescope.pickers.git_current_file_commits'),

	projects     = lazy('plugins.telescope.pickers.projects'),
	file_browser = lazy('plugins.telescope.pickers.file_browser'),
}, {
	__index = function(t, k)
		local result = rawget(t, k)

		if result ~= nil then
			return result
		end

		return builtin[k]
	end,
})
