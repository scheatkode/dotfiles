local awful = require("awful")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local mouse = require("awful.mouse")

local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local pipe = require("f.function.pipe")
local stringx = require("stringx")
local tablex = require("tablex")

local Volume = {}
Volume.__index = {}

local function get_adapter(adapter)
	if adapter == "alsa" then
		return require("components.volume.alsa")
	end

	return require("components.volume.pulse")
end

function Volume:new(arguments)
	local defaults = {
		adapter = "alsa",

		command = "amixer",
		channel = "Master",
		refresh = 5,
		step = 5,

		icon_directory = string.format(
			"%s%s",
			gears.filesystem.get_configuration_dir(),
			"components/volume/icons/"
		),
	}

	local settings = tablex.deep_extend("force", defaults, arguments)

	local object = {
		adapter = get_adapter(settings.adapter),
		settings = settings,
		rows = { layout = wibox.layout.fixed.vertical },

		popup = awful.popup({
			bg = beautiful.bg_normal,
			border_color = beautiful.bg_focus,
			border_width = 1,
			maximum_width = 400,
			offset = { y = 5 },
			ontop = true,
			shape = gears.shape.rounded_rect,
			visible = false,
			widget = {},
		}),

		widget = wibox.widget({
			{
				id = "icon",
				resize = false,
				widget = wibox.widget.imagebox,
			},

			layout = wibox.container.place,
			valign = "center",
		}),
	}

	setmetatable(object, self)
	self.__index = self

	return object
end

function Volume:set_level(level)
	local icon
	local number = tonumber(level)

	if self.is_muted or number == 0 then
		icon = "muted"
	else
		if number < 33 then
			icon = "low"
		elseif number < 66 then
			icon = "medium"
		else
			icon = "high"
		end
	end

	self
		:get_children_by_id("icon")[1]
		:set_image(
			string.format("%s%s.svg", self.settings.icon_directory, icon)
		)
end

function Volume:mute()
	self.is_muted = true

	self
		:get_children_by_id("icon")[1]
		:set_image(string.format("%smuted.svg", self.icon_directory))
end

function Volume:unmute()
	self.is_muted = false
end

function Volume:render()
	if self.timer ~= nil then
		self.timer:stop()
	end
end

function Volume:increase(s)
	self.adapter:increase(s)
end

function Volume:update_graphic(stdout)
	local muted = string.match(stdout, "%[(o%D%D?)%]") -- \[(o\D\D?)\] - [on] or [off]

	if muted == "off" then
		self:mute()
	elseif muted == "on" then
		self:unmute()
	end

	pipe("(%d?%d?%d)%%", function(x)
		return string.match(stdout, x)
	end, function(x)
		return string.format("% 3d", x)
	end, function(x)
		return self:set_volume_level(x)
	end)
end

return Volume

-- local function factory (arguments)
-- 	local defaults = {
-- 		command = 'amixer',
-- 		channel = 'Master',
-- 		refresh = 1,
-- 	}

-- 	local settings = tablex.deep_extend('force', defaults, arguments)

-- 	local volume  = { widget = arguments.widget }
-- 	local command = string.format(
-- 		'%s get %s',
-- 		settings.command,
-- 		settings.channel
-- 	)

-- 	volume.last = {}

-- 	function volume.update ()
-- 		return spawn.easy_async(command, function (mixer)
-- 			local l, s = string.match(mixer, '([%d]+)%%.*%[([%l]*)')

-- 			l = tonumber(l)

-- 			if volume.last.level ~= l or volume.last.status ~= s then
-- 				-- volume_now = { level = l, status = s }
-- 				-- widget = volume.widget
-- 				-- volume.last = volume_now
-- 				volume.last = { level = l, status = s }
-- 			end
-- 		end)
-- 	end

-- 	return volume.widget
-- end

-- return factory
