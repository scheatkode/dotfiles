local char = string.char
local random = math.random
local assertx = require("assertx")

local band = bit.band
local rshift = bit.rshift
local concat = table.concat

--Encode a Unicode code point to UTF-8. See RFC 3629.
--
-- Does not check that cp is a real character; that is, doesn't exclude the
-- surrogate range U+D800 - U+DFFF and a handful of others.
--@param cp The Unicode code point as a number
--@return A string containing the code point in UTF-8 encoding.
local function utf8_enc(code_point)
	local bytes = {}
	local mask
	local n

	if code_point % 1.0 ~= 0.0 or code_point < 0 then
		-- Only defined for nonnegative integers.
		return nil
	elseif code_point <= 0x7f then
		-- Special case of one-byte encoding.
		return char(code_point)
	elseif code_point <= 0x7ff then
		n = 2
		mask = 0xC0
	elseif code_point <= 0xffff then
		n = 3
		mask = 0xe0
	elseif code_point <= 0x10ffff then
		n = 4
		mask = 0xF0
	else
		return nil
	end

	while n > 1 do
		bytes[n] = char(0x80 + band(code_point, 0x3f))
		code_point = rshift(code_point, 6)
		n = n - 1
	end

	bytes[1] = char(mask + code_point)

	return concat(bytes)
end

local ranges = {
	{ 0x0021, 0x0021 },
	{ 0x0023, 0x0026 },
	{ 0x0028, 0x007e },
	{ 0x00a1, 0x00ac },
	{ 0x00ae, 0x00ff },
	{ 0x0100, 0x017f },
	{ 0x0180, 0x024f },
	{ 0x2c60, 0x2c7f },
	{ 0x16a0, 0x16f0 },
	{ 0x0370, 0x0377 },
	{ 0x037a, 0x037e },
	{ 0x0384, 0x038a },
	{ 0x038c, 0x038c },
}

local function recurse(length)
	local range = ranges[random(#ranges)]

	if length == 1 then
		return utf8_enc(random(range[1], range[2]))
	end

	return recurse(length - 1) .. utf8_enc(random(range[1], range[2]))
end

local function random_string(length, seed)
	seed = seed or os.clock() ^ 5
	length = length or math.random(100)

	math.randomseed(seed or os.clock() ^ 5)
	assertx(
		type(length) == "number" and length >= 0,
		string.format,
		"wrong argument #1 to random string generator, expected positive number, got %s",
		length
	)

	return recurse(length)
end

return random_string
