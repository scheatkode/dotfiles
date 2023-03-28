local awful = require("awful")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local mouse = require("awful.mouse")

local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local pipe = require("f.function.pipe")
local stringx = require("stringx")

local function extract_sinks_and_sources(pacmd_output)
	local sinks = {}
	local sources = {}
	local device
	local properties
	local ports

	local in_sink = false
	local in_source = false
	local in_device = false
	local in_properties = false
	local in_ports = false

	for line in pacmd_output:gmatch("[^\r\n]+") do
		if string.match(line, "source%(s%) available.") then
			in_sink = false
			in_source = true
		end

		if line:match("sink%(s%) available.") then
			in_sink = true
			in_source = false
		end

		if line:match(line, "index:") then
			in_device = true
			in_properties = false

			device = {
				id = line:match(": (%d+)"),
				is_default = line:match("*") ~= nil,
			}

			if in_sink then
				table.insert(sinks, device)
			elseif in_source then
				table.insert(sources, device)
			end
		end

		if line:match("^\tproperties:") then
			in_device = false
			in_properties = true
			properties = {}

			device["properties"] = properties
		end

		if line:match("ports:") then
			in_device = false
			in_properties = false
			in_ports = true
			ports = {}

			device["ports"] = ports
		end

		if line:match("active port:") then
			in_device = false
			in_properties = false
			in_ports = false

			device["active_port"] =
				line:match(": (.+)"):gsub("<", ""):gsub(">", "")
		end

		if in_device then
			local t = stringx.split(line, ": ")
			local key = t[1]:gsub("\t+", ""):lower()
			local value = t[2]:gsub("^<", ""):gsub(">$", "")

			device[key] = value
		end

		if in_properties then
			local t = stringx.split(line, "=")
			local key = t[1]
				:gsub("\t+", "")
				:gsub("%.", "_")
				:gsub("-", "_")
				:gsub(":", "")
				:gsub("%s+$", "")

			local value

			if t[2] == nil then
				value = t[2]
			else
				value =
					t[2]:gsub('"', ""):gsub("^%s+", ""):gsub(" Analog Stereo", "")
			end

			properties[key] = value
		end

		if in_ports then
			local t = stringx.split(line, ": ")
			local key = t[1]

			if key ~= nil then
				key = key:gsub("\t+", "")
			end

			ports[key] = t[2]
		end
	end

	return sinks, sources
end

local function build_main_line(device)
	if
		device.active_port ~= nil and device.ports[device.active_port] ~= nil
	then
		return string.format(
			"%s · %s",
			device.properties.device_description,
			device.ports[device.active_port]
		)
	end

	return device.properties.device_description
end

local function build_header_row(text)
	return wibox.widget({
		{
			align = "center",
			markup = string.format("<b>%s</b>", text),
			widget = wibox.widget.textbox,
		},

		bg = beautiful.bg_normal,
		widget = wibox.container.background,
	})
end

local cmd = {
	get = function(device)
		return string.format("amixer -D %s sget Master", device)
	end,

	toggle = function(device)
		return string.format("amixer -D %s sset Master toggle", device)
	end,

	increment = function(device, step)
		return string.format("amixer -D %s sset Master %s %%+", device, step)
	end,

	decrement = function(device, step)
		return string.format("amixer -D %s sset Master %s %%-", device, step)
	end,

	list = function()
		return [[sh -c "pacmd list-sinks; pacmd list-sources"]]
	end,
}

local volume = {}
local rows = { layout = wibox.layout.fixed.vertical }
local popup = awful.popup({
	bg = beautiful.bg_normal,
	border_color = beautiful.bg_focus,
	border_width = 1,
	maximum_width = 400,
	offset = { y = 5 },
	ontop = true,
	shape = gears.shape.rounded_rect,
	visible = false,
	widget = {},
})

local function volume_widget(widgets_args)
	local ICON_DIR = os.getenv("HOME")
		.. "/.config/awesome/components/volume/icons/"

	local args = widgets_args or {}
	local icon_dir = args.icon_dir or ICON_DIR

	return wibox.widget({
		{
			id = "icon",
			resize = false,
			widget = wibox.widget.imagebox,
		},

		layout = wibox.container.place,
		valign = "center",

		set_volume_level = function(self, new_value)
			local volume_icon_name

			if self.is_muted then
				volume_icon_name = "audio-volume-muted-symbolic"
			else
				local new_value_num = tonumber(new_value)

				if new_value_num >= 0 and new_value_num < 33 then
					volume_icon_name = "audio-volume-low-symbolic"
				elseif new_value_num < 66 then
					volume_icon_name = "audio-volume-medium-symbolic"
				else
					volume_icon_name = "audio-volume-high-symbolic"
				end
			end

			self
				:get_children_by_id("icon")[1]
				:set_image(string.format("%s%s.svg", icon_dir, volume_icon_name))
		end,

		mute = function(self)
			self.is_muted = true

			self
				:get_children_by_id("icon")[1]
				:set_image(icon_dir .. "audio-volume-muted-symbolic.svg")
		end,

		unmute = function(self)
			self.is_muted = false
		end,
	})
