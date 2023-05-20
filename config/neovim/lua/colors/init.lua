local assertx = require("assertx")
local f = require("f")
local constant = require("f.function.constant")
local deep_extend = require("tablex.deep_extend")
local extend = require("tablex.extend")
local is_empty = require("tablex.is_empty")

local m = {}

---convert a hex color to rgb.
---
---@param color string hex string to convert
---@return number r
---@return number g
---@return number b
local function hex_to_rgb(color)
	local hex = color:gsub("#", "")

	return tonumber(hex:sub(1, 2), 16),
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
		return "NONE"
	end

	r, g, b = alterc(r, percent), alterc(g, percent), alterc(b, percent)
	r, g, b = math.min(r, 255), math.min(g, 255), math.min(b, 255)

	return string.format("#%02x%02x%02x", r, g, b)
end

---set autocommands to dim the active window when neovim loses
---focus.
---
---@param config table
local function dim_on_focus_lost(config)
	if not config.dim_on_focus_lost then
		return
	end

	local augroup =
		vim.api.nvim_create_augroup("DimOnInactive", { clear = true })

	vim.api.nvim_create_autocmd("FocusLost", {
		group = augroup,
		callback = function()
			vim.opt.winhighlight = "Normal:NormalNC,MsgArea:NormalNC"
		end,
	})

	vim.api.nvim_create_autocmd("FocusGained", {
		group = augroup,
		callback = function()
			vim.opt.winhighlight = ""
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
	undercurl = true,
	comment_style = { italic = true },
	function_style = {},
	keyword_style = { italic = true },
	statement_style = { italic = true },
	type_style = {},
	variablebuiltin_style = { italic = true },
	special_return = false,
	special_exception = true,
	transparent = false,
	darken_sidebar = true,
	dim_inactive = true,
	dim_on_focus_lost = true,
	overrides = {},
	theme = "default",
})

---generate color table.
---
---@param cs table options containing colors and theme fields
---@param config table? options containing colors and theme fields (optional)
---@return table palette colors and theme colors merged with `config.overrides`
local function generate_colors(cs, config)
	local conf = deep_extend("force", defaults(), config)
	local colors = deep_extend("force", cs.palette(), conf.overrides)
	local theme =
		deep_extend("force", cs.themes(conf.theme)(colors), conf.overrides)

	return deep_extend("force", theme, colors)
end

