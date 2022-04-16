local h = require('scheatkode.highlight')

local function is_invalid_buffer()
   return
             vim.bo.filetype == ''
      or     vim.bo.filetype == 'norg'
      or     vim.bo.buftype  ~= ''
      or not vim.bo.modifiable
end

local function toggle_trailing(mode)
   assert(mode == 'n' or mode == 'i', 'Invalid mode: ' .. mode)

   if is_invalid_buffer() or scheatkode.is_floating_window() then
      vim.wo.list = false
      return
   end

   if not vim.wo.list then
      vim.wo.list = true
   end

   local pattern = mode == 'i'
      and [[\s\+\%#\@<!$]]
      or  [[\s\+$]]

   if vim.w.whitespace_match_number then
      vim.fn.matchdelete(vim.w.whitespace_match_number)
      vim.fn.matchadd('ExtraWhitespace', pattern, 10, vim.w.whitespace_match_number)

      return
   end

   vim.w.whitespace_match_number = vim.fn.matchadd('ExtraWhitespace', pattern)
end

h.set_hl('ExtraWhitespace', { guifg = 'red' })

local augroup = vim.api.nvim_create_augroup('WhitespaceHighlight', {clear = true})

vim.api.nvim_create_autocmd('ColorScheme', {
	group    = augroup,
	callback = function () h.set_hl('ExtraWhitespace', {guifg = 'red'}) end,
})

vim.api.nvim_create_autocmd({'BufEnter', 'FileType', 'InsertLeave'}, {
	group    = augroup,
	callback = function () toggle_trailing('n') end,
})

vim.api.nvim_create_autocmd('InsertEnter', {
	group    = augroup,
	callback = function () toggle_trailing('i') end,
})
