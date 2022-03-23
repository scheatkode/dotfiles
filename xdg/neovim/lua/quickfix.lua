---setup quickfix toggle. internally  sets  up  autocommands  to
---follow  the  quickfix  window  state  as  well  to  keep  the
---functionality consistent.
---
---@return function toggle_quickfix function to toggle quickfix
local function setup ()
   local vcmd       = vim.cmd
   local qf_is_open = false

   local function follow_open_quickfix  () qf_is_open = true  end
   local function follow_close_quickfix () qf_is_open = false end

   local function toggle_quickfix ()
      if qf_is_open then
         vcmd('cclose')
         return
      end

      vcmd('copen')
   end

   scheatkode.augroup('QuickFixToggle', {{
      command = follow_open_quickfix,
      events  = {'BufWinEnter'},
      targets = {'quickfix'},
   }, {
      command = follow_close_quickfix,
      events  = {'BufWinLeave'},
      targets = {'*'},
   }})

   return toggle_quickfix
end

return {
   setup = setup
}