end

local function build_rows(devices, on_checkbox_click, device_type)
	local device_rows = { layout = wibox.layout.fixed.vertical }

	for _, device in pairs(devices) do
		local checkbox = wibox.widget({
			checked = device.is_default,
			color = beautiful.bg_normal,
			paddings = 2,
			shape = gears.shape.circle,
			forced_width = 20,
			forced_height = 20,
			check_color = beautiful.fg_urgent,
			widget = wibox.widget.checkbox,
		})

		checkbox:connect_signal("button::press", function()
			spawn.easy_async(
				string.format(
					[[sh -c 'pacmd set-default-%s "%s"']],
					device_type,
					device.name
				),
				on_checkbox_click
			)
		end)

		local row = wibox.widget({
			{
				{
					{
						checkbox,
						valign = "center",
						layout = wibox.container.place,
					},
					{
						{
							text = build_main_line(device),
							align = "left",
							widget = wibox.widget.textbox,
						},
						left = 10,
						layout = wibox.container.margin,
					},
					spacing = 8,
					layout = wibox.layout.align.horizontal,
				},
				margins = 4,
				layout = wibox.container.margin,
			},
			bg = beautiful.bg_normal,
			widget = wibox.container.background,
		})

		row:connect_signal("mouse::enter", function(c)
			c:set_bg(beautiful.bg_focus)
		end)
		row:connect_signal("mouse::leave", function(c)
			c:set_bg(beautiful.bg_normal)
		end)

		local old_cursor, old_wibox

		row:connect_signal("mouse::enter", function()
			local wb = mouse.current_wibox
			old_cursor, old_wibox = wb.cursor, wb
			wb.cursor = "hand1"
		end)
		row:connect_signal("mouse::leave", function()
			if old_wibox then
				old_wibox.cursor = old_cursor
				old_wibox = nil
			end
		end)

		row:connect_signal("button::press", function()
			spawn.easy_async(
				string.format(
					[[sh -c 'pacmd set-default-%s "%s"']],
					device_type,
					device.name
				),
				on_checkbox_click
			)
		end)

		table.insert(device_rows, row)
	end

	return device_rows
end

local function rebuild_popup()
	spawn.easy_async(cmd:list(), function(stdout)
		local sinks, sources = extract_sinks_and_sources(stdout)

		for i = 0, #rows do
			rows[i] = nil
		end

		table.insert(rows, build_header_row("SINKS"))
		table.insert(rows, build_rows(sinks, rebuild_popup, "sink"))
		table.insert(rows, build_header_row("SOURCES"))
		table.insert(rows, build_rows(sources, rebuild_popup, "source"))

		popup:setup(rows)
	end)
end

local function worker(user_args)
	-- local defaults = {
	-- 	device       = 'pulse',
	-- 	mixer_cmd    = 'pavucontrol',
	-- 	refresh_rate = 1,
	-- 	step         = 5,
	-- }

	local args = user_args or {}

	local device = args.device or "pulse"
	local mixer_cmd = args.mixer_cmd or "pavucontrol"
	local refresh_rate = args.refresh_rate or 1
	local step = args.step or 5

	volume.widget = volume_widget(args)

	local function update_graphic(widget, stdout)
		local mute = string.match(stdout, "%[(o%D%D?)%]") -- \[(o\D\D?)\] - [on] or [off]

		if mute == "off" then
			widget:mute()
		elseif mute == "on" then
			widget:unmute()
		end

		pipe("(%d?%d?%d)%%", function(x)
			return string.match(stdout, x)
		end, function(x)
			return string.format("% 3d", x)
		end, function(x)
			return widget:set_volume_level(x)
		end)
	end

	function volume:inc(s)
		spawn.easy_async(cmd.increment(device, s or step), function(stdout)
			update_graphic(volume.widget, stdout)
		end)
	end

	function volume:dec(s)
		spawn.easy_async(cmd.decrement(device, s or step), function(stdout)
			update_graphic(volume.widget, stdout)
		end)
	end

	function volume:toggle()
		spawn.easy_async(cmd.toggle(device), function(stdout)
			update_graphic(volume.widget, stdout)
		end)
	end

	function volume:mixer()
		if mixer_cmd then
			spawn.easy_async(mixer_cmd)
		end
	end

	volume.widget:buttons(awful.util.table.join(
		awful.button({}, 3, function()
			if popup.visible then
				popup.visible = not popup.visible
				return
			end

			rebuild_popup()
			popup:move_next_to(mouse.current_widget_geometry)
		end),

		awful.button({}, 4, function()
			volume:inc()
		end),
		awful.button({}, 5, function()
			volume:dec()
		end),
		awful.button({}, 2, function()
			volume:mixer()
		end),
		awful.button({}, 1, function()
			volume:toggle()
		end)
	))

	watch(cmd.get(device), refresh_rate, update_graphic, volume.widget)

	return volume.widget
end

return setmetatable(volume, {
	__call = function(_, ...)
		return worker(...)
	end,
})
