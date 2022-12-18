local assert   = assert
local sf       = string.format
local identity = require('f.function.identity')
local pack     = require('compat').table_pack

local escape = '\x1b'

local attributes = {
	reset         = 0,
	bold          = 1,
	faint         = 2,
	italic        = 3,
	underline     = 4,
	blink         = 5,
	blink_fast    = 6,
	reverse_video = 7,
	concealed     = 8,
	strikethrough = 9,
}

local foreground = {
	black   = 30,
	red     = 31,
	green   = 32,
	yellow  = 33,
	blue    = 34,
	magenta = 35,
	cyan    = 36,
	white   = 37,
}

local background = {
	black   = 40,
	red     = 41,
	green   = 42,
	yellow  = 43,
	blue    = 44,
	magenta = 45,
	cyan    = 46,
	white   = 47,
}

---no color environment detection.
---@return boolean
local function has_no_color()
	return os.getenv('NO_COLOR') ~= nil
		or os.getenv('NOCOLOR') ~= nil
		or os.getenv('TERM') == 'dumb'
end

---return a new colorizing function.
---@vararg ... attributes to apply.
---@return function
local function new(...)
	assert(..., 'arguments to new are required')

	if has_no_color() then
		return identity
	end

	local array  = (pack(...))
	local format = table.remove(array, 1)

	for _, v in ipairs(array) do
		format = sf('%s;%s', format, v)
	end

	local prefix = sf('%s[%sm', escape, format)
	local suffix = sf('%s[%sm', escape, attributes.reset)

	-- let the garbage collector do its thing
	array  = nil
	format = nil

	return function(s)
		return sf('%s%s%s', prefix, s, suffix)
	end
end

return {
	attributes = attributes,
	colors     = {
		foreground = foreground,
		background = background,
	},

	new = new,

	-- predefined colors
	black   = new(foreground.black),
	red     = new(foreground.red),
	green   = new(foreground.green),
	yellow  = new(foreground.yellow),
	blue    = new(foreground.blue),
	magenta = new(foreground.magenta),
	cyan    = new(foreground.cyan),
	white   = new(foreground.white),
}
