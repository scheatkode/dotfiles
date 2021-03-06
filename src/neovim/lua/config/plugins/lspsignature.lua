local has_signature, signature = pcall(require, 'lsp_signature')

if not has_signature then
   print('‼ Tried loading lsp_signature ... unsuccessfully.')
   return has_signature
end

return signature.on_attach({

   bind = true, -- this is mandatory, otherwise  border config won't get
                -- registered.  if you  want  to hook  lspsaga or  other
                -- signature handler, set to false

   doc_lines = 2, -- will  show two  lines of  comment/doc(if there  are
                  -- more than two lines in doc, will be truncated); set
                  -- to 0  if you  DO NOT  want any  API comments  to be
                  -- shown.  this setting  only takes  effect in  insert
                  -- mode, it  does not affect signature  help in normal
                  -- mode, 10 by default

   floating_window = true, -- show  hint in  a floating  window, set  to
                           -- false for virtual text only mode

   hint_enable = true, -- virtual hint enable
   hint_prefix = "ⓘ ", -- icon
   hint_scheme = "String",

   use_lspsaga = true, -- set to true if you want to use lspsaga popup

   hi_parameter = "Search", -- how your parameter will be highlighted

   max_height = 12, -- max  height  of   signature  floating_window,  if
                    -- content is  more than max_height, you  can scroll
                    -- down to view the hiding contents

   max_width = 120, -- max_width of signature floating_window, line will
                    -- be wrapped if exceed max_width

   handler_opts = {
      border = "single"   -- double, single, shadow, none
   },

})

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
