local m = {
   editor   = os.getenv('EDITOR') or 'nvim',
   terminal = 'alacritty',
}

m.editor_cmd = m.terminal .. ' -e ' .. m.editor

return m
