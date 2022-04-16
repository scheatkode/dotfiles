---setup quickfix toggle. internally  sets  up  autocommands  to
---follow  the  quickfix  window  state  as  well  to  keep  the
---functionality consistent.
---
---@return function toggle_quickfix function to toggle quickfix
local function setup ()
   local qf_is_open = false

   local function toggle_quickfix ()
      if qf_is_open then
         vim.cmd('cclose')
         return
      end

      vim.cmd('copen')
   end

   local augroup = vim.api.nvim_create_augroup('QuickFixToggle', {clear = true})

   vim.api.nvim_create_autocmd('BufWinEnter', {
      group    = augroup,
      pattern  = 'quickfix',
      callback = function () qf_is_open = true end,
   })

   vim.api.nvim_create_autocmd('BufWinLeave', {
      group    = augroup,
      callback = function () qf_is_open = false end,
   })

   return toggle_quickfix
end

return {
   setup = setup
}
