local global = vim.g

require('whichkey_setup').config({
   hide_statusline         = true,
   default_keymap_settings = {
      silent  = true,
      noremap = true,
   }
})

global.which_key_align_by_seperator     = true
global.which_key_centered               = true
global.which_key_fallback_to_native_key = true
global.which_key_flatten                = true
global.which_key_hspace                 = 5
global.which_key_ignore_invalid_key     = false
global.which_key_max_size               = 0
global.which_key_position               = 'botright'
global.which_key_run_map_on_popup       = true
global.which_key_sep                    = ''
global.which_key_sort_horizontal        = false
global.which_key_use_floating_win       = false
global.which_key_vertical               = false
-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
