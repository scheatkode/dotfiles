--- indent guides configuration

local global = vim.g

-- default configuration

global.indent_blankline_char         = '│'
global.indent_blankline_indent_level = 5

-- treesitter related configuration

global.indent_blankline_use_treesitter                 = true
global.indent_blankline_show_current_context           = true -- requires treesitter
global.indent_blankline_show_trailing_blankline_indent = false

global.indentLine_bufTypeExclude  = { 'terminal' }
global.indentLine_fileTypeExclude = {
   'startify',
   'help',
   'LspTrouble',
}

global.indent_blankline_context_patterns = {
   'arguments',
   'array',
   'block',
   'class',
   'for',
   'function',
   'if',
   'method',
   'object',
   'table',
   'while',
}

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80 fmr={{{,}}} fdl=0 fdm=marker:
