local flags = require('compat.flags')

---Execute a shell command in a compatible and platform
---independent way. This is a compatibility function that
---returns the same for Lua 5.1 and Lua 5.2+.
---
---NOTE: Windows systems can use signed 32 bit integer exit
---codes. Posix systems only use exit codes in the [0..255]
---range, anything else is considered undefined.
---
---NOTE: In Lua5.2 and 5.3, a Windows exit code of `-1` would
---not be properly returned, this function will handle it
---properly for all versions.
---
---@param command string a shell command
---@return boolean success true if successful
---@return number code actual return code
return function(command)
	local r1, r2, r3 = os.execute(command)

	if
		    r2 == 'No error'
		and r3 == 0
		and flags.is_windows
	then

		-- `os.execute` bug in Lua 5.2/5.3 not reporting `-1`
		-- properly on Windows was fixed in 5.4.

		r3 = -1
	end

	if
		        flags.lua51
		and not flags.luajit52
	then
		if flags.is_windows then
			return r1 == 0, r1
		end

		if r1 > 255 then
			r1 = math.floor(r1 / 256)
		end

		return r1 == 0, r1
	end

	if flags.is_windows then
		return r3 == 0, r3
	end

	return not not r1, r3
end
