local constant = require('f.function.constant')

--- The raw colorscheme palette
---
--- Using  a function's  return  value  as a  temporary
--- variable to  avoid the  table lingering  around the
--- memory after  its use,  when the  garbage collector
--- sweeps for unreferenced objects.
---
--- @type fun(): table
local palette = constant({
	dark0_hard = '#0d0e0f',
	dark0_dim  = '#202020',
	dark0      = '#282828',
	dark0_soft = '#32302f',
	dark1      = '#3c3836',
	dark2      = '#504945',
	dark3      = '#665c54',
	dark4      = '#7c6f64',

	gray = '#928374',

	light0_hard = '#f9f5d7',
	light0      = '#fbf1c7',
	light0_soft = '#f2e5bc',
	light1      = '#ebdbb2',
	light2      = '#d5c4a1',
	light3      = '#bdae93',
	light4      = '#a89984',

	bright_red    = '#fb4934',
	bright_green  = '#b8bb26',
	bright_yellow = '#fabd2f',
	bright_blue   = '#7fa2ac',
	bright_purple = '#d3869b',
	bright_aqua   = '#8ec07c',
	bright_orange = '#fe8019',

	neutral_red    = '#cc241d',
	neutral_green  = '#98971a',
	neutral_yellow = '#d79921',
	neutral_blue   = '#458588',
	neutral_purple = '#b16286',
	neutral_aqua   = '#689d6a',
	neutral_orange = '#d65d0e',

	faded_red    = '#9d0006',
	faded_green  = '#79740e',
	faded_yellow = '#b57614',
	faded_blue   = '#076678',
	faded_purple = '#8f3f71',
	faded_aqua   = '#427b58',
	faded_orange = '#af3a03',

	pale_yellow = '#d8a657',
	pale_orange = '#e78a4e',
	pale_red    = '#ea6962',
	pale_green  = '#a9b665',
	pale_blue   = '#7daea3',
	pale_aqua   = '#89b482',

	bg_red    = '#322b2b',
	bg_yellow = '#312f2a',
	bg_blue   = '#2c2f2e',
	bg_aqua   = '#2d2f2d',
})

--- The default themes
---
--- Using  a function's  return  value  as a  temporary
--- variable to  avoid the  table lingering  around the
--- memory after  its use,  when the  garbage collector
--- sweeps for unreferenced objects.
---
--- @return function Default themes table
local function themes(theme)
	return ({
		default = function(colors)
			return {
				bg        = colors.dark0,
				bg_dim    = colors.dark0_dim,
				bg_dark   = colors.dark0_hard,
				bg_light0 = colors.dark1,
				bg_light1 = colors.dark2,
				bg_light2 = colors.dark3,
				bg_light3 = colors.dark4,

				bg_menu     = colors.dark0_dim,
				bg_menu_sel = colors.dark0_soft,
				bg_search   = colors.dark0_soft,
				bg_status   = colors.dark0_dim,
				bg_visual   = colors.dark0_soft,

				fg = colors.light0_soft,

				fg_border  = colors.light4,
				fg_comment = colors.dark3,
				fg_dark    = colors.light3,
				fg_reverse = colors.faded_blue,

				constant   = colors.neutral_orange,
				delimiter  = colors.neutral_blue,
				fn         = colors.pale_orange,
				identifier = colors.bright_blue,
				keyword    = colors.bright_red,
				number     = colors.pale_orange,
				operator   = colors.pale_red,
				preproc    = colors.pale_orange,
				regex      = colors.pale_yellow,
				special    = colors.bright_blue,
				special2   = colors.pale_red,
				special3   = colors.pale_red,
				statement  = colors.bright_purple,
				string     = colors.neutral_green,
				type       = colors.pale_aqua,

				diag = {
					error   = colors.neutral_red,
					hint    = colors.neutral_aqua,
					info    = colors.neutral_blue,
					warning = colors.neutral_yellow,
				},

				diff = {
					add    = '#26332c',
					change = '#273842',
					delete = '#572e33',
					text   = '#314753',
				},

				git = {
					added   = '#689d6a',
					changed = '#eebd35',
					removed = '#fb4934',
				},

				bgs = {
					red    = colors.bg_red,
					blue   = colors.bg_blue,
					aqua   = colors.bg_aqua,
					yellow = colors.bg_yellow,
				}
			}
		end
	})[theme]
end

local function lualine()
	local colors = palette()
	local theme  = {}

	theme.normal = {
		a = { bg = colors.bright_blue, fg = colors.dark0_hard },
		b = { bg = colors.dark0, fg = colors.bright_blue },
		c = { bg = colors.dark0, fg = colors.light2 },
	}

	theme.insert = {
		a = { bg = colors.pale_green, fg = colors.dark0_hard },
		b = { bg = colors.dark0_dim, fg = colors.pale_green },
	}

	theme.command = {
		a = { bg = colors.neutral_purple, fg = colors.dark0_hard },
		b = { bg = colors.dark0_dim, fg = colors.neutral_purple },
	}

	theme.visual = {
		a = { bg = colors.pale_yellow, fg = colors.dark0_hard },
		b = { bg = colors.dark0_dim, fg = colors.pale_yellow },
	}

	theme.replace = {
		a = { bg = colors.pale_red, fg = colors.dark0_hard },
		b = { bg = colors.dark0_dim, fg = colors.pale_red },
	}

	theme.inactive = {
		a = { bg = colors.pale_blue, fg = colors.dark0_hard },
		b = { bg = colors.dark0_dim, fg = colors.pale_blue, gui = 'bold' },
		c = { bg = colors.dark0_dim, fg = colors.light4 },
	}

	return theme
end

return {
	palette = palette,
	themes  = themes,
	lualine = lualine,
}
