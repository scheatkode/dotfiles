local function setup ()
   vim.keymap.set('n', '<leader>/', 'gcc', {remap = true, desc = 'Comment current line'})
   vim.keymap.set('v', '<leader>/', 'gc',  {remap = true, desc = 'Comment lines'})
end

return {
   setup = setup
}
