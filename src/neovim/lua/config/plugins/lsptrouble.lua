--- lsp trouble configuration

local has_trouble, trouble = pcall(require, 'trouble')

if not has_trouble then
   print('‼ Tried loading lsp-trouble ... unsuccessfully.')
   return has_trouble
end

trouble.setup({
   height      = 10,          -- height of the trouble list
   icons       = true,        -- use dev-icons for filenames
   mode        = 'workspace', -- 'workspace' or 'document'
   fold_open   = '',         -- icon used for open folds
   fold_closed = '',         -- icon used for closed folds

   action_keys = {              -- key mappings for actions in the trouble list
      close          = 'q',     -- close the list
      refresh        = 'r',     -- manually refresh
      jump           = '<CR>',  -- jump to the diagnostic or open / close folds
      toggle_mode    = 'm',     -- toggle between 'workspace' and 'document' mode
      toggle_preview = 'P',     -- toggle auto_preview
      preview        = 'p',     -- preview the diagnostic location
      close_folds    = 'zM',    -- close all folds
      cancel         = '<Esc>', -- cancel the preview and get back to your last window / buffer / cursor
      open_folds     = 'zR',    -- open all folds
      previous       = 'k',     -- preview item
      next           = 'j',     -- next item
   },

   indent_lines = true, -- add an indent guide below the fold icons
   auto_open    = false, -- automatically open the list when you have diagnostics
   auto_close   = true, -- automatically close the list when you have no diagnostics
   auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back

   -- signs = {
   --     -- icons / text used for a diagnostic
   --     error = '擀',
   --     warning = '㘚',
   --     hint = '⻌',
   --     information = '',
   -- },

   use_lsp_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
})

require('sol.vim').apply_keymaps({
   {'n', '<leader>clT', '<cmd>LspTroubleToggle<CR>', {silent = true, noremap = true}},
   {'n', '<leader>clwT', '<cmd>LspTroubleWorkspaceToggle<CR>', {silent = true, noremap = true}},
})

--- whichkey configuration

local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return has_whichkey
end

whichkey.register({
   ['<leader>cl'] = {
      name = '+lsp',

      T = {'Trouble in code'}
   },

   ['<leader>clwT'] = { 'Trouble in workspace' },
})

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set ft=lua sw=3 ts=3 sts=3 et tw=78:
