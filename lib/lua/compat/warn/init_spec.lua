---@diagnostic disable: deprecated

describe("compat", function()
	describe("warn", function()
		local original_warn
		local warn

		-- Userdata can't be stubbed in Lua, we need to construct a table from
		-- the top down to be able to stub the `write` function.

		local called = 0
		local original_io = io
		local stub_io = {
			stderr = {},
		}

		-- `plenary.nvim`'s busted doesn't support `setup` and `teardown`, we're
		-- using `before_each` and `after_each` to overwrite the original `warn`
		-- function if any.

		before_each(function()
			if _G.warn then
				original_warn = _G.warn
				_G.warn = nil
			end

			stub_io.stderr.write = function()
				called = called + 1
			end

			warn = require("compat.warn")
			io = stub_io
		end)

		after_each(function()
			_G.warn = original_warn
			called = 0
			io = original_io
		end)

		it("should do nothing by default", function()
			warn("@something")
			warn("something")
			assert.same(called, 0)
		end)

		it("should enable warnings and call write", function()
			warn("@on")
			warn("something")
			assert.same(called, 2)
		end)

		it("should toggle warnings", function()
			assert.same(called, 0)

			warn("@on")
			warn("something")

			assert.same(called, 2)

			warn("@off")
			warn("something")

			assert.same(called, 2)
		end)
	end)
end)
