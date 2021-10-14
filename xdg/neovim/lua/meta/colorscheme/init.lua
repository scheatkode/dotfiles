return setmetatable({}, {
   __index = function (_, file)
      local ok, colorscheme = pcall(require, 'meta.colorscheme.' .. file)

      if not ok then
         error('Colorscheme ' .. file .. ' not found.')
         return ok
      end

      return colorscheme
   end,
})
