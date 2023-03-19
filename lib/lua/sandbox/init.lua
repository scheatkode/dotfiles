--- @brief [[
---
--- A  pure, cross-Lua  solution for  running untrusted
--- Lua  code.  The  default behavior  is  to  restrict
--- access  to   *dangerous*  Lua  functions   such  as
--- `os.execute` as  well as preventing  infinite loops
--- via  the `debug`  module. As  such, and  especially
--- with the  use of `debug.sethook`,  coverage reports
--- may  become  skewed.  The  use  of  `debug.sethook`
--- requires `jit`  to be  disabled in case  of LuaJit;
--- the performance impact is thus, non negligible.
---
--- @brief ]]

local compat = require("compat")

local cload = compat.load
local ctpack = compat.table_pack
local ctunpack = compat.table_unpack

local default_preempt_count = 500000
local original_string_rep = string.rep

local run_with_jit_disabled_if_needed

if type(jit) ~= "nil" then
	run_with_jit_disabled_if_needed = function(f, ...)
		jit.off()
		local t = ctpack(pcall(f, ...))
		jit.on()

		return t
	end
else
	run_with_jit_disabled_if_needed = function(f, ...)
		return ctunpack(pcall(f, ...))
	end
end

local sethook

if type(debug.sethook) ~= "function" then
	sethook = function() end
else
	sethook = debug.sethook
end

local sandbox = {}

--- The  base  environment  is merged  with  the  given
--- `environment`  option (or  an  empty  table, if  no
--- `environment` is provided).
local base_environment = {}

--- list of unsafe packages/functions :
---
--- - `string.rep`:
---      can be used to allocate millions of bytes in 1
---      operation.
---
--- - `(set|get)metatable`:
---      can be used to  modify the metatable of global
---      objects (strings, integers).
---
--- - `collectgarbage`:
---      can affect performance of other systems.
---
--- - `dofile`:
---      can access the filesystem.
---
--- - `_G`:
---      has access to everything;  it can be mocked to
---      other things though.
---
--- - `load(file|string)`:
---      all unsafe  because they  can grant  access to
---      the global environment.
---
--- - `raw(get|set|equal)`:
---      potentially unsafe.
---
--- - `(module|require|module)`:
---      can modify the host settings.
---
--- - `string.dump`:
---      can    display   confidential    server   info
---      (implementation of functions).
---
--- - `math.randomseed`:
---      can affect the host system.
---
--- - `io.*, os.*`:
---      most  stuff  here  is unsafe,  see  below  for
---      exceptions.
---
--- safe packages/functions are listed below :
---
local _ = ([[

   _VERSION assert error    ipairs   next pairs
   pcall    select tonumber tostring type unpack xpcall

   coroutine.create coroutine.resume coroutine.running coroutine.status
   coroutine.wrap   coroutine.yield

   math.abs   math.acos math.asin  math.atan math.atan2 math.ceil
   math.cos   math.cosh math.deg   math.exp  math.fmod  math.floor
   math.frexp math.huge math.ldexp math.log  math.log10 math.max
   math.min   math.modf math.pi    math.pow  math.rad   math.random
   math.sin   math.sinh math.sqrt  math.tan  math.tanh

   os.clock os.difftime os.time

   string.byte string.char  string.find  string.format string.gmatch
   string.gsub string.len   string.lower string.match  string.reverse
   string.sub  string.upper

   table.insert table.maxn table.remove table.sort

]]):gsub("%S+", function(id)
	local module, method = id:match("([^%.]+)%.([^%.]+)")

	if module then
		base_environment[module] = base_environment[module] or {}
		base_environment[module][method] = _G[module][method]
	else
		base_environment[id] = _G[id]
	end
end)

local function protect_module(module, module_name)
	return setmetatable({}, {
		__index = module,
		__newindex = function(_, attribute_name, _)
			error(
				"Can not modify "
					.. module_name
					.. "."
					.. attribute_name
					.. ". This is a sandboxed and read-only environment"
			)
		end,
	})
end

_ = ([[coroutine math os string table]]):gsub("%S+", function(module_name)
	base_environment[module_name] =
		protect_module(base_environment[module_name], module_name)
end)

--- auxiliary functions/variables

local function cleanup()
	sethook()
	string.rep = original_string_rep
end

--- Produce a sandboxed  Lua function without executing
--- it. The resulting sandboxed function works as if it
--- was  a  regular  function  without  access  to  any
--- insecure features.
---
--- <pre>
---   local f = sandbox(function() return 'The cat kept covering me up')
---   local r = f() -- r now contains 'The cat kept covering me up'
--- </pre>
---
--- When a sandboxed function tries to access an unsafe
--- module, an error is produced.
---
--- <pre>
---   local f = sandbox([[
---      os.execute('rm -rf /')
---   ]])
---
---   f() -- error: os.execute not found
--- </pre>
---
--- Sandboxed  code will  also produce  an error  if it
--- contains infinite loops.
---
--- <pre>
---   local f = sandbox([[
---      while true do end
---   ]])
---
---   f() -- error: error: quota exceeded
--- </pre>
---
---
--- @param code string
--- @param options table
--- @return function
---
function sandbox.protect(code, options)
	assert(type(code) == "string", "expected a string")

	options = options or {}

	local quota = options.quota

	if type(quota) ~= "number" and quota ~= false then
		quota = default_preempt_count
	end

	local custom_environment = options.environment or {}
	local environment = {}

	for key, value_in_base in pairs(base_environment) do
		local given_value = custom_environment[key]

		if given_value ~= nil then
			environment[key] = given_value
		else
			environment[key] = value_in_base
		end
	end

	setmetatable(environment, { __index = options.environment })
	environment._G = environment

	local f = assert(cload(code, nil, "t", environment))

	return function(...)
		if quota then
			local preempt = function()
				cleanup()
				error("Quota exceeded: " .. tostring(quota))
			end

			sethook(preempt, "", quota)
		end

		string.rep = nil

		local t = run_with_jit_disabled_if_needed(f, ...)

		cleanup()

		if not t[1] then
			error(t[2])
		end

		return ctunpack(t, 2, t.n)
	end
end

--- Execute `code`  with the given `options`  and extra
--- parameters in a sandboxed environment.
---
--- NOTE:  If  `code`  throws  an error,  it  is  *not*
---       captured  by `sandbox.run`.  Use pcall  where
---       needed, like so:
---
--- <pre>
---   local ok, r = pcall(sandbox.run, [[error('error')]])
--- </pre>
---
--- @param code string
--- @param options table
--- @vararg ... any
--- @return any
---
--- @see sandbox.protect
---
function sandbox.run(code, options, ...)
	return sandbox.protect(code, options)(...)
end

setmetatable(sandbox, {
	__call = function(_, code, o)
		return sandbox.protect(code, o)
	end,
})

return sandbox
