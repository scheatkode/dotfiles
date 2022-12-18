local hsluv = require('hsluv')
local specs = require('hsluv.specs')

local function assert_close_enough(a, b)
	local s_a = string.format('(%f,%f,%f)', a[1], a[2], a[3])
	local s_b = string.format('(%f,%f,%f)', b[1], b[2], b[3])

	for i = 1, #a do
		assert.is_true(
			math.abs(a[i] - b[i]) < 0.00000001,
			string.format('mismatch: %s %s', s_a, s_b)
		)
	end
end

describe('hsluv', function()
	for hex, colors in pairs(specs) do
		describe(string.format('forward functions on %s', hex), function()
			local test_rgb   = hsluv.hex_to_rgb(hex)
			local test_xyz   = hsluv.rgb_to_xyz(test_rgb)
			local test_luv   = hsluv.xyz_to_luv(test_xyz)
			local test_lch   = hsluv.luv_to_lch(test_luv)
			local test_hsluv = hsluv.lch_to_hsluv(test_lch)
			local test_hpluv = hsluv.lch_to_hpluv(test_lch)

			it('should convert from hex to rgb', function()
				assert_close_enough(test_rgb, colors.rgb)
			end)

			it('should convert from rgb to xyz', function()
				assert_close_enough(test_xyz, colors.xyz)
			end)

			it('should convert from xyz to luv', function()
				assert_close_enough(test_luv, colors.luv)
			end)

			it('should convert from luv to lch', function()
				assert_close_enough(test_lch, colors.lch)
			end)

			it('should convert from lch to hsluv', function()
				assert_close_enough(test_hsluv, colors.hsluv)
			end)

			it('should convert from hsluv to hpluv', function()
				assert_close_enough(test_hpluv, colors.hpluv)
			end)
		end)

		describe(string.format('backward functions on %s', hex), function()
			local test_lch1 = hsluv.hsluv_to_lch(colors.hsluv)
			local test_lch2 = hsluv.hpluv_to_lch(colors.hpluv)
			local test_luv = hsluv.lch_to_luv(test_lch1)
			local test_xyz = hsluv.luv_to_xyz(test_luv)
			local test_rgb = hsluv.xyz_to_rgb(test_xyz)

			it('should convert from hsluv to lch', function()
				assert_close_enough(test_lch1, colors.lch)
			end)

			it('should convert from hpluv to lch', function()
				assert_close_enough(test_lch2, colors.lch)
			end)

			it('should convert from lch to luv', function()
				assert_close_enough(test_luv, colors.luv)
			end)

			it('should convert from luv to xyz', function()
				assert_close_enough(test_xyz, colors.xyz)
			end)

			it('should convert from xyz to rgb', function()
				assert_close_enough(test_rgb, colors.rgb)
			end)

			it('the rgb format should equal the initial hex value', function()
				assert.are.equal(hsluv.rgb_to_hex(test_rgb), hex)
			end)
		end)

		describe(string.format('full on %s', hex), function()
			it('should convert hsluv to hex', function()
				assert.are.equal(hsluv.hsluv_to_hex(colors.hsluv), hex)
			end)

			it('should convert hex to hsluv', function()
				assert_close_enough(hsluv.hex_to_hsluv(hex), colors.hsluv)
			end)

			it('should convert hpluv to hex', function()
				assert.are.equal(hsluv.hpluv_to_hex(colors.hpluv), hex)
			end)

			it('should convert hex to hsluv', function()
				assert_close_enough(hsluv.hex_to_hpluv(hex), colors.hpluv)
			end)
		end)
	end
end)
