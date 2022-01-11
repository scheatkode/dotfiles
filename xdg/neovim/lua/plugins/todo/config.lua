-- localize globals {{{

local log = require('log')

-- }}}
-- check for plugin existence {{{

local has_todo, todo = pcall(require, 'todo-comments')

if not has_todo then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'todo-comments')
   return has_todo
end

-- }}}
-- configure plugin {{{

todo.setup({
   signs         = true, -- show icons in the signs column
   sign_priority = 8,    -- sign priority
   -- keywords recognized as todo comments

   keywords = {
      FIX = {
         icon = ' ', -- icon used for the sign, and in search results
         color = 'error', -- can be a hex color, or a named color (see below)
         alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
         -- signs = false, -- configure signs for some keywords individually
      },

      TODO = { icon = ' ', color = 'info'     },
      HACK = { icon = ' ', color = 'warning'  },
      WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' }},
      PERF = { icon = ' ', alt   = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' }},
      NOTE = { icon = ' ', color = 'hint',    alt = { 'INFO' }},
   },

   merge_keywords = true, -- when true, custom keywords will be merged with the defaults
   -- highlighting of the line containing the todo comment
   -- * before: highlights before the keyword (typically comment characters)
   -- * keyword: highlights of the keyword
   -- * after: highlights after the keyword (todo text)

   highlight = {
      before        = '', -- 'fg' or 'bg' or empty
      keyword       = 'bg', -- 'fg', 'bg', 'wide' or empty. (wide is the same as bg, but will also highlight surrounding characters)
      after         = 'fg', -- 'fg' or 'bg' or empty
      comments_only = true, -- this applies the pattern only inside comments using `commentstring` option
      max_line_len  = 400, -- ignore lines longer than this
      exclude       = {}, -- list of file types to exclude highlighting

      pattern = { -- pattern used for highlighting (vim regex)
         [[.*<(KEYWORDS)\(<\w+>\)\s*:]],
         [[.*<(KEYWORDS)\s*:]],
         [[.*\@(KEYWORDS)\s*:]],
      },

   },
   -- list of named colors where we try to extract the guifg from the
   -- list of highlight groups or use the hex color if hl not found as a fallback
   colors = {
      error   = { 'LspDiagnosticsDefaultError',       'ErrorMsg',   '#dc2626' },
      warning = { 'LspDiagnosticsDefaultWarning',     'WarningMsg', '#fbbf24' },
      info    = { 'LspDiagnosticsDefaultInformation', '#2563eb' },
      hint    = { 'LspDiagnosticsDefaultHint',        '#10b981' },
      default = { 'Identifier',                       '#7c3aed' },
   },

   search = {
      command = 'rg',
      args = {
         '--color=never',
         '--no-heading',
         '--with-filename',
         '--line-number',
         '--column',
      },

      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      pattern = [[\b(KEYWORDS)(\(\b.+\b\))?:]], -- ripgrep regex
      -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
   },
})

-- }}}

log.info('Plugin loaded', 'todo-comments')

return true

-- vim: set fdm=marker fdl=0: