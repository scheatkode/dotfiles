local assertx     = require('assertx')
local f           = require('f')
local constant    = require('f.function.constant')
local deep_extend = require('tablex.deep_extend')
local extend      = require('tablex.extend')
local is_empty    = require('tablex.is_empty')

local m = {}

---convert a hex color to rgb.
---
---@param color string hex string to convert
---@return number r
---@return number g
---@return number b
local function hex_to_rgb(color)
	local hex = color:gsub('#', '')

	return
		tonumber(hex:sub(1, 2), 16),
		tonumber(hex:sub(3, 4), 16),
		tonumber(hex:sub(5), 16)
end

---alter a color component by a given percentage.
---
---@param component number component to alter
---@param percent number percentage by which to alter
---@return number result altered color component
local function alterc(component, percent)
	return math.floor(component * (100 + percent) / 100)
end

---alter a given hex color.
---
---to darken a color:
---```lua
---   alter('#123123', -40)
---```
---
---to lighten a color:
---```lua
---   alter('#123123', 40)
---```
---
---NOTE: does not work for zero values.
---
---@param color string
---@param percent number
---@return string
function m.alter(color, percent)
	local r, g, b = hex_to_rgb(color)

	if not r or not g or not b then
		return 'NONE'
	end

	r, g, b = alterc(r, percent), alterc(g, percent), alterc(b, percent)
	r, g, b = math.min(r, 255), math.min(g, 255), math.min(b, 255)

	return string.format('#%02x%02x%02x', r, g, b)
end

---set autocommands to dim the active window when neovim loses
---focus.
---
---@param config table
local function dim_on_focus_lost(config)
	if not config.dim_on_focus_lost then return end

	local augroup = vim.api.nvim_create_augroup('DimOnInactive', { clear = true })

	vim.api.nvim_create_autocmd('FocusLost', {
		group    = augroup,
		callback = function()
			vim.opt.winhighlight = 'Normal:NormalNC,MsgArea:NormalNC'
		end,
	})

	vim.api.nvim_create_autocmd('FocusGained', {
		group    = augroup,
		callback = function()
			vim.opt.winhighlight = ''
		end,
	})
end

---the default configuration table.
---
---using a function's return value as a  temporary  variable  to
---avoid the table lingering around the memory  after  its  use,
---when the garbage collector sweeps for unreferenced objects.
---
---@return table default configuration table
local defaults = constant({
	undercurl             = true,
	comment_style         = { italic = true },
	function_style        = {},
	keyword_style         = { italic = true },
	statement_style       = { italic = true },
	type_style            = {},
	variablebuiltin_style = { italic = true },
	special_return        = false,
	special_exception     = true,
	transparent           = false,
	darken_sidebar        = true,
	dim_inactive          = true,
	dim_on_focus_lost     = true,
	overrides             = {},
	theme                 = 'default',
})

---generate color table.
---
---@param cs table options containing colors and theme fields
---@param config table? options containing colors and theme fields (optional)
---@return table palette colors and theme colors merged with `config.overrides`
local function generate_colors(cs, config)
	local conf   = deep_extend('force', defaults(), config)
	local colors = deep_extend('force', cs.palette(), conf.overrides)
	local theme  = deep_extend('force', cs.themes(conf.theme)(colors), conf.overrides)

	return deep_extend('force', theme, colors)
end

local function apply_highlight_groups(hlgroups)
	f
		 .iterate(hlgroups)
		 :foreach(function( group, colors)
		    if not is_empty(colors) then
		       vim.api.nvim_set_hl(0, group, colors)
		    end
		 end)
end

