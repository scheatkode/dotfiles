local action_state = require('telescope.actions.state')

local m = {}

m.delete_selected = function (prompt_bufnr)
   local picker = action_state.get_current_picker(prompt_bufnr)

   for _, entry in ipairs(picker:get_multi_selection()) do
      vim.api.nvim_buf_delete(entry.bufnr, {})
   end
end

return m

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80
