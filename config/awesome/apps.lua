local m = {
	editor = os.getenv("EDITOR") or "nvim",
	terminal = "alacritty",
}

m.editor_cmd = string.format("%s --command %s", m.terminal, m.editor)

return m
