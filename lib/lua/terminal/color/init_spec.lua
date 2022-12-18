local sf    = string.format
local color = require('terminal.color')

describe('terminal', function()
	describe('color', function()
		local cases = {
			{ code = color.colors.foreground.black, text = 'black' },
			{ code = color.colors.foreground.red, text = 'red' },
			{ code = color.colors.foreground.green, text = 'green' },
			{ code = color.colors.foreground.yellow, text = 'yellow' },
			{ code = color.colors.foreground.blue, text = 'blue' },
			{ code = color.colors.foreground.magenta, text = 'magenta' },
			{ code = color.colors.foreground.cyan, text = 'cyan' },
			{ code = color.colors.foreground.white, text = 'white' },
		}

		for _, c in ipairs(cases) do
			it(sf('should colorize the given text in %s', c.text), function()
				assert.equal(
					sf('\x1b[%sm%s\x1b[0m', c.code, c.text),
					color.new(c.code)(c.text)
				)
			end)
		end

		for _, c in ipairs(cases) do
			it(
				sf(
					'should colorize the given text in %s and make it bold',
					c.text
				),
				function()
					assert.equal(
						sf('\x1b[%s;1m%s\x1b[0m', c.code, c.text),
						color.new(c.code, color.attributes.bold)(c.text)
					)
				end
			)
		end
	end)
end)
