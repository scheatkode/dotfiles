-- bare bones way of getting the running script's file name
-- and directory.
local this_filename  = debug.getinfo(1, 'S').source:sub(2)
local this_directory = this_filename:match('(.*)/') or '.'

local repository_path = string.format('%s/../..', this_directory)

-- constructing a `package.path` to enable requiring from the
-- dotfile manager directory or the central repository lib.
package.path = string.format(
	'%s;%s/?.lua;%s/?/init.lua',
	package.path,
	string.format('%s/lib/lua', repository_path),
	string.format('%s/src/dot', repository_path)
)

local color  = require('terminal.color')
local cyan   = color.cyan
local green  = color.green
local red    = color.red
local yellow = color.yellow

local function display(s, e) io.stdout:write(s .. (e or '\n')) end

display(cyan([[


   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
   ░░░░░░░░░░░█░░░░█▀▄░█▀█░▀█▀░█▄█░█▀█░█▀█░░░░░
   ░░░░▄█▄█░░█▀░░░░█░█░█░█░░█░░█░█░█▀█░█░█░░░░░
   ░░░░▀░▀░░░▀░░▀░░▀▀░░▀▀▀░░▀░░▀░▀░▀░▀░▀░▀░░░░░
   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

          scheatkode]]), '')
display([['s dotfiles manager]], '\n\n\n')

local function act(message, action, ...)
	assert(action, 'missing argument #2 to act()')

	local icon_pending      = yellow('\u{2026}') -- …
	local icon_success      = green('\u{f00c}')  -- 
	local icon_failure      = red('\u{f00d}')    -- 
	local icon_continuation = red('\u{21b3}')    -- ↳

	display(
		string.format(
			"   [%s] - %s",
			icon_pending,
			message or 'Processing'
		),
		''
	)

	local ok, ret = pcall(action, ...)

	if not ok then
		display(string.format("\r   [%s]", icon_failure))
		display(string.format(
			"       %s %s",
			icon_continuation,
			ret:match('[^:]*:[^:]*: (.*)')
		))
		return
	end

	display(string.format("\r   [%s]", icon_success))

	return ret
end

---shell's `ln -s`
local function ln(source, destination)
	local d = io.popen(string.format(
		'ln --symbolic `realpath "%s"` "%s"', source, destination
	))

	local m = d:read('*a')

	if m ~= '' then
		error(string.format('an error occurred when trying to link %s to %s: %s', destination, source, m))
	end

	d:close()
end

---shell's `mv`
local function mv(source, destination)
	local d = io.popen(string.format('mv "%s" "%s" 2>&1', source, destination))
	local m = d:read('*a')

	if m ~= '' then
		error(string.format(
			'an error occurred when trying to move %s to %s',
			destination,
			source
		))
	end

	d:close()
end

local HOME = os.getenv('HOME')

local function ensure_backup(s) return mv(s, s .. '.backup') end

local function setup(s, t)
	local cpath = string.format('%s/.config/%s', HOME, s)
	local rpath = string.format('%s/xdg/%s', repository_path, t or s)

	ensure_backup(cpath)
	ln(rpath)
end

act('Setting up shell profile', function () setup('../.profile', 'profile') end)

act('Setting up alacritty',  function () setup('alacritty')      end)
act('Setting up alsa',       function () setup('alsa')           end)
act('Setting up awesome',    function () setup('awesome')        end)
act('Setting up btop',       function () setup('btop')           end)
act('Setting up feh',        function () setup('feh')            end)
act('Setting up fontconfig', function () setup('fontconfig')     end)
act('Setting up git',        function () setup('git')            end)
act('Setting up gmailctl',   function () setup('gmailctl')       end)
act('Setting up gnupg',      function () setup('gnupg', 'gpg')   end)
act('Setting up lazygit',    function () setup('lazygit')        end)
act('Setting up mpd',        function () setup('mpd')            end)
act('Setting up ncmpcpp',    function () setup('ncmpcpp')        end)
act('Setting up neovim',     function () setup('nvim', 'neovim') end)
act('Setting up picom',      function () setup('picom')          end)
act('Setting up pueue',      function () setup('pueue')          end)
act('Setting up tmux',       function () setup('tmux')           end)
act('Setting up x11',        function () setup('x11')            end)
act('Setting up zsh',        function () setup('zsh')            end)

-- needs copying, not linking
-- https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/624
-- act('Setting up pulse', function () setup('pulse') end)

display('')
