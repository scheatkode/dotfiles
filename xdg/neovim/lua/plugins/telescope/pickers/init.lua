local lazy         = require('lazy.on_module_call')
local lazy_default = require('lazy.on_member_call')

local builtin = lazy_default('telescope.builtin')

return {
	buffers    = lazy('plugins.telescope.pickers.buffers'),
	find_files = lazy('plugins.telescope.pickers.find_files'),
	find_notes = lazy('plugins.telescope.pickers.find_notes'),
	live_grep  = lazy('plugins.telescope.pickers.live_grep'),

	lsp_document_symbols          = lazy('plugins.telescope.pickers.lsp_document_symbols'),
	lsp_workspace_symbols         = lazy('plugins.telescope.pickers.lsp_workspace_symbols'),
	lsp_workspace_dynamic_symbols = lazy('plugins.telescope.pickers.lsp_workspace_dynamic_symbols'),

	project_or_find_files    = lazy('plugins.telescope.pickers.project_or_find_files'),
	git_current_file_commits = lazy('plugins.telescope.pickers.git_current_file_commits'),

	projects = lazy('plugins.telescope.pickers.projects'),

	autocommands           = builtin.autocommands,
	buffer_fuzzy           = builtin.current_buffer_fuzzy_find,
	commands               = builtin.commands,
	diagnostics            = builtin.diagnostics,
	git_branches           = builtin.git_branches,
	git_commits            = builtin.git_commits,
	grep_string            = builtin.grep_string,
	help_tags              = builtin.help_tags,
	keymaps                = builtin.keymaps,
	loclist                = builtin.loclist,
	lsp_code_actions       = builtin.lsp_code_actions,
	lsp_definitions        = builtin.lsp_definitions,
	lsp_implementations    = builtin.lsp_implementations,
	lsp_range_code_actions = builtin.lsp_range_code_actions,
	lsp_references         = builtin.lsp_references,
	lsp_type_definitions   = builtin.lsp_type_definitions,
	man_pages              = builtin.man_pages,
	marks                  = builtin.marks,
	quickfix               = builtin.quickfix,
	registers              = builtin.registers,
	spell_suggest          = builtin.spell_suggest,
	vim_options            = builtin.vim_options,
}
