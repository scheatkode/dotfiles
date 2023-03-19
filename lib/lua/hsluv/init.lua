-- This is the Lua implementation of HSLuv and HPLuv color spaces by
-- Alexei Boronine, with minor tweaks for code style and performance.
--
-- Homepage: http://www.hsluv.org/
--
-- Copyright (C) 2019 Alexei Boronine
--
-- Permission is hereby granted, free of charge, to any person obtaining
-- a copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
--
-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-- NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
-- BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
-- ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
-- CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local hex_chars = "0123456789abcdef"

local m = {
	{ 3.240969941904521, -1.537383177570093, -0.498610760293 },
	{ -0.96924363628087, 1.87596750150772, 0.041555057407175 },
	{ 0.055630079696993, -0.20397695888897, 1.056971514242878 },
}

local minv = {
	{ 0.41239079926595, 0.35758433938387, 0.18048078840183 },
	{ 0.21263900587151, 0.71516867876775, 0.072192315360733 },
	{ 0.019330818715591, 0.11919477979462, 0.95053215224966 },
}

local ref_y = 1.0
local ref_u = 0.19783000664283
local ref_v = 0.46831999493879
local kappa = 903.2962962
local epsilon = 0.0088564516

local function distance_line_from_origin(line)
	return math.abs(line.intercept) / math.sqrt((line.slope ^ 2) + 1)
end

local function length_of_ray_until_intersect(theta, line)
	return line.intercept / (math.sin(theta) - line.slope * math.cos(theta))
end

local function get_bounds(l)
	local result = {}
	local sub1 = ((l + 16) ^ 3) / 1560896
	local sub2

	if sub1 > epsilon then
		sub2 = sub1
	else
		sub2 = l / kappa
	end

	for i = 1, 3 do
		local m1 = m[i][1]
		local m2 = m[i][2]
		local m3 = m[i][3]

		for t = 0, 1 do
			local top1 = (284517 * m1 - 94839 * m3) * sub2
			local top2 = (838422 * m3 + 769860 * m2 + 731718 * m1) * l * sub2
				- 769860 * t * l
			local bottom = (632260 * m3 - 126452 * m2) * sub2 + 126452 * t

			result[#result + 1] = {
				slope = top1 / bottom,
				intercept = top2 / bottom,
			}
		end
	end

	return result
end

local function max_safe_chroma_for_l(l)
	local min = 1.7976931348623157e+308
	local bounds = get_bounds(l)

	for i = 1, 6 do
		local length = distance_line_from_origin(bounds[i])

		if length >= 0 then
			min = math.min(min, length)
		end
	end

	return min
end

local function max_safe_chroma_for_lh(l, h)
	local min = 1.7976931348623157e+308
	local hrad = h / 360 * math.pi * 2
	local bounds = get_bounds(l)

	for i = 1, 6 do
		local bound = bounds[i]
		local length = length_of_ray_until_intersect(hrad, bound)

		if length >= 0 then
			min = math.min(min, length)
		end
	end

	return min
end

local function dot_product(a, b)
	local sum = 0

	for i = 1, 3 do
		sum = sum + a[i] * b[i]
	end

	return sum
end

local function from_linear(c)
	if c <= 0.0031308 then
		return 12.92 * c
	end

	return 1.055 * (c ^ 0.416666666666666685) - 0.055
end

local function to_linear(c)
	if c > 0.04045 then
		return ((c + 0.055) / 1.055) ^ 2.4
	end

	return c / 12.92
end

local function xyz_to_rgb(tuple)
	return {
		from_linear(dot_product(m[1], tuple)),
		from_linear(dot_product(m[2], tuple)),
		from_linear(dot_product(m[3], tuple)),
	}
end

local function rgb_to_xyz(tuple)
	local rgbl = {
		to_linear(tuple[1]),
		to_linear(tuple[2]),
		to_linear(tuple[3]),
	}

	return {
		dot_product(minv[1], rgbl),
		dot_product(minv[2], rgbl),
		dot_product(minv[3], rgbl),
	}
