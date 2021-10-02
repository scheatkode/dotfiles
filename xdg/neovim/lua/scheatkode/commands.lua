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

-- Wipe hidden buffers.
--
-- Wipe  all  deleted  (unloaded  &  unlisted)  or  all
-- unloaded buffers.
api.nvim_exec([[
   command! -bar -bang Bwipeout call miscellaneous#bwipeout(<bang>0)
]], false)
