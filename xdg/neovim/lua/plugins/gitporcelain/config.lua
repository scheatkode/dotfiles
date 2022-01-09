-- localize globals {{{1

local log = require('log')

-- check for plugin existence {{{1

local has_porcelain, porcelain = pcall(require, 'neogit')

if not has_porcelain then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'neogit')
   return has_porcelain
end

-- configure plugin {{{1

porcelain.setup({
   disable_signs = false,
   disable_hint = false,
   disable_context_highlighting = false,
   disable_commit_confirmation = false,
   disable_builtin_notifications = false,

   auto_refresh = true,

   commit_popup = {
      kind = 'split',
   },

   kind = 'tab',

   signs = {
      section = { '', '' },
         item = { '', '' },
         hunk = { '', '' },
   },

   integrations = {
      diffview = true,
   },
})

log.info('Plugin loaded', 'neogit')

return true

-- vim: fdm=marker fdl=0:

