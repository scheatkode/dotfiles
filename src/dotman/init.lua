-- bare bones way of getting the running script's file name
-- and directory.
local this_file = debug.getinfo(1, 'S').source:sub(2)
local this_dir = this_file:match('(.*)/') or '.'

local repository = string.format('%s/../..', this_dir)

---add the given path as a prefix pattern to `package.path`.
---@param path string
local function add_to_packpath(path)
	package.path =
		string.format('%s;%s/?.lua;%s/?/init.lua', package.path, path, path)
end

-- constructing a `package.path` to enable requiring from the
-- dotfile manager directory or the central repository lib.
add_to_packpath(string.format('%s/lib/lua', repository))
add_to_packpath(string.format('%s/src/dotman', repository))

local io      = require('io')
local compat  = require('compat')
local partial = require('f.function.partial')
local ternary = require('f.function.ternary')
local unpack  = require('compat.table.unpack')

local color  = require('terminal.color')
local cyan   = color.cyan
local green  = color.green
local red    = color.red
local yellow = color.yellow

local HOME = ternary(
	compat.is_windows,
	partial(os.getenv, 'UserProfile'),
	partial(os.getenv, 'HOME')
)

local XDG_CONFIG_HOME = ternary(
	compat.is_windows,
	partial(string.format, '%s/AppData/Local', HOME),
	partial(string.format, '%s/.config', HOME)
)

---displays the given message to the terminal.
---@param message string the message to display
---@param ending string|nil an optional line ending to append
local function display(message, ending)
	return io.write(message .. (ending or '\n'))
end

---wrap an action with log messages
---@param message string?
---@param action function?
---@param ... any
local function act(message, action, ...)
	assert(action, 'missing argument #2 to act()')

	local icon_pending      = yellow('…')
	local icon_success      = green('')
	local icon_failure      = red('')
	local icon_continuation = '↳'

	display(
		string.format('   [%s] - %s', icon_pending, message or 'Processing'),
		''
	)

	local ok, output = pcall(action, ...)
	local main_icon
	local cont_icon

	if not ok then
		main_icon = icon_failure
		cont_icon = red(icon_continuation)
	else
		main_icon = icon_success
		cont_icon = green(icon_continuation)
	end

	display(string.format('\r   [%s]', main_icon))

	if output then
		for line in output:gmatch('(.-)\n') do
			display(string.format('       %s %s', cont_icon, line))
		end
	end

	return output
end

---executes `command` and throws an error if it fails.
---@param command string the command to execute
---@return string - if successful, the output of the `command`
local function execute(command)
	local process, err = io.popen(command .. ' 2>&1')
	if process == nil or err ~= nil then
		error(err)
	end

	local output = process:read('*a')
	local success, _, errcode = process:close()
	if not success or errcode ~= nil then
		error(
			string.format(
				'an error occurred executing "%s": %s',
				command,
				output
			)
		)
	end

	return output
end

