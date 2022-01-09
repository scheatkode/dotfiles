local has_comment, comment = pcall(require, 'Comment')

if not has_comment then
   print('‼ Tried loading Comment.nvim ... unsuccessfully.')
   return has_comment
end

return comment.setup {
   --- Add a space b/w comment and the line
   --- @type boolean
   padding = true,

   --- Line which should be ignored while comment/uncomment
   --- Example: Use '^$' to ignore empty lines
   --- @type string Lua regex
   ignore = '^$',

   --- Whether to create basic (operator-pending) and extra mappings for
   --- NORMAL/VISUAL mode
   --- @type table
   mappings = {
      --- operator-pending mapping
      --- Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
      basic = true,
      --- extra mapping
      --- Includes `gco`, `gcO`, `gcA`
      extra = true,
      --- extended mapping
      --- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      extended = false,
   },

   --- LHS of line and block comment toggle mapping in NORMAL/VISUAL mode
   --- @type table
   toggler = {
      --- line-comment toggle
      line = 'gcc',
      --- block-comment toggle
      block = 'gcb',
   },

   --- LHS of line and block comment operator-mode mapping in NORMAL/VISUAL mode
   --- @type table
   opleader = {
      --- line-comment opfunc mapping
      line = 'gc',
      --- block-comment opfunc mapping
      block = 'gb',
   },

   --- Pre-hook, called before commenting the line
   --- @type function|nil
   pre_hook = function (context)
      local u = require('Comment.utils')

      --- determine whether to use linewise or blockwise commentsring.
      local type = context.ctype == u.ctype.line
         and '__default'
         or  '__multiline'

      --- determine the location from which to calculate the commentstring.
      local location = nil

      if context.ctype == u.ctype.block then
         location = require('ts_context_commentstring.utils').get_cursor_location()
      elseif context.cmation == u.cmotion.v or context.cmotion == u.cmotion.V then
         location = require('ts_context_commentstring.utils').get_visual_start_location()
      end

      return require('ts_context_commentstring.internal').calculate_commentstring({
              key = type,
         location = location
      })
   end,

   --- Post-hook, called after commenting is done
   --- @type function|nil
   post_hook = nil,
}