end

local function y_to_l(Y)
	if Y <= epsilon then
		return Y / ref_y * kappa
	end

	return 116 * ((Y / ref_y) ^ 0.333333333333333315) - 16
end

local function l_to_y(L)
	if L <= 8 then
		return ref_y * L / kappa
	end

	return ref_y * (((L + 16) / 116) ^ 3)
end

local function xyz_to_luv(tuple)
	local X = tuple[1]
	local Y = tuple[2]

	local divider = X + 15 * Y + 3 * tuple[3]

	local var_u = 4 * X
	local var_v = 9 * Y

	if divider ~= 0 then
		var_u = var_u / divider
		var_v = var_v / divider
	else
		var_u = 0
		var_v = 0
	end

	local L = y_to_l(Y)

	if L == 0 then
		return { 0, 0, 0 }
	end

	return {
		L,
		13 * L * (var_u - ref_u),
		13 * L * (var_v - ref_v),
	}
end

local function luv_to_xyz(tuple)
	local L = tuple[1]
	local U = tuple[2]
	local V = tuple[3]

	if L == 0 then
		return { 0, 0, 0 }
	end

	local var_u = U / (13 * L) + ref_u
	local var_v = V / (13 * L) + ref_v

	local Y = l_to_y(L)
	local X = 0 - (9 * Y * var_u) / (((var_u - 4) * var_v) - var_u * var_v)

	return {
		X,
		Y,
		(9 * Y - 15 * var_v * Y - var_v * X) / (3 * var_v),
	}
end

local function luv_to_lch(tuple)
	local L = tuple[1]
	local U = tuple[2]
	local V = tuple[3]
	local C = math.sqrt(U * U + V * V)
	local H

	if C < 0.00000001 then
		H = 0
	else
		H = math.atan2(V, U) * 180.0 / 3.1415926535897932

		if H < 0 then
			H = 360 + H
		end
	end

	return {
		L,
		C,
		H,
	}
end

local function lch_to_luv(tuple)
	local L = tuple[1]
	local C = tuple[2]
	local h_rad = tuple[3] / 360.0 * 2 * math.pi

	return {
		L,
		math.cos(h_rad) * C,
		math.sin(h_rad) * C,
	}
end

local function hsluv_to_lch(tuple)
	local H = tuple[1]
	local S = tuple[2]
	local L = tuple[3]

	if L > 99.9999999 then
		return { 100, 0, H }
	end

	if L < 0.00000001 then
		return { 0, 0, H }
	end

	return {
		L,
		max_safe_chroma_for_lh(L, H) / 100 * S,
		H,
	}
end

local function lch_to_hsluv(tuple)
	local L = tuple[1]
	local C = tuple[2]
	local H = tuple[3]

	local max_chroma = max_safe_chroma_for_lh(L, H)

	if L > 99.9999999 then
		return { H, 0, 100 }
	end

	if L < 0.00000001 then
		return { H, 0, 0 }
	end

	return {
		H,
		C / max_chroma * 100,
		L,
	}
end

local function hpluv_to_lch(tuple)
	local H = tuple[1]
	local S = tuple[2]
	local L = tuple[3]

	if L > 99.9999999 then
		return { 100, 0, H }
	end

	if L < 0.00000001 then
		return { 0, 0, H }
	end

	return {
		L,
		max_safe_chroma_for_l(L) / 100 * S,
		H,
	}
end

local function lch_to_hpluv(tuple)
	local L = tuple[1]
	local C = tuple[2]
	local H = tuple[3]

	if L > 99.9999999 then
		return { H, 0, 100 }
	end

	if L < 0.00000001 then
		return { H, 0, 0 }
	end

	return {
		H,
		C / max_safe_chroma_for_l(L) * 100,
		L,
	}
end

