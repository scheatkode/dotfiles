return setmetatable({}, {
   __index = function (table, file)
      local ok, colorscheme = pcall(require, 'meta.colorscheme.' .. file)

      if not ok then
         error('Colorscheme ' .. file .. ' not found.')
         return ok
      end

      return colorscheme
   end,
})

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80
