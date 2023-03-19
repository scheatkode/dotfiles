local fmt = string.format

local f = require("f")
local concat = require("f.operator.concat")

local gen = require("arbitrary.string")

local fgen = f.wrap(function(_, _)
	return 0, gen()
end, 0, 0)

describe("string operator", function()
	describe("concat()", function()
		f.zip(fgen:take(100), fgen:take(100)):foreach(function(x, y)
			it(fmt('should concat "%s" and "%s"', x, y), function()
				assert.are.same(x .. y, concat(x, y))
			end)
		end)
	end)
end)
