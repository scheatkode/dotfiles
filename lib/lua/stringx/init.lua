---@diagnostic disable: assign-type-mismatch

local lazy = require("load.on_member_call")

return {
	---Returns `true` if the string ends with the specified suffix, otherwise
	---`false`.
	---@type fun(str: string, suffix: string): boolean
	endswith = lazy("stringx.endswith"),

	---Returns `true` if the string starts with the specified prefix, otherwise
	---`false`.
	---@type fun(str: string, prefix: string): boolean
	startswith = lazy("stringx.startswith"),
}