---generate highlights.
---
---@param colors table color (theme) table created by `generate_colors`
---@param config table config options (optional)
local function generate_highlights(colors, config)
	local hlgroups = {
		Comment      = extend({ fg = colors.fg_comment }, config.comment_style),
		ColorColumn  = { bg = colors.bg_light0 },
		Conceal      = { fg = colors.bg_light3, bg = 'NONE', bold = true },
		Cursor       = { fg = colors.bg, bg = colors.fg },
		lCursor      = { link = 'Cursor' },
		CursorIM     = { link = 'Cursor' },
		CursorLine   = { bg = colors.bg_light0 },
		CursorColumn = { link = 'CursorLine' },
		Directory    = { fg = colors.light4 },
		DiffAdd      = { bg = colors.diff.add },
		DiffChange   = { bg = colors.diff.change },
		DiffDelete   = { bg = colors.diff.delete },
		DiffText     = { bg = colors.diff.text },
		EndOfBuffer  = { fg = colors.bg },
		-- TermCursor                     = {},
		-- TermCursorNC                   = {},
		ErrorMsg     = { fg = colors.diag.error, bg = 'NONE' },
		VertSplit    = { fg = colors.bg_status, bg = colors.bg_status },
		Folded       = { fg = colors.bg_light3, bg = colors.bg_light0 },
		FoldColumn   = { fg = colors.bg_light2, bg = 'NONE' },
		SignColumn   = { fg = colors.bg_light2, bg = 'NONE' },
		SignColumnSB = { link = 'SignColumn' },
		Substitute   = { fg = colors.fg, bg = colors.git.removed },
		LineNr       = { fg = colors.bg_light2 },
		CursorLineNr = { fg = colors.diag.warning, bg = 'NONE', bold = true },
		MatchParen   = { fg = colors.diag.warning, bg = 'NONE', bold = true },
		ModeMsg      = { fg = colors.diag.warning, bg = 'NONE', bold = true },
		MsgArea      = { link = 'NormalNC' },
		-- MsgSeparator                   = {},
		MoreMsg      = { fg = colors.diag.info, bg = colors.bg },
		NonText      = { fg = colors.bg_light2 },
		Normal       = { fg = colors.fg, bg = not config.transparent and colors.bg or 'NONE' },
		NormalNC     = config.dim_inactive and { fg = colors.fg_dark, bg = colors.bg_dim } or { link = 'Normal' },
		NormalSB     = config.darken_sidebar and { fg = colors.fg_dark, bg = colors.bg_dim } or { link = 'Normal' },
		NormalFloat  = { fg = colors.fg, bg = colors.bg_menu_sel },
		FloatBorder  = { fg = colors.fg_border, bg = 'NONE' },
		Pmenu        = { fg = colors.fg, bg = colors.bg_menu_sel },
		PmenuSel     = { fg = 'NONE', bg = colors.faded_yellow },
		PmenuSbar    = { link = 'Pmenu' },
		PmenuThumb   = { bg = colors.bg_search },
		Question     = { link = 'MoreMsg' },
		QuickFixLine = { link = 'CursorLine' },
		Search       = { fg = colors.fg, bg = colors.bg_search },
		IncSearch    = { fg = colors.bg_visual, bg = colors.diag.warning },
		SpecialKey   = { link = 'NonText' },
		SpellBad     = { sp = colors.diag.error, undercurl = true },
		SpellCap     = { sp = colors.diag.warning, undercurl = true },
		SpellLocal   = { sp = colors.diag.warning, undercurl = true },
		SpellRare    = { sp = colors.diag.warning, undercurl = true },
		StatusLine   = { fg = colors.fg_dark, bg = colors.bg_status },
		StatusLineNC = { fg = colors.fg_comment, bg = colors.bg_dim },
		TabLine      = { bg = colors.bg_dark, fg = colors.bg_light3 },
		TabLineFill  = { bg = colors.bg },
		TabLineSel   = { fg = colors.fg_dark, bg = colors.bg_light1 },
		Title        = { fg = colors.fn },
		Visual       = { bg = colors.bg_visual },
		VisualNOS    = { link = 'Visual' },
		WarningMsg   = { fg = colors.diag.warning, bg = 'NONE' },
		Whitespace   = { fg = colors.bg_light0 },
		WildMenu     = { link = 'Pmenu' },

		Constant  = { fg = colors.constant },
		String    = { fg = colors.string },
		Character = { link = 'String' },
		Number    = { fg = colors.number },
		Boolean   = { fg = colors.constant, bold = true },
		Float     = { link = 'Number' },

		Identifier = { fg = colors.identifier },
		Function   = extend({ fg = colors.fn }, config.function_style),
		Statement  = extend({ fg = colors.statement }, config.statement_style),
		-- Conditional                    = {},
		-- Repeat                         = {},
		-- Label                          = {},
		Operator   = { fg = colors.operator },
		Keyword    = extend({ fg = colors.keyword }, config.keyword_style),
		Exception  = { fg = colors.special2 },

		PreProc = { fg = colors.preproc },
		-- Include                        = {},
		-- Define                         = {},
		-- Macro                          = {},
		-- PreCondit                      = {},

		Type = extend({ fg = colors.type }, config.type_style),
		-- StorageClass                   = {},
		-- Structure                      = {},
		-- Typedef                        = {},

		Special   = { fg = colors.special },
		-- SpecialChar                    = {},
		-- Tag                            = {},
		Delimiter = { fg = colors.delimiter },
		-- SpecialComment                 = {},
		-- Debug                          = {},

		Underlined = { fg = colors.special, underline = true },
		Bold       = { bold = true },
		Italic     = { italic = true },

		Ignore = { link = 'NonText' },

		Error = { fg = colors.diag.error, bg = 'NONE' },
		Todo  = { fg = colors.diag.info, bg = 'NONE', bold = true },

		qfLineNr   = { link = 'lineNr' },
		qfFileName = { link = 'Directory' },

		-- htmlH1                         = {},
		-- htmlH2                         = {},

		-- mkdHeading                     = {},
		-- mkdCode                        = {},
		-- mkdCodeDelimiter               = {},
		-- mkdCodeStart                   = {},
		-- mkdCodeEnd                     = {},
		-- mkdLink                        = {},

		-- markdownHeadingDelimiter       = {},
		-- markdownCode                   = {},
		-- markdownCodeBlock              = {},
		-- markdownH1                     = {},
		-- markdownH2                     = {},
		-- markdownLinkText               = {},

		debugPC         = { link = 'CursorLine' },
		debugBreakpoint = { fg = colors.special },

		LspReferenceText  = { bg = colors.diff.text },
		LspReferenceRead  = { link = 'LspReferenceText' },
		LspReferenceWrite = { link = 'LspReferenceText' },

		DiagnosticError = { fg = colors.diag.error },
		DiagnosticWarn  = { fg = colors.diag.warning },
		DiagnosticInfo  = { fg = colors.diag.info },
		DiagnosticHint  = { fg = colors.diag.hint },

		DiagnosticSignError = { link = 'DiagnosticError' },
		DiagnosticSignWarn  = { link = 'DiagnosticWarn' },
		DiagnosticSignInfo  = { link = 'DiagnosticInfo' },
		DiagnosticSignHint  = { link = 'DiagnosticHint' },

		DiagnosticVirtualTextError = { link = 'DiagnosticError' },
		DiagnosticVirtualTextWarn  = { link = 'DiagnosticWarn' },
		DiagnosticVirtualTextInfo  = { link = 'DiagnosticInfo' },
		DiagnosticVirtualTextHint  = { link = 'DiagnosticHint' },

		DiagnosticUnderlineError = { sp = colors.diag.error, undercurl = true },
		DiagnosticUnderlineWarn  = { sp = colors.diag.warning, undercurl = true },
		DiagnosticUnderlineInfo  = { sp = colors.diag.info, undercurl = true },
		DiagnosticUnderlineHint  = { sp = colors.diag.hint, undercurl = true },

		DiagnosticLineBackgroundError = { bg = 'NONE' },
		DiagnosticLineBackgroundWarn = { bg = 'NONE' },
		DiagnosticLineBackgroundInfo = { bg = 'NONE' },
		DiagnosticLineBackgroundHint = { bg = 'NONE' },

		LspSignatureActiveParameter = { fg = colors.diag.warning },
		LspCodeLens                 = { fg = colors.fg_comment },

		['@none']                  = { default = true },
		['@punctuation.delimiter'] = { link = 'Delimiter' },
		['@punctuation.bracket']   = { link = 'Delimiter' },
		['@punctuation.special']   = { link = 'Delimiter' },

		['@constant']          = { link = 'Constant' },
		['@constant.builtin']  = { link = 'Special' },
		['@constant.macro']    = { link = 'Define' },
		['@string']            = { link = 'String' },
		['@string.regex']      = { fg = colors.regex },
		['@string.escape']     = { fg = colors.regex, bold = true },
		['@string.special']    = { link = 'SpecialChar' },
		['@character']         = { link = 'Character' },
		['@character.special'] = { link = 'SpecialChar' },
		['@number']            = { link = 'Number' },
		['@boolean']           = { link = 'Boolean' },
		['@float']             = { link = 'Float' },

		['@function']            = { link = 'Function' },
		['@function.call']       = { link = '@function' },
		['@function.builtin']    = { link = 'Special' },
		['@function.macro']      = { link = 'Macro' },
		['@parameter']           = { link = 'Identifier' },
		['@parameter.reference'] = { link = '@parameter' },
		['@method']              = { link = 'Function' },
		['@method.call']         = { link = '@method' },
		['@field']               = { link = 'Identifier' },
		['@property']            = { link = 'Identifier' },
		['@constructor']         = { fg = colors.keyword },
		['@annotation']          = { link = 'PreProc' },
		['@attribute']           = { link = 'PreProc' },
		['@namespace']           = { link = 'Include' },
		['@symbol']              = { link = 'Identifier' },

		['@conditional']      = { link = 'Conditional' },
		['@repeat']           = { link = 'Repeat' },
		['@label']            = { link = 'Label' },
		['@operator']         = { link = 'Operator' },
		['@keyword']          = { link = 'Keyword' },
		['@keyword.function'] = { link = 'Keyword' },
		['@keyword.operator'] = { fg = colors.operator, bold = true },
		['@keyword.return']   = extend({
			fg = config.special_return
				 and colors.special3
				 or colors.keyword,
		}, config.keyword_style),

		['@exception']    = extend({
			fg = config.special_exception
				 and colors.special3
				 or colors.statement
		}, config.statement_style),
		['@debug']        = { link = 'Debug' },
		['@define']       = { link = 'Define' },
		['@preproc']      = { link = 'PreProc' },
		['@storageclass'] = { link = 'StorageClass' },

		['@todo'] = { link = 'Todo' },

		['@type']            = { link = 'Type' },
		['@type.builtin']    = { link = '@type' },
		['@type.qualifier']  = { link = '@type' },
		['@type.definition'] = { link = 'Typedef' },

		['@include'] = { link = 'Include' },

		['@variable']         = { fg = 'NONE' },
		['@variable.builtin'] = extend({ fg = colors.special2 }, config.variablebuiltin_style),

		['@text']                  = { link = '@none' },
		['@text.strong']           = { bold = true, default = true },
		['@text.emphasis']         = { italic = true, default = true },
		['@text.underline']        = { underline = true },
		['@text.strike']           = { strikethrough = true },
		['@text.math']             = { link = 'Special', default = true },
		['@text.reference']        = { link = 'Constant', default = true },
		['@text.environment']      = { link = 'Macro', default = true },
		['@text.environment.name'] = { link = 'Type', default = true },
		['@text.title']            = { link = 'Title', default = true },
		['@text.literal']          = { link = 'String', default = true },
		['@text.uri']              = { link = 'Underlined', default = true },

		['@text.diff.add']    = { link = 'diffAdded' },
		['@text.diff.delete'] = { link = 'diffRemoved' },

		['@comment']      = { link = 'Comment', default = true },
		['@text.note']    = { link = 'SpecialComment', default = true },
		['@text.warning'] = { link = 'Todo', default = true },
		['@text.danger']  = { link = 'WarningMsg', default = true },

		['@error'] = { fg = colors.diag.error },

		['@tag']           = { link = 'Label', default = true },
		['@tag.attribute'] = { link = '@property' },
		['@tag.delimiter'] = { link = 'Delimiter' },

		-- Git
		diffAdded   = { fg = colors.git.added },
		diffRemoved = { fg = colors.git.removed },
		diffDeleted = { fg = colors.git.removed },
		diffChanged = { fg = colors.git.changed },
		diffOldFile = { fg = colors.git.removed },
		diffNewFile = { fg = colors.git.added },
		-- diffFile                       = { fg = colors.gray },
		-- diffLine                       = { fg = colors.ray },
		-- diffIndexLine                  = { link = 'Identifier' },

		-- Neogit
		NeogitBranch               = { fg = colors.constant },
		NeogitRemote               = { fg = colors.type },
		NeogitHunkHeader           = { bg = colors.bg_dim },
		NeogitHunkHeaderHighlight  = { bg = colors.bg_dim },
		NeogitDiffContextHighlight = { bg = colors.bg_dark, fg = colors.fg_dark },
		NeogitDiffDeleteHighlight  = { fg = m.alter(colors.git.removed, -5), bg = m.alter(colors.git.removed, -65) },
		NeogitDiffAddHighlight     = { fg = m.alter(colors.git.added, -5), bg = m.alter(colors.git.added, -65) },

		-- GitSigns
		GitSignsAdd      = { fg = colors.git.added },
		GitSignsChange   = { fg = colors.git.changed },
		GitSignsDelete   = { fg = colors.git.removed },
		GitSignsDeleteLn = { fg = 'NONE', bg = colors.diff.delete },

		-- Telescope                      = {},
		TelescopeBorder = { link = 'FloatBorder' },
		TelescopeNormal = { link = 'Normal' },

		-- NvimTree                       = {},
		NvimTreeNormal      = { link = 'NormalSB' },
		NvimTreeNormalNC    = { link = 'NormalSB' },
		NvimTreeRootFolder  = { fg = colors.comment, bold = true },
		NvimTreeGitDirty    = { fg = colors.git.changed },
		NvimTreeGitNew      = { fg = colors.git.added },
		NvimTreeGitDeleted  = { fg = colors.git.removed },
		NvimTreeSpecialFile = { fg = colors.special },
		-- NvimTreeIndentMarker           = {},
		NvimTreeImageFile   = { fg = colors.special2 },
		NvimTreeSymlink     = { link = 'Type' },
		NvimTreeFolderName  = { link = 'Directory' },
		NvimTreeExecFile    = { fg = colors.operator, bold = true },
		NvimTreeGitStaged   = { fg = colors.git.added },
		NvimTreeOpenedFile  = { fg = colors.special, italic = true },

		-- NeoTree
		-- the buffer number shown in the buffers source.
		NeoTreeBufferNumber = { fg = colors.constant },

		-- -- |hl-CursorLine| override in neo-tree window.
		-- NeoTreeCursorLine              = {},

		-- greyed out text used in various places.
		NeoTreeDimText = { link = 'NormalNC' },

		-- -- directory icon.
		-- NeoTreeDirectoryIcon           = {},

		-- -- directory name.
		-- NeoTreeDirectoryName           = {},

		-- -- used for icons and names when dotfiles are filtered.
		-- NeoTreeDotfile                 = {},

		-- -- file icon, when not overriden by devicons.
		-- NeoTreeFileIcon                = {},

		-- -- file name, when not overwritten by another status.
		-- NeoTreeFileName                = {},

		-- -- file name when the file is open.
		-- NeoTreeFileNameOpened          = {},

		-- -- the filter term, as displayed in the root node.
		-- NeoTreeFilterTerm              = {},

		-- the border for pop-up windows.
		NeoTreeFloatBorder = { link = 'FloatBorder' },

		-- -- used for the title text of pop-ups when the
		-- -- border-style is set to another style than 'NC'. this
		-- -- is derived from `NeoTreeFloatBorder`.
		-- NeoTreeFloatTitle              = {},

		-- -- used for the title bar of pop-ups, when the
		-- -- border-style is set to 'NC'. This is derived from
		-- -- `NeoTreeFloatBorder`.
		-- NeoTreeTitleBar                = {},

		-- -- file name when the git status is added.
		-- NeoTreeGitAdded                = {},

		-- -- file name when the git status is conflict.
		-- NeoTreeGitConflict             = {},

		-- -- file name when the git status is deleted.
		-- NeoTreeGitDeleted              = {},

		-- -- file name when the git status is ignored.
		-- NeoTreeGitIgnored              = {},

		-- -- file name when the git status is modified.
		-- NeoTreeGitModified             = {},

		-- -- used for git unstaged symbols.
		-- NeoTreeGitUnstaged             = {},

		-- -- file name when the git status is untracked.
		-- NeoTreeGitUntracked            = {},

		-- -- used for git staged symbol.
		-- NeoTreeGitStaged               = {},

		-- --used for icons and names when `hide_by_name` is used.
		-- NeoTreeHiddenByName            = {},

		-- the style of indentation markers (guides). by default,
		-- the 'Normal' highlight is used.
		NeoTreeIndentMarker = { fg = colors.bg_light1 },

		-- used for collapsed/expanded icons.
		NeoTreeExpander = config.darken_sidebar and { fg = colors.fg_dark } or { fg = colors.fg },

		-- |hl-Normal| override in neo-tree window.
		NeoTreeNormal = { link = 'NormalSB' },

		-- |hl-NormalNC| override in neo-tree window.
		NeoTreeNormalNC = { link = 'NormalSB' },

		-- -- |hl-SignColumn| override in neo-tree window.
		-- NeoTreeSignColumn              = {},

		-- -- |hl-StatusLine| override in neo-tree window.
		-- NeoTreeStatusLine              = {},

		-- -- |hl-StatusLineNC| override in neo-tree window.
		-- NeoTreeStatusLineNC            = {},

		-- -- |hl-VertSplit| override in neo-tree window.
		-- NeoTreeVertSplit               = {},

		-- -- |hl-WinSeparator| override in neo-tree window.
		-- NeoTreeWinSeparator            = {},

		-- -- |hl-EndOfBuffer| override in neo-tree window.
		-- NeoTreeEndOfBuffer             = {},

		-- -- the name of the root node.
		-- NeoTreeRootName                = {},

		-- -- symbolic link target.
		-- NeoTreeSymbolicLinkTarget      = {},

		-- -- used for the title bar of pop-ups, when the
		-- -- border-style is set to 'NC'. this is derived from
		-- -- `NeoTreeFloatBorder`.
		-- NeoTreeTitleBar                = {},

		-- -- used for icons and names that are hidden on
		-- -- winblows.
		-- NeoTreeWindowsHidden           = {},

		-- glyph palette                  = {},
		-- GlyphPalette1                  = {},
		-- GlyphPalette2                  = {},
		-- GlyphPalette3                  = {},
		-- GlyphPalette4                  = {},
		-- GlyphPalette6                  = {},
		-- GlyphPalette7                  = {},
		-- GlyphPalette9                  = {},

		-- Dashboard
		DashboardShortCut = { fg = colors.special },
		DashboardHeader   = { fg = colors.git.removed },
		DashboardCenter   = { fg = colors.identifier },
		DashboardFooter   = { fg = colors.fn },

		-- Floaterm
		FloatermBorder = { fg = colors.bg_light3 },

		-- NeoVim                         = {},
		healthError   = { fg = colors.diag.error },
		healthSuccess = { fg = colors.diag.hint },
		healthWarning = { fg = colors.diag.warning },

		-- Leap
		LeapMatch          = { fg = colors.fg, bg = colors.number, bold = true },
		LeapLabelPrimary   = { fg = colors.fg, bg = colors.number, bold = true },
		LeapLabelSecondary = { fg = colors.type, bold = true },
		LeapBackdrop       = { fg = colors.fg_comment, italic = true },

		-- Cmp
		CmpDocumentation       = { fg = colors.fg, bg = colors.bg_popup },
		CmpDocumentationBorder = { fg = colors.fg_border, bg = 'NONE' },

		CmpItemAbbr           = { fg = colors.fg, bg = 'NONE' },
		CmpItemAbbrDeprecated = { fg = colors.fg_comment, bg = 'NONE', strikethrough = true },

		CmpItemAbbrMatch      = { fg = colors.fn, bg = 'NONE' },
		CmpItemAbbrMatchFuzzy = { link = 'CmpItemAbbrMatch' },

		CmpItemKindDefault = { fg = colors.fg_comment, bg = 'NONE' },
		CmpItemMenu        = { fg = colors.fg_comment, bg = 'NONE' },

		CmpItemKindVariable = { fg = colors.fg_dark, bg = 'NONE' },

		CmpItemKindFunction = { link = 'Function' },
		CmpItemKindMethod   = { link = 'Function' },

		CmpItemKindConstructor = { link = '@constructor' },

		CmpItemKindClass     = { link = 'Type' },
		CmpItemKindInterface = { link = 'Type' },
		CmpItemKindStruct    = { link = 'Type' },

		CmpItemKindProperty = { link = '@property' },
		CmpItemKindField    = { link = '@field' },
		CmpItemKindEnum     = { link = 'Identifier' },

		CmpItemKindSnippet = { fg = colors.special, bg = 'NONE' },

		CmpItemKindText = { link = '@text' },

		CmpItemKindModule = { link = '@include' },

		CmpItemKindFile   = { link = 'Directory' },
		CmpItemKindFolder = { link = 'Directory' },

		CmpItemKindKeyword       = { link = '@keyword' },
		CmpItemKindTypeParameter = { link = 'Identifier' },
		CmpItemKindConstant      = { link = 'Constant' },
		CmpItemKindOperator      = { link = 'Operator' },
		CmpItemKindReference     = { link = '@parameter.reference' },
		CmpItemKindEnumMember    = { link = '@field' },

		CmpItemKindValue = { link = 'String' },
		-- CmpItemKindUnit                = {},
		-- CmpItemKindEvent               = {},
		-- CmpItemKindColor               = {},

		-- IndentBlankline
		IndentBlanklineChar               = { fg = colors.bg_light1 },
		IndentBlanklineSpaceChar          = { fg = colors.bg_light1 },
		IndentBlanklineSpaceCharBlankline = { fg = colors.bg_light1 },
		IndentBlanklineContextChar        = { fg = colors.bg_light3 },
		IndentBlanklineContextStart       = { sp = colors.bg_light3, underline = true },

		-- SymbolsOutline
		FocusedSymbol = { fg = colors.identifier },
		-- SymbolsOutlineConnector        = {},
	}

	return deep_extend('force', hlgroups, config.overrides)
end

local current_colorscheme = {}

---get the currently active colorscheme
---
---@return table colorscheme current colorscheme
function m.current() return current_colorscheme end

---load a colorscheme.
---
---given a colorscheme name  and  a  configuration  table,  will
---generate and apply  opinionated  highlight  groups  from  the
---colorscheme definition. will raise an error had the requested
---colorscheme not been found.
---
--- @param colorscheme string name of the colorscheme
--- @param config? table configuration to override the defaults with
function m.load(colorscheme, config)
	local has_colors, colors = pcall(require, 'colors.' .. colorscheme)

	assertx(
		has_colors,
		string.format,
		'invalid parameter #1 to "load": "%s" colorscheme not found',
		colorscheme
	)

	current_colorscheme = colors

	if vim.g.colors_name then
		vim.cmd.highlight({ 'clear' })
	end

	if vim.fn.exists('syntax_on') then
		vim.cmd.syntax('reset')
	end

	vim.g.colors_name   = colorscheme
	vim.o.termguicolors = true

	config = config or defaults()

	local effective_colors = generate_colors(colors, config)
	local highlight_groups = generate_highlights(effective_colors, config)

	apply_highlight_groups(highlight_groups)
	dim_on_focus_lost(config)
end

return m
