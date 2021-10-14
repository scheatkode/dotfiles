return setmetatable({}, {
   __index = function (_, file)
      local ok, metafile = pcall(require, 'meta.' .. file)

      if not ok then
         error('Metadata file ' .. file .. ' not found.')
         return ok
      end

      return metafile
   end,
})
