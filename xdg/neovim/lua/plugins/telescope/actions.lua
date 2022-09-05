local f = require('f')

local telescope = require('telescope')

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local themes  = require('plugins.telescope.themes')

local m = {}

---alias builtin functions to export everything from the same
---place.
m.autocommands           = builtin.autocommands
m.buffer_fuzzy           = builtin.current_buffer_fuzzy_find
m.commands               = builtin.commands
m.diagnostics            = builtin.diagnostics
m.git_branches           = builtin.git_branches
m.git_commits            = builtin.git_commits
m.grep_string            = builtin.grep_string
m.help_tags              = builtin.help_tags
m.keymaps                = builtin.keymaps
m.loclist                = builtin.loclist
m.lsp_code_actions       = builtin.lsp_code_actions
m.lsp_definitions        = builtin.lsp_definitions
m.lsp_implementations    = builtin.lsp_implementations
m.lsp_range_code_actions = builtin.lsp_range_code_actions
m.lsp_references         = builtin.lsp_references
m.lsp_type_definitions   = builtin.lsp_type_definitions
m.man_pages              = builtin.man_pages
m.marks                  = builtin.marks
m.quickfix               = builtin.quickfix
m.registers              = builtin.registers
m.spell_suggest          = builtin.spell_suggest
m.vim_options            = builtin.vim_options

function m.live_grep(open_files)
	open_files = open_files or false

	return builtin.live_grep({
		grep_open_files = open_files,
		max_results     = 200,
		prompt_title    = open_files
			 and 'Live Grep Open Files'
			 or 'Live Grep',
	})
end

function m.find_files(hidden, no_ignore)
	local prompt_title

	hidden    = hidden or false
	no_ignore = no_ignore or false

	if hidden and no_ignore then
		prompt_title = 'Find Hidden & Ignored Files'
	elseif hidden then
		prompt_title = 'Find Hidden Files'
	elseif no_ignore then
		prompt_title = 'Find Ignored Files'
	else
		prompt_title = 'Find Files'
	end

	return builtin.find_files({
		hidden       = hidden,
		no_ignore    = no_ignore,
		prompt_title = prompt_title,
	})
end

function m.project_or_find_files()
	--- `buf_get_clients()` most likely won't return a contiguous list. This
	--- gets the most "generic" LSP client for the current buffer, using a dumb
	--- string length comparison of the `root_dir` property.
	local clients = f
		 .iterate(vim.lsp.buf_get_clients())
		 :filter(function( x) return x and x.config ~= nil end)

	local has_clients, client = pcall(
		f.minimum_by,
		function(x, y) return #x.config.root_dir < #y.config.root_dir end,
		clients
	)

	if has_clients and type(client) ~= 'boolean' then
		return builtin.find_files({
			---@diagnostic disable-next-line: undefined-field
			cwd          = client.config.root_dir,
			prompt_title = 'Find Files in Project',
		})
	end

	local git_dir = vim.fn.finddir('.git', ';')

	if git_dir ~= '' then
		local git_root = vim.fn.fnamemodify(git_dir, ':h')

		return builtin.find_files({
			prompt_title = 'Find Files in Repository',
			cwd          = git_root,
		})
	end

	return m.find_files()
end

function m.find_notes()
	return builtin.find_files({
		prompt_title = ' Notes ',
		cwd          = '~/brain/',
	})
end

function m.git_current_file_commits()
	return builtin.git_bcommits({
		prompt_title = 'Git Commits involving Current File'
	})
end

function m.buffers(all_buffers)
	all_buffers = all_buffers or false

	return builtin.buffers(themes.get_vertical({
		ignore_current_buffer = true,
		show_all_buffers      = all_buffers,
		sort_lastused         = true,

		attach_mappings = function(_, map)
			map('i', '<C-x>', actions.delete_buffer)
			map('n', '<C-x>', actions.delete_buffer)

			return true
		end,
	}))
end

function m.lsp_document_symbols()
	return builtin.lsp_document_symbols({
		show_line = true,
	})
end

function m.lsp_workspace_symbols()
	return builtin.lsp_workspace_symbols({
		show_line = true,
	})
end

function m.lsp_workspace_dynamic_symbols()
	return builtin.lsp_workspace_dynamic_symbols({
		show_line = true,
	})
end

function m.projects()
	return telescope.extensions.project.project({
		display_type   = 'full',
		layout_stategy = 'vertical',
		layout_config  = {
			width  = function(_, max_columns, _)
				return math.min(max_columns, 90)
			end,
			height = function(_, _, max_lines)
				return math.min(max_lines, 40)
			end,
		}
	})
end

---a metatable would be overkill here since the keys are
---accessed afterwards in `plugins.telescope.keys` anyway.
return m
