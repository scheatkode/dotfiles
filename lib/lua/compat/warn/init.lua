--- @diagnostic disable: deprecated

if warn then
	return warn
end

local enabled = false

---Emits a warning with a message composed by the concatenation
---of all its arguments (which should be strings).
---@version >5.4
---@param message string
---@vararg any
return function(message, ...)
	if type(message) == "string" and message:sub(1, 1) == "@" then
		--- control message
		if message == "@on" then
			enabled = true
			return
		end

		if message == "@off" then
			enabled = false
			return
		end

		--- ignore unknown control messages
		return
	end

	if enabled then
		io.stderr:write("Lua warning: ", message, ...)
		io.stderr:write("\n")
	end
end
