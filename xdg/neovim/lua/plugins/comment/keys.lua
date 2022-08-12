local function setup ()
   -- toggle using count
   vim.keymap.set('n', '<leader>/', 'v:count == 0 ? "<Plug>(comment_toggle_linewise_current)"  : "<Plug>(comment_toggle_linewise_count)"',  {expr = true, remap = true, desc = 'Comment current line(s)'})
   vim.keymap.set('n', 'gcc',       'v:count == 0 ? "<Plug>(comment_toggle_linewise_current)"  : "<Plug>(comment_toggle_linewise_count)"',  {expr = true, remap = true, desc = 'Comment current line(s)'})
   vim.keymap.set('n', 'gbc',       'v:count == 0 ? "<Plug>(comment_toggle_linewise_blockwise)" : "<Plug>(comment_toggle_blockwise_count)"', {expr = true, remap = true, desc = 'Comment current line(s)'})

   -- toggle in op-pending mode
   vim.keymap.set('n', '<leader>//', '<Plug>(comment_toggle_linewise)',  {remap = true})
   vim.keymap.set('n', 'gc',         '<Plug>(comment_toggle_linewise)',  {remap = true})
   vim.keymap.set('n', 'gb',         '<Plug>(comment_toggle_blockwise)', {remap = true})

   -- toggle in visual mode
   vim.keymap.set('x', '<leader>/', '<Plug>(comment_toggle_linewise_visual)',  {remap = true, desc = 'Comment lines'})
   vim.keymap.set('x', 'gc',        '<Plug>(comment_toggle_linewise_visual)',  {remap = true, desc = 'Comment lines'})
   vim.keymap.set('x', 'gb',        '<Plug>(comment_toggle_blockwise_visual)', {remap = true, desc = 'Comment lines'})
end

return {
   setup = setup
}
