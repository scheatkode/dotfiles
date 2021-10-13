local api = vim.api

-- Delete all open buffers.
--
-- This avoids  using `bufdo` to delete  buffers as per
-- its documentation and uses  the `%` operator instead
-- while also deleting the `[No name]` buffer that gets
-- created.
api.nvim_exec([[
   command! BufOnly silent! execute "%bdelete|edit#|bdelete#"
]], false)
