local execute = require('compat.execute')
local flags   = require('compat.flags')

describe('compat', function()
	describe('execute', function()
		local original_os
		local is_windows
		local is_lua51
		local is_luajit52

		before_each(function()
			original_os = os
			is_windows  = flags.is_windows
			is_lua51    = flags.lua51
			is_luajit52 = flags.luajit52

			os = {}
		end)

		after_each(function()
			flags.is_windows = is_windows
			flags.lua51      = is_lua51
			flags.luajit52   = is_luajit52

			os = original_os
		end)

		it('should call `os.execute`', function()
			local called = 0

			os.execute = function(s)
				called = called + 1
				assert.are.same('something', s)
				return 0, 0, 0
			end

			execute('something')
			assert.are.same(1, called)
		end)

		it('should work correctly on Windows, non Lua5.1', function()
			local called = 0

			flags.is_windows = true
			flags.lua51      = false

			os.execute = function()
				called = called + 1
				return 0, 0, 0
			end

			local r1, r2 = execute('something')

			assert.are.same(true, r1)
			assert.are.same(0, r2)
		end)

		it('should work correctly and report `-1`', function()
			local called = 0

			flags.is_windows = true
			flags.lua51      = false

			os.execute = function()
				called = called + 1
				return 0, 'No error', 0
			end

			local r1, r2 = execute('something')

			assert.are.same(false, r1)
			assert.are.same(-1, r2)
		end)

		it('should work correctly on Windows, pure Lua5.1', function()
			local called = 0

			flags.is_windows = true
			flags.lua51      = true
			flags.luajit52   = false

			os.execute = function()
				called = called + 1
				return 0, 'No error', 0
			end

			local r1, r2 = execute('something')

			assert.are.same(true, r1)
			assert.are.same(0, r2)
		end)

		it('should work correctly on non-Windows, pure Lua5.1, with exit code > 256', function()
			local called = 0

			flags.is_windows = false
			flags.lua51      = true
			flags.luajit52   = false

			os.execute = function()
				called = called + 1
				return 257, 'No error', 0
			end

			local r1, r2 = execute('something')

			assert.are.same(false, r1)
			assert.are.same(1, r2)
		end)

		it('should work correctly on non-Windows, pure Lua5.1', function()
			local called = 0

			flags.is_windows = false
			flags.lua51      = true
			flags.luajit52   = false

			os.execute = function()
				called = called + 1
				return 0, 'No error', 0
			end

			local r1, r2 = execute('something')

			assert.are.same(true, r1)
			assert.are.same(0, r2)
		end)

		it('should work correctly on non-Windows', function()
			local called = 0

			flags.is_windows = false
			flags.lua51      = false
			flags.luajit52   = false

			os.execute = function()
				called = called + 1
				return 1, 'No error', 0
			end

			local r1, r2 = execute('something')

			assert.are.same(true, r1)
			assert.are.same(0, r2)
		end)
	end)
end)
