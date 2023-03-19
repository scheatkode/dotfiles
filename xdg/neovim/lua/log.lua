-- local api = vim.api
local level = vim.log.levels
local m = {}

--[[
   Log a message.

   @param message         → message to display
   @param highlight_group → highlight group to colorize the message
   @param name            → prepend the message with a name
--]]
m.log = function(message, log_level, name)
	name = name or "Neovim"
	-- api.nvim_echo({{ name .. ' : ', log_level }, { message }}, true, {})
	vim.notify(name .. " : " .. message, log_level)
end

--[[
   Log a warning message.

   @param message → message to display
   @param name    → prepend the message with a name
--]]
m.warn = function(message, name)
	-- m.log(message, 'LspDiagnosticsDefaultWarning', name)
	m.log(message, level.WARN, name)
end

--[[
   Log an error message.

   @param message → message to display
   @param name    → prepend the message with a name
--]]
m.error = function(message, name)
	-- m.log(message, 'LspDiagnosticsDefaultError', name)
	m.log(message, level.ERROR, name)
end

--[[
   Log an informational message.

   @param message → message to display
   @param name    → prepend the message with a name
--]]
m.info = function(message, name)
	-- m.log(message, 'LspDiagnosticsDefaultInformation', name)
	m.log(message, level.INFO, name)
end

return m
