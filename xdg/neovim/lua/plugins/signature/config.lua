-- localize globals {{{1

local log = require('log')

-- check for plugin existence {{{1

local has_signature, signature = pcall(require, 'lsp_signature')

if not has_signature then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'lsp-signature')
   return has_signature
end

-- configure plugin {{{1

signature.on_attach({

   -- autoclose  signature  float   win  after  x  sec,
   -- disabled if `nil`.
   auto_close_after = 5,

   -- this is mandatory,  otherwise border config won't
   -- get registered.  if you  want to hook  lspsaga or
   -- other signature handler, set to `false`.
   bind = true,

   -- will show four lines of comment/doc (if there are
   -- more than two lines in doc, the excess lines will
   -- be truncated);  set to 0  if you DO NOT  want any
   -- API comments to be shown. this setting only takes
   -- effect  in  insert  mode,   it  does  not  affect
   -- signature help in normal mode, 10 by default.
   doc_lines = 4,

   -- show hint in a floating  window, set to false for
   -- virtual text only mode.
   floating_window = true,

   -- try to place the  floating above the current line
   -- when  possible. Note:  will  set  to `true`  when
   -- fully tested,  set to `false` will  use whichever
   -- side has more space  this setting will be helpful
   -- if you do not want the PUM and floating window to
   -- overlap.
   floating_window_above_cur_line = true,

   hint_enable = true, -- virtual hint enable.
   hint_prefix = 'ⓘ ', -- icon.
   hint_scheme = 'String',

   -- how the parameter will be highlighted.
   hi_parameter = 'Search',

   -- max height  of the signature floating  window, if
   -- content is more than `max_height`, you can scroll
   -- down to view the hidden contents.
   max_height = 12,

   -- max width of signature floating window, line will
   -- be wrapped if it exceeds `max_width`.
   max_width = 80,

   handler_opts = {
      border = 'rounded'   -- double, single, shadow, none
   },

})

-- {{{1

log.info('Plugin loaded', 'lsp-signature')

return true

-- vim: set fdm=marker fdl=0:

