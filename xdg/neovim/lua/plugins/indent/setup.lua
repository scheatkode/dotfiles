--- indent guides configuration

local global = vim.g

-- default configuration

global.indent_blankline_char            = '│'
global.indent_blankline_indent_level    = 10
global.indent_blankline_viewport_buffer = 30

-- treesitter related configuration

global.indent_blankline_use_treesitter                 = true
global.indent_blankline_show_current_context           = true
global.indent_blankline_show_trailing_blankline_indent = false

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

-- excludes

global.indent_blankline_buftype_exclude = {
   'nofile',
   'terminal',
}

global.indent_blankline_filetype_exclude = {
   'LspTrouble',
   'Outline',
   'help',
   'norg',
   'packer',
   'startify',
}

return true