local function apply_highlight_groups(hlgroups)
	f.iterate(hlgroups):foreach(function(group, colors)
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
		Comment = extend({ fg = colors.fg_comment }, config.comment_style),
		ColorColumn = { bg = colors.bg1 },
		Conceal = { fg = colors.blue },
		Cursor = { fg = colors.bg, bg = colors.fg },
		lCursor = { link = "Cursor" },
		vCursor = { link = "Cursor" },
		iCursor = { link = "Cursor" },
		CursorIM = { link = "Cursor" },
		CursorLine = { bg = colors.bg1 },
		CursorColumn = { link = "CursorLine" },
		CursorLineSign = { link = "CursorLine" },
		CursorLineFold = { link = "CursorLine" },
		Directory = { fg = colors.blue, bold = true },
		DiffAdd = { fg = colors.green },
		DiffChange = { fg = colors.aqua },
		DiffDelete = { fg = colors.red },
		DiffText = { fg = colors.yellow },
		EndOfBuffer = { fg = colors.bg },
		-- TermCursor                     = {},
		-- TermCursorNC                   = {},
		ErrorMsg = { fg = colors.red, bg = "NONE" },
		VertSplit = { fg = colors.bg3, bg = colors.bg_dim },
		Folded = { fg = colors.gray, bg = colors.bg1, italic = true },
		FoldColumn = { fg = colors.gray, bg = colors.bg1 },
		SignColumn = { fg = colors.bg3, bg = "NONE" },
		SignColumnSB = { link = "SignColumn" },
		Substitute = { fg = colors.fg, bg = colors.yellow },
		LineNr = { fg = colors.bg3 },
		CursorLineNr = { fg = colors.yellow, bg = colors.bg1 },
		MatchParen = { fg = colors.bg3, bold = true },
		ModeMsg = { fg = colors.yellow, bg = "NONE", bold = true },
		MsgArea = { link = "NormalNC" },
		-- MsgSeparator                   = {},
		MoreMsg = { fg = colors.yellow },
		NonText = { fg = colors.bg2 },
		Normal = {
			fg = colors.fg1,
			bg = not config.transparent and colors.bg or "NONE",
		},
		NormalNC = config.dim_inactive
				and { fg = colors.fg0, bg = colors.bg_dim }
			or { link = "Normal" },
		NormalSB = config.darken_sidebar
				and { fg = colors.fg0, bg = colors.bg_dim }
			or { link = "Normal" },
		NormalFloat = { fg = colors.fg, bg = colors.bg_menu_sel },
		FloatBorder = { fg = colors.fg_border, bg = "NONE" },
		Pmenu = { fg = colors.fg1, bg = colors.bg_soft },
		PmenuSel = { fg = colors.bg2, bg = colors.yellow, bold = true },
		PmenuSbar = { bg = colors.bg2 },
		PmenuThumb = { bg = colors.bg4 },
		Question = { fg = colors.orange, bold = true },
		QuickFixLine = {
			fg = colors.bg0,
			bg = colors.neutral_yellow,
			bold = true,
		},
		Search = { fg = colors.yellow, bg = colors.bg0 },
		IncSearch = { fg = colors.orange, bg = colors.bg0 },
		CurSearch = { link = "IncSearch" },
		SpecialKey = { fg = colors.fg4 },
		SpellBad = { sp = colors.red, undercurl = true },
		SpellCap = { sp = colors.blue, undercurl = true },
		SpellLocal = { sp = colors.aqua, undercurl = true },
		SpellRare = { sp = colors.purple, undercurl = true },
		StatusLine = { fg = colors.fg2, bg = colors.bg_dim },
		StatusLineNC = { fg = colors.bg2, bg = colors.bg_dim },
		TabLine = { bg = colors.bg1, fg = colors.bg4 },
		TabLineFill = { link = "TabLine" },
		TabLineSel = { fg = colors.bg1, bg = colors.yellow },
		Title = { fg = colors.green, bold = true },
		Visual = { bg = colors.bg2 },
		VisualNOS = { link = "Visual" },
		WarningMsg = { fg = colors.red, bold = true },
		Whitespace = { fg = colors.bg2 },
		WildMenu = { link = "Pmenu" },
		User1 = { fg = colors.blue, bg = colors.bg_dim },
		User2 = { fg = colors.aqua, bg = colors.bg_dim },
		User3 = { fg = colors.yellow, bg = colors.bg_dim },
		User4 = { fg = colors.orange, bg = colors.bg_dim },

		Constant = { fg = colors.purple },
		String = { fg = colors.neutral_green, italic = true },
		Character = { link = "Constant" },
		Number = { link = "Constant" },
		Boolean = { link = "Constant" },
		Float = { link = "Number" },

		Identifier = { fg = colors.blue },
		Function = extend(
			{ fg = colors.orange, bold = true },
			config.function_style
		),
		Statement = extend({ fg = colors.red }, config.statement_style),
		Conditional = { link = "Statement" },
		Repeat = { link = "Statement" },
		Label = { link = "Statement" },
		Operator = { fg = colors.orange, italic = true },
		Keyword = extend({ fg = colors.red }, config.keyword_style),
		Exception = { fg = colors.red },

		PreProc = { fg = colors.aqua },
		Include = { link = "PreProc" },
		Define = { link = "PreProc" },
		Macro = { link = "PreProc" },
		PreCondit = { link = "PreProc" },

		Type = extend({ fg = colors.yellow }, config.type_style),
		StorageClass = { fg = colors.orange },
		Structure = { fg = colors.aqua },
		Typedef = { fg = colors.yellow },

		Special = { fg = colors.orange },
		-- SpecialChar    = {},
		-- Tag            = {},
		Delimiter = { fg = colors.delimiter },
		-- SpecialComment = {},
		-- Debug          = {},

		Underlined = { fg = colors.blue, underline = true },
		Bold = { bold = true },
		Italic = { italic = true },

		Ignore = { link = "NonText" },

		Error = { fg = colors.red, bold = true },
		Todo = { fg = colors.fg0, bold = true },

		qfLineNr = { link = "lineNr" },
		qfFileName = { link = "Directory" },

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

		debugPC = { link = "CursorLine" },
		debugBreakpoint = { fg = colors.special },

		LspReferenceText = { fg = colors.yellow, bold = true },
		LspReferenceRead = { fg = colors.yellow, bold = true },
		LspReferenceWrite = { fg = colors.orange, bold = true },

		DiagnosticError = { fg = colors.red, bg = "NONE" },
		DiagnosticWarn = { fg = colors.yellow, bg = "NONE" },
		DiagnosticInfo = { fg = colors.blue },
		DiagnosticHint = { fg = colors.aqua },

		DiagnosticSignError = { link = "DiagnosticError" },
		DiagnosticSignWarn = { link = "DiagnosticWarn" },
		DiagnosticSignInfo = { link = "DiagnosticInfo" },
		DiagnosticSignHint = { link = "DiagnosticHint" },

		DiagnosticVirtualTextError = { link = "DiagnosticError" },
		DiagnosticVirtualTextWarn = { link = "DiagnosticWarn" },
		DiagnosticVirtualTextInfo = { link = "DiagnosticInfo" },
		DiagnosticVirtualTextHint = { link = "DiagnosticHint" },

		DiagnosticUnderlineError = { sp = colors.red, undercurl = true },
		DiagnosticUnderlineWarn = { sp = colors.yellow, undercurl = true },
		DiagnosticUnderlineInfo = { sp = colors.blue, undercurl = true },
		DiagnosticUnderlineHint = { sp = colors.aqua, undercurl = true },

		DiagnosticLineBackgroundError = { bg = "NONE" },
		DiagnosticLineBackgroundWarn = { bg = "NONE" },
		DiagnosticLineBackgroundInfo = { bg = "NONE" },
		DiagnosticLineBackgroundHint = { bg = "NONE" },

		DiagnosticCulError = { fg = colors.red, bg = colors.bg1 },
		DiagnosticCulWarn = { fg = colors.yellow, bg = colors.bg1 },
		DiagnosticCulInfo = { fg = colors.blue, bg = colors.bg1 },
		DiagnosticCulHint = { fg = colors.aqua, bg = colors.bg1 },

		LspSignatureActiveParameter = { fg = colors.yellow },
		LspCodeLens = { fg = colors.fg_comment },

		["@none"] = { default = true },
		["@punctuation.delimiter"] = { link = "Delimiter" },
		["@punctuation.bracket"] = { link = "Delimiter" },
		["@punctuation.special"] = { link = "Delimiter" },

		["@constant"] = { link = "Constant" },
		["@constant.builtin"] = { link = "Special" },
		["@constant.macro"] = { link = "Define" },
		["@string"] = { link = "String" },
		["@string.regex"] = { fg = colors.regex },
		["@string.escape"] = { fg = colors.regex, bold = true },
		["@string.special"] = { link = "SpecialChar" },
		["@character"] = { link = "Character" },
		["@character.special"] = { link = "SpecialChar" },
		["@number"] = { link = "Number" },
		["@boolean"] = { link = "Boolean" },
		["@float"] = { link = "Float" },

		["@function"] = { link = "Function" },
		["@function.call"] = { link = "@function" },
		["@function.builtin"] = { link = "Special" },
		["@function.macro"] = { link = "Macro" },
		["@parameter"] = { link = "Identifier" },
		["@parameter.reference"] = { link = "@parameter" },
		["@method"] = { link = "Function" },
		["@method.call"] = { link = "@method" },
		["@field"] = { link = "Identifier" },
		["@property"] = { link = "Identifier" },
		["@constructor"] = { fg = colors.keyword },
		["@annotation"] = { link = "PreProc" },
		["@attribute"] = { link = "PreProc" },
		["@namespace"] = { link = "Include" },
		["@symbol"] = { link = "Identifier" },

		["@conditional"] = { link = "Conditional" },
		["@repeat"] = { link = "Repeat" },
		["@label"] = { link = "Label" },
		["@operator"] = { link = "Operator" },
		["@keyword"] = { link = "Keyword" },
		["@keyword.function"] = { link = "Keyword" },
		["@keyword.operator"] = { fg = colors.operator, bold = true },
		["@keyword.return"] = extend({
			fg = config.special_return and colors.special3 or colors.keyword,
		}, config.keyword_style),

		["@exception"] = extend({
			fg = config.special_exception and colors.special3
				or colors.statement,
		}, config.statement_style),
		["@debug"] = { link = "Debug" },
		["@define"] = { link = "Define" },
		["@preproc"] = { link = "PreProc" },
		["@storageclass"] = { link = "StorageClass" },

		["@todo"] = { link = "Todo" },

		["@type"] = { link = "Type" },
		["@type.builtin"] = { link = "@type" },
		["@type.qualifier"] = { link = "@type" },
		["@type.definition"] = { link = "Typedef" },

		["@include"] = { link = "Include" },

		["@variable"] = { fg = colors.fg2 },
		["@variable.builtin"] = extend(
			{ fg = colors.special2 },
			config.variablebuiltin_style
		),

		["@text"] = { link = "@none" },
		["@text.strong"] = { bold = true, default = true },
		["@text.emphasis"] = { italic = true, default = true },
		["@text.underline"] = { underline = true },
		["@text.strike"] = { strikethrough = true },
		["@text.math"] = { link = "Special", default = true },
		["@text.reference"] = { link = "Constant", default = true },
		["@text.environment"] = { link = "Macro", default = true },
		["@text.environment.name"] = {
			link = "Type",
			default = true,
		},
		["@text.title"] = { link = "Title", default = true },
		["@text.literal"] = { link = "String", default = true },
		["@text.uri"] = { link = "Underlined", default = true },

		["@text.diff.add"] = { link = "diffAdded" },
		["@text.diff.delete"] = { link = "diffRemoved" },

		["@comment"] = { link = "Comment", default = true },
		["@text.note"] = { link = "SpecialComment", default = true },
		["@text.warning"] = { link = "Todo", default = true },
		["@text.danger"] = { link = "WarningMsg", default = true },

		["@error"] = { fg = colors.red },

		["@tag"] = { link = "Label", default = true },
		["@tag.attribute"] = { link = "@property" },
		["@tag.delimiter"] = { link = "Delimiter" },

		-- Semantic tokens
		["@class"] = { link = "@constructor" },
		["@struct"] = { link = "@constructor" },
		["@enum"] = { link = "@constructor" },
		["@enumMember"] = { link = "Constant" },
		["@event"] = { link = "Identifier" },
		["@interface"] = { link = "Type" },
		["@modifier"] = { link = "Identifier" },
		["@regexp"] = { link = "SpecialChar" },
		["@typeParameter"] = { link = "Type" },
		["@decorator"] = { link = "Identifier" },

		-- This is intended for python but should be safe to enable globally.
		-- Note: Python-only override is `@string.documentation.python`.
		["@string.documentation"] = { link = "Comment" },

		-- Git
		diffAdded = { fg = colors.green },
		diffRemoved = { fg = colors.red },
		diffChanged = { fg = colors.aqua },
		diffDeleted = { fg = colors.red },
		diffOldFile = { fg = colors.red },
		diffNewFile = { fg = colors.yellow },
		diffFile = { fg = colors.orange },
		diffLine = { fg = colors.blue },
		-- diffIndexLine = { link = 'Identifier' },

		-- Neogit
		NeogitBranch = { fg = colors.orange },
		NeogitRemote = { fg = colors.green },
		-- NeogitHunkHeader           = { bg = colors.bg_dim },
		-- NeogitHunkHeaderHighlight  = { bg = colors.bg_dim },
		-- NeogitDiffContextHighlight = { bg = colors.bg_dark },
		-- NeogitDiffDeleteHighlight  = { fg = m.alter(colors.red, -5), bg = m.alter(colors.red, -65) },
		-- NeogitDiffAddHighlight     = { fg = m.alter(colors.green, -5), bg = m.alter(colors.green, -65) },

		-- GitSigns
		GitSignsAdd = { fg = colors.green },
		GitSignsChange = { fg = colors.orange },
		GitSignsDelete = { fg = colors.red },
		GitSignsUntracked = { fg = colors.gray },
		GitSignsAddCul = { fg = colors.green, bg = colors.bg1 },
		GitSignsChangeCul = { fg = colors.orange, bg = colors.bg1 },
		GitSignsDeleteCul = { fg = colors.red, bg = colors.bg1 },
		GitSignsUntrackedCul = { fg = colors.gray, bg = colors.bg1 },
		GitSignsDeleteLn = { fg = "NONE", bg = m.alter(colors.red, -65) },

		-- Telescope
		TelescopeNormal = { fg = colors.fg1, bg = colors.bg_dim },
		TelescopeSelection = {
			fg = colors.orange,
			bg = colors.bg_soft,
			bold = true,
		},
		TelescopeSelectionCaret = { fg = colors.red, bg = colors.bg_soft },
		TelescopeMultiSelection = { fg = colors.gray },
		TelescopeBorder = { link = "FloatBorder" },
		TelescopeResultsBorder = { link = "TelescopeNormal" },
		TelescopePreviewBorder = { link = "TelescopeNormal" },
		TelescopePromptBorder = { link = "TelescopePrompt" },
		TelescopeMatching = { fg = colors.blue },
		TelescopePromptPrefix = { fg = colors.red },
		TelescopePrompt = { fg = colors.fg1, bg = colors.bg_soft },
		TelescopePromptNormal = { link = "TelescopePrompt" },

		-- NeoVim                         = {},
		healthError = { fg = colors.error },
		healthSuccess = { fg = colors.green },
		healthWarning = { fg = colors.yellow },

		-- Leap
		LeapMatch = {
			fg = colors.fg,
			bg = colors.neutral_yellow,
			bold = true,
		},
		LeapLabelPrimary = {
			fg = colors.fg,
			bg = colors.neutral_yellow,
			bold = true,
		},
		LeapLabelSecondary = { fg = colors.green, bold = true },
		LeapBackdrop = { fg = colors.fg_comment, italic = true },

		-- vim-sandwich
		OperatorSandwichAdd = { fg = colors.gray, italic = true },
		OperatorSandwichBuns = { fg = colors.gray, italic = true },
		OperatorSandwichChange = { fg = colors.gray, italic = true },
		OperatorSandwichDelete = { fg = colors.gray, italic = true },

		-- Cmp
		CmpDocumentation = { fg = colors.fg, bg = colors.bg_popup },
		CmpDocumentationBorder = { fg = colors.fg_border, bg = "NONE" },

		CmpItemAbbr = { fg = colors.fg0, bg = "NONE" },
		CmpItemAbbrDeprecated = {
			fg = colors.fg_comment,
			bg = "NONE",
			strikethrough = true,
		},

		CmpItemAbbrMatch = { fg = colors.blue, bold = true },
		CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },

		CmpItemKindDefault = { fg = colors.fg_comment },
		CmpItemMenu = { fg = colors.fg_comment },

		CmpItemKindVariable = { fg = colors.fg_dark, bg = "NONE" },

		CmpItemKindFunction = { link = "Function" },
		CmpItemKindMethod = { link = "Function" },

		CmpItemKindConstructor = { link = "@constructor" },

		CmpItemKindClass = { link = "Type" },
		CmpItemKindInterface = { link = "Type" },
		CmpItemKindStruct = { link = "Type" },

		CmpItemKindProperty = { link = "@property" },
		CmpItemKindField = { link = "@field" },
		CmpItemKindEnum = { link = "Identifier" },

		CmpItemKindSnippet = { fg = colors.special, bg = "NONE" },

		CmpItemKindText = { link = "@text" },

		CmpItemKindModule = { link = "@include" },

		CmpItemKindFile = { link = "Directory" },
		CmpItemKindFolder = { link = "Directory" },

		CmpItemKindKeyword = { link = "@keyword" },
		CmpItemKindTypeParameter = { link = "Identifier" },
		CmpItemKindConstant = { link = "Constant" },
		CmpItemKindOperator = { link = "Operator" },
		CmpItemKindReference = { link = "@parameter.reference" },
		CmpItemKindEnumMember = { link = "@field" },

		CmpItemKindValue = { link = "String" },
		-- CmpItemKindUnit                = {},
		-- CmpItemKindEvent               = {},
		-- CmpItemKindColor               = {},

		-- IndentBlankline
		IndentBlanklineChar = { fg = colors.bg_light1 },
		IndentBlanklineSpaceChar = { fg = colors.bg_light1 },
		IndentBlanklineSpaceCharBlankline = { fg = colors.bg_light1 },
		IndentBlanklineContextChar = { fg = colors.bg_light3 },
		IndentBlanklineContextStart = {
			sp = colors.bg_light3,
			underline = true,
		},

		-- SymbolsOutline
		FocusedSymbol = { fg = colors.identifier },
		-- SymbolsOutlineConnector        = {},
	}

	return deep_extend("force", hlgroups, config.overrides)
end

local current_colorscheme = {}

---get the currently active colorscheme
---
---@return table colorscheme current colorscheme
function m.current()
	return current_colorscheme
end

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
	local has_colors, colors = pcall(require, "colors." .. colorscheme)

	assertx(
		has_colors,
		string.format,
		'invalid parameter #1 to "load": "%s" colorscheme not found',
		colorscheme
	)

	current_colorscheme = colors

	if vim.g.colors_name then
		vim.cmd.highlight({ "clear" })
	end

	if vim.fn.exists("syntax_on") then
		vim.cmd.syntax({ "reset" })
	end

	vim.g.colors_name = colorscheme
	vim.o.termguicolors = true

	config = config or defaults()

	local effective_colors = generate_colors(colors, config)
	local highlight_groups = generate_highlights(effective_colors, config)

	apply_highlight_groups(highlight_groups)
	dim_on_focus_lost(config)
end

return m