---return a random string of size `length` from the given `charset`.
---@param length number? length of the resulting string, defaults to 12
---@param charset string? charset from which to construct the string, defaults to an alphanumeric charset
local function random_string(length, charset)
	math.randomseed(os.clock() ^ 5)

	local result = {}
	local r

	length = length or 12
	charset = charset
		or 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'

	for _ = 1, length do
		r = math.random(1, #charset)
		result[#result + 1] = charset:sub(r, r)
	end

	return table.concat(result)
end

---shell's `ln -s`
local function ln(source, destination)
	-- TODO: Handle the winblows case
	return execute(
		string.format('ln -s "$(realpath "%s")" "%s"', source, destination)
	)
end

---shell's `mv`
local function mv(source, destination)
	-- TODO: Handle the winblows case
	return execute(string.format('mv "%s" "%s" 2>&1', source, destination))
end

local function ensure_backup(s, suffix)
	return mv(s, s .. (suffix or ('.backup.' .. random_string())))
end

local function setup(s, t)
	local cpath = string.format('%s/%s', XDG_CONFIG_HOME, s)
	local rpath = string.format('%s/xdg/%s', repository, t or s)

	if s == 'gnupg' or s == 'ssh' then
		cpath = string.format('%s/%s', HOME, s)
	end

	ensure_backup(cpath)
	ln(rpath, cpath)

	display(
		string.format(
			' (falling back to creating a symbolic link for %s)',
			t or s
		),
		''
	)
end

-- TODO: Migrate this
-- act('Setting up shell profile', function () setup('../.profile', 'profile') end)

-- TODO: Make script for this
-- -- needs copying, not linking
-- -- https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/624
-- -- act('Setting up pulse', function () setup('pulse') end)

---return the program's banner.
---@return string
local function banner()
	return string.format(
		'%s%s\n',
		cyan([[

   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
   ░░░░░░░░░░░█░░░░█▀▄░█▀█░▀█▀░█▄█░█▀█░█▀█░░░░░
   ░░░░▄█▄█░░█▀░░░░█░█░█░█░░█░░█░█░█▀█░█░█░░░░░
   ░░░░▀░▀░░░▀░░▀░░▀▀░░▀▀▀░░▀░░▀░▀░▀░▀░▀░▀░░░░░
   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

          scheatkode]]),
		[['s dotfiles manager]]
	)
end

---return an iterator for walking the directory at `path`.
---@param path string path of the directory to walk
---@param type? 'f'|'d' optional type to filter the results by
---@return fun():string
local function walkdir(path, type)
	local winopt
	local linpipe

	if type == 'f' then
		winopt = '/A:-D'
		linpipe = [[| grep -v "/$"]]
	elseif type == 'd' then
		winopt = '/A:D'
		linpipe = [[| grep "/$"]]
	else
		winopt = ''
		linpipe = ''
	end

	local command

	if compat.is_windows then
		command = string.format([[dir %s %s /b]], path, winopt)
	else
		command = string.format([[ls -pA %s %s]], path, linpipe)
	end

	return io.popen(command):lines()
end

---check whether the file at `path` exists.
---@param path string path of the file to check
---@return boolean|nil
---@return any
---@return any
local function file_exists(path)
	local f = io.open(path, 'r')

	if f ~= nil then
		return f:close()
	end

	return false
end

---run the lua script `name`.
---@param name string name of the script to run
local function run_lua(name)
	assert(name ~= nil, 'missing argument to run_lua')
	return loadfile(name)()
end

---run the python script `name`.
---@param name string name of the script to run
local function run_py(name)
	assert(name ~= nil, 'missing argument to run_py')
	return execute(string.format('/usr/bin/env python3 %s', name))
end

---run the shell script `name`.
---@param name string name of the script to run
local function run_sh(name)
	assert(name ~= nil, 'missing argument to run_sh')
	return execute(string.format('/bin/sh %s', name))
end

local function install(component)
	local prefix = 'xdg'
	local extensions = {
		lua = run_lua,
		py = run_py,
		sh = run_sh,
	}

	component = component:gsub('/$', '')

	for ext, runner in pairs(extensions) do
		local file = string.format('%s/%s/install.%s', prefix, component, ext)

		if file_exists(file) then
			return act(string.format('Installing %s ', component), runner, file)
		end
	end

	if component == 'neovim' then
		return act('Installing neovim ', setup, 'nvim', 'neovim')
	elseif component == 'gnupg' then
		return act('Installing gnupg ', setup, 'gnupg', 'gpg')
	end

	return act(string.format('Installing %s ', component), setup, component)
end

local function install_all()
	for dirent in walkdir('xdg', 'd') do
		install(dirent)
	end
end

local function cmd_usage()
	print(cyan('something'))
end

---@param component string
local function cmd_install(component)
	return ternary(component == nil, install_all, partial(install, component))
end

local function main()
	display(banner())

	local dispatch = {
		['help'] = partial(cmd_usage),
		['install'] = partial(cmd_install),
	}

	local command = table.remove(arg, 1)
	local handler = dispatch[command]

	if handler == nil then
		return 1
	end

	return handler(unpack(arg))
end

return main()
