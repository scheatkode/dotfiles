local has_whichkey, whichkey = pcall(require, 'which-key')

if not has_whichkey then
   return has_whichkey
end

whichkey.register({
   ['<leader>g'] = {
      name = '+git',

      g = 'Git porcelain',

      b = 'Blame line',
      d = 'Diff',
      p = 'Preview hunk',
      r = 'Reset hunk',
      R = 'Reset buffer',
      s = 'Stage hunk',
      u = 'Undo stage hunk',
   },
})
