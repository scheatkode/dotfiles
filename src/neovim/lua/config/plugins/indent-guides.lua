--- indent guides configuration

local global = vim.g

-- default configuration

global.indent_blankline_char            = '│'
global.indent_blankline_indent_level    = 10
global.indent_blankline_viewport_buffer = 30

-- treesitter related configuration

global.indent_blankline_use_treesitter                 = true
global.indent_blankline_show_current_context           = true -- requires treesitter
global.indent_blankline_show_trailing_blankline_indent = false

global.indentLine_bufTypeExclude = {
   'nofile',
   'terminal',
}

global.indentLine_fileTypeExclude = {
   'startify',
   'help',
   'LspTrouble',
   'packer',
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
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
