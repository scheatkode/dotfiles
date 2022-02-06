local h = require('scheatkode.highlight')

local fn = vim.fn

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
      fn.matchdelete(vim.w.whitespace_match_number)
      fn.matchadd('ExtraWhitespace', pattern, 10, vim.w.whitespace_match_number)

      return
   end

   vim.w.whitespace_match_number = fn.matchadd('ExtraWhitespace', pattern)
end

h.set_hl('ExtraWhitespace', { guifg = 'red' })

scheatkode.augroup('WhitespaceHighlight', {{
   events = {
      'ColorScheme',
   },

   targets = {
      '*'
   },

   command = function ()
      h.set_hl('ExtraWhitespace', { guifg = 'red' })
   end,
}, {
   events = {
      'BufEnter',
      'FileType',
      'InsertLeave',
   },

   targets = {
      '*',
   },

   command = function ()
      toggle_trailing('n')
   end,
}, {
   events = {
      'InsertEnter',
   },

   targets = {
      '*',
   },

   command = function ()
      toggle_trailing('i')
   end,
}})

-- vim: set ft=lua:
