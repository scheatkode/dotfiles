local f      = require('f')
local tablex = require('tablex')

local mfloor = math.floor
local mmin   = math.min

local tie = tablex.is_empty
local tde = tablex.deep_extend

local sf = string.format

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
	return mfloor(component * (100 + percent) / 100)
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
	r, g, b = mmin(r, 255), mmin(g, 255), mmin(b, 255)

	return sf('#%02x%02x%02x', r, g, b)
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

---clear highlights.
---
---clear a highlight group if given its name as an argument, all
---highlight groups otherwise.
---
---@param name string|nil highlight group to clear
function m.clear_hl(name)
	vim.cmd.highlight({ 'clear', name or ''})
end

---the default configuration table.
---
---using a function's return value as a  temporary  variable  to
---avoid the table lingering around the memory  after  its  use,
---when the garbage collector sweeps for unreferenced objects.
---
---@return table default configuration table
local function default_config()
	return {
		undercurl             = true,
		comment_style         = 'italic',
		function_style        = 'NONE',
		keyword_style         = 'italic',
		statement_style       = 'italic',
		type_style            = 'NONE',
		variablebuiltin_style = 'italic',
		special_return        = true,
		special_exception     = true,
		transparent           = false,
		darken_sidebar        = true,
		dim_inactive          = true,
		dim_on_focus_lost     = true,
		overrides             = {},
		theme                 = 'default',
	}
end

---generate color table.
---
---@param cs table options containing colors and theme fields
---@param config table? options containing colors and theme fields (optional)
---@return table palette colors and theme colors merged with `config.overrides`
local function generate_colors(cs, config)
	local conf   = tde('force', default_config(), config)
	local colors = tde('force', cs.palette(), conf.overrides)
	local theme  = tde('force', cs.themes(conf.theme)(colors), conf.overrides)

	return tde('force', theme, colors)
end

