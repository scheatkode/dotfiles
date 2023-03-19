local separator = require("compat.separator")

local m = {}

---Boolean flag for Lua 5.1 or LuaJIT.
m.lua51 = _VERSION == "Lua 5.1"

---Boolean flag for LuaJIT.
m.luajit = type(jit) == "table"

---Boolean flag for Neovim.
m.neovim = type(vim) == "table"

---Boolean flag for LuaJit with Lua 5.2 compatibility compiled
---in. Detection happens with `goto` since it is considered
---a keyword when 5.2 compatibility is enabled in LuaJit.
if m.luajit then
	m.luajit52 = not loadstring("local goto = 1")
end

---Boolean flag for Windows detection.
m.is_windows = separator == "\\"

return m
