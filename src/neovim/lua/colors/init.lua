local m = setmetatable({}, {
   __index = function (table, file)
      local ok, colorscheme = pcall(require, 'colors.' .. file)

      if not ok then
         error('Colorscheme ' .. file .. ' not found.')
         return ok
      end

      return colorscheme
   end,
})

return m

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80 fmr={{{,}}} fdl=0 fdm=marker:
