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
	dark0_hard = '#1d2021',
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
	bright_blue   = '#83a598',
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
				bg0 = colors.dark0,
				bg1 = colors.dark1,
				bg2 = colors.dark2,
				bg3 = colors.dark3,
				bg4 = colors.dark4,

				fg0 = colors.light0,
				fg1 = colors.light1,
				fg2 = colors.light2,
				fg3 = colors.light3,
				fg4 = colors.light4,

				red    = colors.bright_red,
				green  = colors.neutral_green,
				yellow = colors.bright_yellow,
				blue   = colors.bright_blue,
				purple = colors.bright_purple,
				aqua   = colors.bright_aqua,
				orange = colors.bright_orange,

				neutral_red    = colors.neutral_red,
				neutral_green  = colors.faded_green,
				neutral_yellow = colors.neutral_yellow,
				neutral_blue   = colors.neutral_blue,
				neutral_purple = colors.neutral_purple,
				neutral_aqua   = colors.neutral_aqua,
				neutral_orange = colors.neutral_orange,

				bg        = colors.dark0,
				bg_dim    = colors.dark0_dim,
				bg_dark   = colors.dark0_hard,
				bg_soft   = colors.dark0_soft,
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
			}
		end,
	})[theme]
end

return {
	palette = palette,
	themes  = themes,
}
