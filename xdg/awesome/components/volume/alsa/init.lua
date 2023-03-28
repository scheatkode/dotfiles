local spawn = require("awful.spawn")
local tablex = require("tablex")

local Alsa = {}
Alsa.__index = Alsa

function Alsa:new(arguments)
	local defaults = {
		command = "amixer",
		channel = "Master",
		device = "Master",
		step = 5,
	}

	local object = tablex.deep_extend("force", {}, defaults, arguments)

	setmetatable(object, self)
	self.__index = self

	return object
end

function Alsa:get(callback)
	local command = string.format("%s get %s", self.command, self.channel)

	return spawn.easy_async(command, function(mixer)
		local l, s = string.match(mixer, "([%d]+)%%.*%[([%l]*)")
		callback({ level = tonumber(l), status = s })
	end)
end

function Alsa:increment(s, callback)
	local command = string.format(
		"amixer -D %s sset Master %s %%+",
		self.device,
		s or self.step
	)

	return spawn.easy_async(command, callback)
end

function Alsa:decrement(s, callback)
	local command = string.format(
		"amixer -D %s sset Master %s %%-",
		self.device,
		s or self.step
	)

	return spawn.easy_async(command, callback)
end

function Alsa:toggle(callback)
	local command =
		string.format("amixer -D %s sset Master toggle", self.device)

	return spawn.easy_async(command, callback)
end

return Alsa
