return setmetatable({}, {
   __index = function (table, file)
      local ok, metafile = pcall(require, 'meta.' .. file)

      if not ok then
         error('Metadata file ' .. file .. ' not found.')
         return ok
      end

      return metafile
   end,
})

-- Local Variables:
-- tab-width: 3
-- mode: lua
-- End:
-- vim: set sw=3 ts=3 sts=3 et tw=80
