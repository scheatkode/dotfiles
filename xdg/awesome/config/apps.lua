local m = {
   editor   = os.getenv('EDITOR')   or 'nano',
   -- terminal = os.getenv('TERMINAL') or os.getenv('TERM') or 'alacritty',
   terminal = 'alacritty',
}

m.editor_cmd = m.terminal .. ' -e ' .. m.editor
m.manual_cmd = m.terminal .. ' -e man awesome'

return m
