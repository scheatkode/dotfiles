local m = {
	editor = os.getenv("EDITOR") or "nvim",
	terminal = "wezterm",
}

m.editor_cmd = m.terminal .. " start -- " .. m.editor

return m
