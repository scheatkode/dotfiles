-- local has_comment, comment = pcall(require, 'kommentary.config')

-- if not has_comment then
--    print('‼ Tried loading kommentary ... unsuccessfully.')
--    return has_comment
-- end

-- -- additional mappings for increasing/decreasing commenting level for the
-- -- current line.
-- comment.use_extended_mappings()

-- -- configure commenting behavior

-- comment.configure_language('default', {
--    prefer_single_line_comments = true,
--    use_consistent_indentation  = true,
--    ignore_whitespace           = true,
-- })

-- -- comment.configure_language('php', {
-- --    prefer_single_line_comments = false,
-- -- })

local has_comment, comment = pcall(require, 'Comment')

if not has_comment then
   print('‼ Tried loading Comment.nvim ... unsuccessfully.')
   return has_comment
end

return comment.setup {
   ---Add a space b/w comment and the line
   ---@type boolean
   padding = true,

   ---Line which should be ignored while comment/uncomment
   ---Example: Use '^$' to ignore empty lines
   ---@type string Lua regex
   ignore = '^$',

   ---Whether to create basic (operator-pending) and extra mappings for
   ---NORMAL/VISUAL mode
   ---@type table
   mappings = {
      ---operator-pending mapping
      ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
      basic = true,
      ---extended mapping
      ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      extra = false,
   },

   ---LHS of line and block comment toggle mapping in NORMAL/VISUAL mode
   ---@type table
   toggler = {
      ---line-comment toggle
      line = 'gcc',
      ---block-comment toggle
      block = 'gcb',
   },

   ---LHS of line and block comment operator-mode mapping in NORMAL/VISUAL mode
   ---@type table
   opleader = {
      ---line-comment opfunc mapping
      line = 'gc',
      ---block-comment opfunc mapping
      block = 'gb',
   },

   ---Pre-hook, called before commenting the line
   ---@type function|nil
   pre_hook = function ()
      return require('ts_context_commentstring.internal').calculate_commentstring()
   end,

   ---Post-hook, called after commenting is done
   ---@type function|nil
   post_hook = nil,
}