local function apply_highlight_groups(hlgroups)
	f.iterate(hlgroups):foreach(function(group, colors)
		if tie(colors) then return end

		if colors.link then
			vim.cmd.highlight({ 'link', group, colors.link, bang = true })
			return
		end

		local args = { group }

		if colors.fg then args[#args+1] = sf('guifg=%s ', colors.fg) end
		if colors.bg then args[#args+1] = sf('guibg=%s ', colors.bg) end
		if colors.style then args[#args+1] = sf('gui=%s ', colors.style) end
		if colors.guisp then args[#args+1] = sf('guisp=%s ', colors.guisp) end

		vim.cmd.highlight(args)
	end)
end

---generate highlights.
---
---@param colors table color (theme) table created by `generate_colors`
---@param config table|nil config options (optional)
local function generate_highlights(colors, config)
	local hlgroups = {
		Comment                           = { fg = colors.fg_comment, style = config.comment_style },
		ColorColumn                       = { bg = colors.bg_light0 },
		Conceal                           = { fg = colors.bg_light3, bg = 'NONE', style = 'bold' },
		Cursor                            = { fg = colors.bg, bg = colors.fg },
		lCursor                           = { link = 'Cursor' },
		CursorIM                          = { link = 'Cursor' },
		CursorLine                        = { bg = colors.bg_light0 },
		CursorColumn                      = { link = 'CursorLine' },
		Directory                         = { fg = colors.fn },
		DiffAdd                           = { bg = m.alter(colors.git.added, -70) },
		DiffChange                        = { bg = m.alter(colors.git.changed, -70) },
		DiffDelete                        = { fg = colors.git.removed, bg = m.alter(colors.git.removed, -70), style = 'none' },
		DiffText                          = { fg = 'NONE', bg = colors.diff.text },
		EndOfBuffer                       = { fg = colors.bg },
		-- TermCursor                     = {},
		-- TermCursorNC                   = {},
		ErrorMsg                          = { fg = colors.diag.error, bg = 'NONE' },
		VertSplit                         = { fg = colors.bg_status, bg = colors.bg_status, style = 'NONE' },
		Folded                            = { fg = colors.bg_light3, bg = colors.bg_light0 },
		FoldColumn                        = { fg = colors.bg_light2, bg = 'NONE' },
		SignColumn                        = { fg = colors.bg_light2, bg = 'NONE' },
		SignColumnSB                      = { link = 'SignColumn' },
		Substitute                        = { fg = colors.fg, bg = colors.git.removed },
		LineNr                            = { fg = colors.bg_light2 },
		CursorLineNr                      = { fg = colors.diag.warning, bg = 'NONE', style = 'bold' },
		MatchParen                        = { fg = colors.diag.warning, bg = 'NONE', style = 'bold' },
		ModeMsg                           = { fg = colors.diag.warning, style = 'bold', bg = 'NONE' },
		MsgArea                           = { link = 'NormalNC' },
		-- MsgSeparator                   = {},
		MoreMsg                           = { fg = colors.diag.info, bg = colors.bg, style = 'NONE' },
		NonText                           = { fg = colors.bg_light2 },
		Normal                            = { fg = colors.fg, bg = not config.transparent and colors.bg or 'NONE' },
		NormalNC                          = config.dim_inactive and { fg = colors.fg_dark, bg = colors.bg_dim } or { link = 'Normal' },
		NormalSB                          = config.darken_sidebar and { fg = colors.fg_dark, bg = colors.bg_dark } or { link = 'Normal' },
		NormalFloat                       = { fg = colors.fg, bg = colors.bg },
		FloatBorder                       = { fg = colors.fg_border, bg = 'NONE' },
		Pmenu                             = { fg = colors.fg, bg = colors.bg_menu },
		PmenuSel                          = { fg = 'NONE', bg = colors.bg_menu_sel },
		PmenuSbar                         = { link = 'Pmenu' },
		PmenuThumb                        = { bg = colors.bg_search },
		Question                          = { link = 'MoreMsg' },
		QuickFixLine                      = { link = 'CursorLine' },
		Search                            = { fg = colors.fg, bg = colors.bg_search },
		IncSearch                         = { fg = colors.bg_visual, bg = colors.diag.warning, style = 'NONE' },
		SpecialKey                        = { link = 'NonText' },
		SpellBad                          = { style = 'undercurl', guisp = colors.diag.error },
		SpellCap                          = { style = 'undercurl', guisp = colors.diag.warning },
		SpellLocal                        = { style = 'undercurl', guisp = colors.diag.warning },
		SpellRare                         = { style = 'undercurl', guisp = colors.diag.warning },
		StatusLine                        = { fg = colors.fg_dark, bg = colors.bg_status, style = 'NONE' },
		StatusLineNC                      = { fg = colors.fg_comment, bg = colors.bg_dim, style = 'NONE' },
		TabLine                           = { bg = colors.bg_dark, fg = colors.bg_light3, style = 'NONE' },
		TabLineFill                       = { bg = colors.bg, style = 'NONE' },
		TabLineSel                        = { fg = colors.fg_dark, bg = colors.bg_light1, style = 'NONE' },
		Title                             = { fg = colors.fn, style = 'bold' },
		Visual                            = { bg = colors.bg_visual },
		VisualNOS                         = { link = 'Visual' },
		WarningMsg                        = { fg = colors.diag.warning, bg = 'NONE' },
		Whitespace                        = { fg = colors.bg_light2 },
		WildMenu                          = { link = 'Pmenu' },

		Constant                          = { fg = colors.constant },
		String                            = { fg = colors.string },
		Character                         = { link = 'String' },
		Number                            = { fg = colors.number },
		Boolean                           = { fg = colors.constant, style = 'bold' },
		Float                             = { link = 'Number' },

		Identifier                        = { fg = colors.identifier },
		Function                          = { fg = colors.fn, style = config.function_style },
		Statement                         = { fg = colors.statement, style = config.statement_style },
		-- Conditional                    = {},
		-- Repeat                         = {},
		-- Label                          = {},
		Operator                          = { fg = colors.operator },
		Keyword                           = { fg = colors.keyword, style = config.keyword_style },
		Exception                         = { fg = colors.special2 },

		PreProc                           = { fg = colors.preproc },
		-- Include                        = {},
		-- Define                         = {},
		-- Macro                          = {},
		-- PreCondit                      = {},

		Type                              = { fg = colors.type, style = config.type_style },
		-- StorageClass                   = {},
		-- Structure                      = {},
		-- Typedef                        = {},

		Special                           = { fg = colors.special },
		-- SpecialChar                    = {},
		-- Tag                            = {},
		Delimiter                         = { fg = colors.delimiter },
		-- SpecialComment                 = {},
		-- Debug                          = {},

		Underlined                        = { fg = colors.special, style = 'underline' },
		Bold                              = { style = 'bold' },
		Italic                            = { style = 'italic' },

		Ignore                            = { link = 'NonText' },

		Error                             = { fg = colors.diag.error, bg = 'NONE' },
		Todo                              = { fg = colors.diag.info, bg = 'NONE', style = 'bold' },

		qfLineNr                          = { link = 'lineNr' },
		qfFileName                        = { link = 'Directory' },

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

		debugPC                           = { link = 'CursorLine' },
		debugBreakpoint                   = { fg = colors.special },

		LspReferenceText                  = { bg = colors.diff.text },
		LspReferenceRead                  = { link = 'LspReferenceText' },
		LspReferenceWrite                 = { link = 'LspReferenceText' },

		DiagnosticError                   = { fg = colors.diag.error },
		DiagnosticWarn                    = { fg = colors.diag.warning },
		DiagnosticInfo                    = { fg = colors.diag.info },
		DiagnosticHint                    = { fg = colors.diag.hint },

		DiagnosticSignError               = { link = 'DiagnosticError' },
		DiagnosticSignWarn                = { link = 'DiagnosticWarn' },
		DiagnosticSignInfo                = { link = 'DiagnosticInfo' },
		DiagnosticSignHint                = { link = 'DiagnosticHint' },

		DiagnosticVirtualTextError        = { link = 'DiagnosticError' },
		DiagnosticVirtualTextWarn         = { link = 'DiagnosticWarn' },
		DiagnosticVirtualTextInfo         = { link = 'DiagnosticInfo' },
		DiagnosticVirtualTextHint         = { link = 'DiagnosticHint' },

		DiagnosticUnderlineError          = { style = 'undercurl', guisp = colors.diag.error },
		DiagnosticUnderlineWarn           = { style = 'undercurl', guisp = colors.diag.warning },
		DiagnosticUnderlineInfo           = { style = 'undercurl', guisp = colors.diag.info },
		DiagnosticUnderlineHint           = { style = 'undercurl', guisp = colors.diag.hint },

		LspSignatureActiveParameter       = { fg = colors.diag.warning },
		LspCodeLens                       = { fg = colors.fg_comment },

		-- ['annotation']                 = {},
		['attribute']                     = { link = 'Constant' },
		-- ['boolean']                    = {},
		-- ['character']                  = {},
		-- ['character.special']          = {},
		-- ['comment']                    = {},
		['constructor']                   = { fg = colors.keyword }, -- Function/Special/Statement/Keyword
		-- ['conditional']                = {},
		-- ['constant']                   = {},
		-- ['constant.builtin']           = {},
		-- ['constant.macro']             = {},
		-- ['debug']                      = {},
		-- ['define']                     = {},
		['error']                         = { fg = colors.diag.error },
		['exception']                     = { fg = config.special_exception and colors.special3 or colors.statement, style = config.statement_style },
		['field']                         = { link = 'Identifier' }, -- default
		-- ['float']                      = {},
		-- ['function']                   = {},
		-- ['function.call']              = {},
		-- ['function.builtin']           = {link = 'Function' },
		-- ['function.macro']             = {},
		-- ['include']                    = {},
		['keyword']                       = { link = 'Keyword' },
		-- ['keyword.function']           = { link = 'Keyword' }, -- default
		['keyword.operator']              = { fg = colors.operator, style = 'bold' },
		['keyword.return']                = { fg = config.special_return and colors.special3 or colors.keyword, style = config.keyword_style },
		['label']                         = { link = 'Label' },
		['method']                        = { link = 'Function' },
		-- ['method.call']                = { link = 'Function' },
		-- ['namespace']                  = {},
		-- ['none']                       = {},
		-- ['number']                     = {},
		['operator']                      = { link = 'Operator' },
		['parameter']                     = { link = 'Identifier' }, -- default
		-- ['parameter.reference']        = {},
		-- ['preproc']                    = {},
		['property']                      = { link = 'Identifier' }, -- default
		['punctuation.delimiter']         = { fg = colors.delimiter },
		['punctuation.bracket']           = { fg = colors.delimiter },
		['punctuation.special']           = { fg = colors.delimiter },
		-- ['repeat']                     = {},
		-- ['storageclass']               = {},
		-- ['string']                     = {},
		['string.regex']                  = { fg = colors.regex },
		['string.escape']                 = { fg = colors.regex, style = 'bold' },
		-- ['string.special']             = {},
		-- ['symbol']                     = {},
		-- ['type']                       = {},
		-- ['type.builtin']               = {},
		-- ['type.qualifier']             = {},
		-- ['type.definition']            = {},
		['variable']                      = { fg = 'NONE' },
		['variable.builtin']              = { fg = colors.special2, style = config.variablebuiltin_style },

		-- ['tag']                        = {},
		-- ['tag.attribute']              = {},
		-- ['tag.delimiter']              = {},
		-- ['text']                       = {},
		-- ['text.strong']                = {},
		-- ['text.emphasis']              = {},
		-- ['text.underline']             = {},
		-- ['text.strike']                = {},
		-- ['text.title']                 = {},
		-- ['text.literal']               = {},
		-- ['text.uri']                   = {},
		-- ['text.math']                  = {},
		-- ['text.reference']             = { fg = colors.special2 },
		-- ['text.environment']           = {},
		-- ['text.environment.name']      = {},

		-- ['text.note']                  = { fg = colors.fg_dark, bg = colors.diag.hint, style = 'nocombine,bold'}, -- links to SpecialComment -> Special
		['text.warning']                  = { link = 'Todo' }, -- default
		['text.danger']                   = { link = 'WarningMsg' }, -- default
		-- ['text.todo']                  = {},

		-- Lua
		-- luaTSProperty                  = {},

		-- LspTrouble
		-- LspTroubleText                 = {},
		-- LspTroubleCount                = {},
		-- LspTroubleNormal               = {},

		-- Illuminate
		-- illuminatedWord                = {},
		-- illuminatedCurWord             = {},

		-- Git
		diffAdded                         = { fg = colors.git.added, bg = m.alter(colors.git.added, -70) },
		diffRemoved                       = { fg = colors.git.removed, bg = m.alter(colors.git.removed, -70) },
		diffDeleted                       = { fg = colors.git.removed, bg = m.alter(colors.git.removed, -70) },
		diffChanged                       = { fg = colors.git.changed },
		diffOldFile                       = { fg = colors.git.removed },
		diffNewFile                       = { fg = colors.git.added },
		-- diffFile                       = { fg = colors.gray },
		-- diffLine                       = { fg = colors.ray },
		-- diffIndexLine                  = { link = 'Identifier' },

		-- Neogit
		NeogitBranch                      = { fg = colors.constant },
		NeogitRemote                      = { fg = colors.type },
		NeogitHunkHeader                  = { bg = colors.bg_dim },
		NeogitHunkHeaderHighlight         = { bg = colors.bg_dim },
		NeogitDiffContextHighlight        = { bg = colors.bg_dark, fg = colors.fg_dark },
		NeogitDiffDeleteHighlight         = { fg = m.alter(colors.git.removed, -5), bg = m.alter(colors.git.removed, -65) },
		NeogitDiffAddHighlight            = { fg = m.alter(colors.git.added, -5), bg = m.alter(colors.git.added, -65) },

		-- GitGutter
		-- GitGutterAdd                   = {},
		-- GitGutterChange                = {},
		-- GitGutterDelete                = {},

		-- GitSigns
		GitSignsAdd                       = { fg = colors.git.added },
		GitSignsChange                    = { fg = colors.git.changed },
		GitSignsDelete                    = { fg = colors.git.removed },
		GitSignsDeleteLn                  = { fg = 'NONE', bg = colors.diff.delete },

		-- Telescope                      = {},
		TelescopeBorder                   = { link = 'FloatBorder' },
		TelescopeNormal                   = { link = 'NormalNC' },

		-- NvimTree                       = {},
		NvimTreeNormal                    = { link = 'NormalSB' },
		NvimTreeNormalNC                  = { link = 'NormalSB' },
		NvimTreeRootFolder                = { fg = colors.identifier, style = 'bold' },
		NvimTreeGitDirty                  = { fg = colors.git.changed },
		NvimTreeGitNew                    = { fg = colors.git.added },
		NvimTreeGitDeleted                = { fg = colors.git.removed },
		NvimTreeSpecialFile               = { fg = colors.special },
		-- NvimTreeIndentMarker           = {},
		NvimTreeImageFile                 = { fg = colors.special2 },
		NvimTreeSymlink                   = { link = 'Type' },
		NvimTreeFolderName                = { link = 'Directory' },
		NvimTreeExecFile                  = { fg = colors.operator, style = 'bold' },
		NvimTreeGitStaged                 = { fg = colors.git.added },
		NvimTreeOpenedFile                = { fg = colors.special, style = 'italic' },

		-- NeoTree
		-- the buffer number shown in the buffers source.
		NeoTreeBufferNumber               = { fg = colors.constant },

		-- -- |hl-CursorLine| override in neo-tree window.
		-- NeoTreeCursorLine              = {},

		-- greyed out text used in various places.
		NeoTreeDimText                    = { link = 'NormalNC' },

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
		NeoTreeFloatBorder                = { link = 'FloatBorder' },

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
		NeoTreeIndentMarker               = { fg = colors.bg_light1 },

		-- used for collapsed/expanded icons.
		NeoTreeExpander                   = config.darken_sidebar and { fg = colors.fg_dark } or { fg = colors.fg },

		-- |hl-Normal| override in neo-tree window.
		NeoTreeNormal                     = { link = 'NormalSB' },

		-- |hl-NormalNC| override in neo-tree window.
		NeoTreeNormalNC                   = { link = 'NormalSB' },

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

		-- Fern
		-- FernBranchText                 = {},

		-- glyph palette                  = {},
		-- GlyphPalette1                  = {},
		-- GlyphPalette2                  = {},
		-- GlyphPalette3                  = {},
		-- GlyphPalette4                  = {},
		-- GlyphPalette6                  = {},
		-- GlyphPalette7                  = {},
		-- GlyphPalette9                  = {},

		-- Dashboard
		DashboardShortCut                 = { fg = colors.special },
		DashboardHeader                   = { fg = colors.git.removed },
		DashboardCenter                   = { fg = colors.identifier },
		DashboardFooter                   = { fg = colors.fn },

		-- WhichKey                       = {},
		-- WhichKeyGroup                  = {},
		-- WhichKeyDesc                   = {},
		-- WhichKeySeperator              = {},
		-- WhichKeySeparator              = {},
		-- WhichKeyFloat                  = {},
		-- WhichKeyValue                  = {},

		-- LspSaga
		-- DiagnosticWarning              = {},
		-- DiagnosticInformation          = {},

		-- LspFloatWinNormal              = {},
		-- LspFloatWinBorder              = {},
		-- LspSagaBorderTitle             = {},
		-- LspSagaHoverBorder             = {},
		-- LspSagaRenameBorder            = {},
		-- LspSagaDefPreviewBorder        = {},
		-- LspSagaCodeActionBorder        = {},
		-- LspSagaFinderSelection         = {},
		-- LspSagaCodeActionTitle         = {},
		-- LspSagaCodeActionContent       = {},
		-- LspSagaSignatureHelpBorder     = {},
		-- ReferencesCount                = {},
		-- DefinitionCount                = {},
		-- DefinitionIcon                 = {},
		-- ReferencesIcon                 = {},
		-- TargetWord                     = {},

		-- Floaterm
		FloatermBorder                    = { fg = colors.bg_light3 },

		-- NeoVim                         = {},
		healthError                       = { fg = colors.diag.error },
		healthSuccess                     = { fg = colors.diag.hint },
		healthWarning                     = { fg = colors.diag.warning },

		-- BufferLine
		-- BufferLineIndicatorSelected    = {},
		-- BufferLineFill                 = {},

		-- Barbar                         = {},
		-- BufferCurrent                  = {},
		-- BufferCurrentIndex             = {},
		-- BufferCurrentMod               = {},
		-- BufferCurrentSign              = {},
		-- BufferCurrentTarget            = {},
		-- BufferVisible                  = {},
		-- BufferVisibleIndex             = {},
		-- BufferVisibleMod               = {},
		-- BufferVisibleSign              = {},
		-- BufferVisibleTarget            = {},
		-- BufferInactive                 = {},
		-- BufferInactiveIndex            = {},
		-- BufferInactiveMod              = {},
		-- BufferInactiveSign             = {},
		-- BufferInactiveTarget           = {},
		-- BufferTabpages                 = {},
		-- BufferTabpage                  = {},

		-- Sneak
		-- Sneak                          = {},
		-- SneakScope                     = {},

		-- Hop
		-- HopNextKey                     = {},
		-- HopNextKey1                    = {},
		-- HopNextKey2                    = {},
		-- HopUnmatched                   = {},

		-- -- Lightspeed
		-- LightspeedLabel                   = { fg = colors.number, style = 'bold,underline' },
		-- LightspeedLabelDistant            = { fg = colors.string, style = 'bold,underline' },
		-- LightspeedLabelDistantOverlapped  = { fg = colors.string, style = 'underline' },
		-- LightspeedLabelOverlapped         = { fg = colors.number, style = 'underline' },
		-- LightspeedMaskedChar              = { bg = colors.identifier },
		-- LightspeedOneCharMatch            = { bg = colors.number, fg = colors.fg, style = 'bold' },
		-- LightspeedPendingOpArea           = { bg = colors.number, fg = colors.fg },
		-- LightspeedShortcut                = { bg = colors.number, fg = colors.fg, style = 'bold,underline' },
		-- LightspeedUnlabeledMatch          = { fg = colors.type, style = 'bold' },
		-- -- LightspeedGreyWash             = { link = 'Comment' },

		-- Leap
		LeapMatch                         = { fg = colors.fg, bg = colors.number, style = 'bold' },
		LeapLabelPrimary                  = { fg = colors.fg, bg = colors.number, style = 'bold' },
		LeapLabelSecondary                = { fg = colors.type, style = 'bold' },
		LeapBackdrop                      = { fg = colors.fg_comment, style = 'italic' },

		-- Cmp
		CmpDocumentation                  = { fg = colors.fg, bg = colors.bg_popup },
		CmpDocumentationBorder            = { fg = colors.fg_border, bg = 'NONE' },

		CmpItemAbbr                       = { fg = colors.fg, bg = 'NONE' },
		CmpItemAbbrDeprecated             = { fg = colors.fg_comment, bg = 'NONE', style = 'strikethrough' },

		CmpItemAbbrMatch                  = { fg = colors.fn, bg = 'NONE' },
		CmpItemAbbrMatchFuzzy             = { link = 'CmpItemAbbrMatch' },

		CmpItemKindDefault                = { fg = colors.fg_comment, bg = 'NONE' },
		CmpItemMenu                       = { fg = colors.fg_comment, bg = 'NONE' },

		CmpItemKindVariable               = { fg = colors.fg_dark, bg = 'NONE' },

		CmpItemKindFunction               = { link = 'Function' },
		CmpItemKindMethod                 = { link = 'Function' },

		CmpItemKindConstructor            = { link = 'TSConstructor' },

		CmpItemKindClass                  = { link = 'Type' },
		CmpItemKindInterface              = { link = 'Type' },
		CmpItemKindStruct                 = { link = 'Type' },

		CmpItemKindProperty               = { link = 'TSProperty' },
		CmpItemKindField                  = { link = 'TSField' },
		CmpItemKindEnum                   = { link = 'Identifier' },

		CmpItemKindSnippet                = { fg = colors.special, bg = 'NONE' },

		CmpItemKindText                   = { link = 'TSText' },

		CmpItemKindModule                 = { link = 'TSInclude' },

		CmpItemKindFile                   = { link = 'Directory' },
		CmpItemKindFolder                 = { link = 'Directory' },

		CmpItemKindKeyword                = { link = 'TSKeyword' },
		CmpItemKindTypeParameter          = { link = 'Identifier' },
		CmpItemKindConstant               = { link = 'Constant' },
		CmpItemKindOperator               = { link = 'Operator' },
		CmpItemKindReference              = { link = 'TSParameterReference' },
		CmpItemKindEnumMember             = { link = 'TSField' },

		CmpItemKindValue                  = { link = 'String' },
		-- CmpItemKindUnit                = {},
		-- CmpItemKindEvent               = {},
		-- CmpItemKindColor               = {},

		-- IndentBlankline
		IndentBlanklineChar               = { fg = colors.bg_light1 },
		IndentBlanklineSpaceChar          = { fg = colors.bg_light1 },
		IndentBlanklineSpaceCharBlankline = { fg = colors.bg_light1 },
		IndentBlanklineContextChar        = { fg = colors.bg_light3 },
		IndentBlanklineContextStart       = { guisp = colors.bg_light3, style = 'underline' },

		-- SymbolsOutline
		FocusedSymbol                     = { fg = colors.identifier },
		-- SymbolsOutlineConnector        = {},


		-- TroubleNvim
		TroubleNormal                     = { link = 'NormalSB' },
		-- TroubleCount                   = {},
		-- TroubleError                   = {},
		-- TroubleTextInformation         = {},
		-- TroubleSignWarning             = {},
		-- TroubleLocation                = {},
		-- TroubleWarning                 = {},
		-- TroublePreview                 = {},
		-- TroubleTextError               = {},
		-- TroubleSignInformation         = {},
		-- TroubleIndent                  = {},
		-- TroubleSource                  = {},
		-- TroubleSignHint                = {},
		-- TroubleSignOther               = {},
		-- TroubleFoldIcon                = {},
		-- TroubleTextWarning             = {},
		-- TroubleCode                    = {},
		-- TroubleInformation             = {},
		-- TroubleSignError               = {},
		-- TroubleFile                    = {},
		-- TroubleHint                    = {},
		-- TroubleTextHint                = {},
		-- TroubleText                    = {},
	}

	f.iterate(config.overrides)
		 :foreach(function( hl, specs)
		    if hlgroups[hl] and not tie(specs) then
		       hlgroups[hl].link = nil
		    end

		    hlgroups[hl] = tde('force', hlgroups[hl] or {}, specs)
		 end)

	return hlgroups
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

	assert(has_colors, sf(
		'invalid parameter #1 to "load": "%s" colorscheme not found',
		colorscheme
	))

	current_colorscheme = colors

	if vim.g.colors_name then
		m.clear_hl()
	end

	if vim.fn.exists('syntax_on') then
		vim.cmd.syntax('reset')
	end

	vim.g.colors_name   = colorscheme
	vim.o.termguicolors = true

	config = config or default_config()

	local effective_colors = generate_colors(colors, config)
	local highlight_groups = generate_highlights(effective_colors, config)

	apply_highlight_groups(highlight_groups)
	dim_on_focus_lost(config)
end

return m
