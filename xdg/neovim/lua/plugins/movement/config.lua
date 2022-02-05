local has_plugin, plugin = pcall(require, 'lightspeed')
local log = require('log')

if not has_plugin then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'lightspeed')
   return has_plugin
end

plugin.setup({
   ignore_case = true,
   exit_after_idle_msecs = {
      unlabeled = 1000, labeled = nil
   },

   --- s/x ---
   jump_to_unique_chars = { safety_timeout = 400 },
   match_only_the_start_of_same_char_seqs = true,
   force_beacons_into_match_width = false,

   -- display characters in a custom way in the highlighted matches.
   substitute_chars = { ['\r'] = '¬', },

   -- leaving the appropriate list empty effectively disables "smart" mode,
   -- and forces auto-jump to be on or off.
   safe_labels = {},
   labels = {},

   -- these keys are captured directly by the plugin at runtime.
   special_keys = {
      next_match_group = '<space>',
      prev_match_group = '<tab>',
   },

   --- f/t ---
   limit_ft_matches = 4,
   repeat_ft_with_target_char = false,
})