local function rgb_to_hex(tuple)
	local h = { "#" }

	for i = 1, 3 do
		local c = math.floor(tuple[i] * 255 + 0.5)
		local digit2 = math.fmod(c, 16)
		local x = (c - digit2) / 16
		local digit1 = math.floor(x)

		h[#h + 1] = string.sub(hex_chars, digit1 + 1, digit1 + 1)
		h[#h + 1] = string.sub(hex_chars, digit2 + 1, digit2 + 1)
	end

	return table.concat(h)
end

local function hex_to_rgb(hex)
	local ret = {}

	hex = string.lower(hex)

	for i = 0, 2 do
		local char1 = string.sub(hex, i * 2 + 2, i * 2 + 2)
		local char2 = string.sub(hex, i * 2 + 3, i * 2 + 3)
		local digit1 = string.find(hex_chars, char1) - 1
		local digit2 = string.find(hex_chars, char2) - 1

		ret[i + 1] = (digit1 * 16 + digit2) / 255.0
	end

	return ret
end

local function lch_to_rgb(tuple)
	return xyz_to_rgb(luv_to_xyz(lch_to_luv(tuple)))
end

local function rgb_to_lch(tuple)
	return luv_to_lch(xyz_to_luv(rgb_to_xyz(tuple)))
end

local function hsluv_to_rgb(tuple)
	return lch_to_rgb(hsluv_to_lch(tuple))
end

local function rgb_to_hsluv(tuple)
	return lch_to_hsluv(rgb_to_lch(tuple))
end

local function hpluv_to_rgb(tuple)
	return lch_to_rgb(hpluv_to_lch(tuple))
end

local function rgb_to_hpluv(tuple)
	return lch_to_hpluv(rgb_to_lch(tuple))
end

local function hsluv_to_hex(tuple)
	return rgb_to_hex(hsluv_to_rgb(tuple))
end

local function hpluv_to_hex(tuple)
	return rgb_to_hex(hpluv_to_rgb(tuple))
end

local function hex_to_hsluv(s)
	return rgb_to_hsluv(hex_to_rgb(s))
end

local function hex_to_hpluv(s)
	return rgb_to_hpluv(hex_to_rgb(s))
end

return {
	-- constants
	m = m,
	minv = minv,
	ref_y = ref_y,
	ref_u = ref_u,
	ref_v = ref_v,
	kappa = kappa,
	epsilon = epsilon,

	-- functions
	dot_product = dot_product,
	from_linear = from_linear,
	get_bounds = get_bounds,
	hex_to_hpluv = hex_to_hpluv,
	hex_to_hsluv = hex_to_hsluv,
	hex_to_rgb = hex_to_rgb,
	hpluv_to_hex = hpluv_to_hex,
	hpluv_to_lch = hpluv_to_lch,
	hpluv_to_rgb = hpluv_to_rgb,
	hsluv_to_hex = hsluv_to_hex,
	hsluv_to_lch = hsluv_to_lch,
	hsluv_to_rgb = hsluv_to_rgb,
	l_to_y = l_to_y,
	lch_to_hpluv = lch_to_hpluv,
	lch_to_hsluv = lch_to_hsluv,
	lch_to_luv = lch_to_luv,
	lch_to_rgb = lch_to_rgb,
	luv_to_lch = luv_to_lch,
	luv_to_xyz = luv_to_xyz,
	max_safe_chroma_for_l = max_safe_chroma_for_l,
	max_safe_chroma_for_lh = max_safe_chroma_for_lh,
	rgb_to_hex = rgb_to_hex,
	rgb_to_hpluv = rgb_to_hpluv,
	rgb_to_hsluv = rgb_to_hsluv,
	rgb_to_lch = rgb_to_lch,
	rgb_to_xyz = rgb_to_xyz,
	to_linear = to_linear,
	xyz_to_luv = xyz_to_luv,
	xyz_to_rgb = xyz_to_rgb,
	y_to_l = y_to_l,
}
