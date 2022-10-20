local deep_extend = require('tablex.deep_extend')
local is_list = require('tablex.is_list')

local has_lspconfig, _ = pcall(require, 'lspconfig')

if not has_lspconfig then
	print('‼ Tried loading lspconfig for omnisharp ... unsuccessfully.')
	return has_lspconfig
end

--- Recursively flatten a table.
---
--- @param acc table Accumulator of flattened keys
--- @param sep string Separator to use for keys
--- @param key string Current key
--- @param value any Current value
--- @return table _ flattened table
local function flatten(acc, sep, key, value)
	if type(value) ~= 'table' then
		acc[key] = value
		return acc
	end

	if is_list(value) then
		for i = 1, #value do
			flatten(
				acc,
				':',
				string.format('%s%s%s', key, sep, i - 1),
				value[i]
			)
		end

		return acc
	end

	for k, v in pairs(value) do
		flatten(
			acc,
			':',
			string.format('%s%s%s', key, sep, k),
			v
		)
	end

	return acc
end

--- OmniSharp's settings as a table
---
--- Using  a function's  return  value  as a  temporary
--- variable to  avoid the  table lingering  around the
--- memory after  its use,  when the  garbage collector
--- sweeps for unreferenced objects.
---
--- @return table _ OmniSharp settings table
local function omnisharp_settings()
	return {
		useModernNet = true,

		formattingOptions = {
			enableEditorConfigSupport = true,
			indentBlock = true,
			indentBraces = false,
			indentSwitchCaseSection = true,
			indentSwitchCaseSectionWhenBlock = true,
			indentSwitchSection = true,
			indentationSize = 3,
			labelPositioning = 'oneLess',
			newLine = '\n',
			newLineForCatch = true,
			newLineForClausesInQuery = true,
			newLineForElse = false,
			newLineForFinally = true,
			newLineForMembersInAnonymousTypes = true,
			newLineForMembersInObjectInit = true,
			newLinesForBracesInAccessors = true,
			newLinesForBracesInAnonymousMethods = false,
			newLinesForBracesInAnonymousTypes = false,
			newLinesForBracesInControlBlocks = false,
			newLinesForBracesInLambdaExpressionBody = false,
			newLinesForBracesInMethods = true,
			newLinesForBracesInObjectCollectionArrayInitializers = true,
			newLinesForBracesInProperties = true,
			newLinesForBracesInTypes = true,
			organizeImports = true,
			spaceAfterCast = true,
			spaceAfterColonInBaseTypeDeclaration = true,
			spaceAfterComma = true,
			spaceAfterControlFlowStatementKeyword = true,
			spaceAfterDot = false,
			spaceAfterMethodCallName = false,
			spaceAfterSemicolonsInForStatement = true,
			spaceBeforeColonInBaseTypeDeclaration = true,
			spaceBeforeComma = false,
			spaceBeforeDot = false,
			spaceBeforeOpenSquareBracket = false,
			spaceBeforeSemicolonsInForStatement = false,
			spaceBetweenEmptyMethodCallParentheses = false,
			spaceBetweenEmptyMethodDeclarationParentheses = false,
			spaceBetweenEmptySquareBrackets = false,
			spaceWithinCastParentheses = false,
			spaceWithinExpressionParentheses = false,
			spaceWithinMethodCallParentheses = false,
			spaceWithinMethodDeclarationParenthesis = false,
			spaceWithinOtherParentheses = false,
			spaceWithinSquareBrackets = true,
			spacesIgnoreAroundVariableDeclaration = false,
			spacingAfterMethodDeclarationName = true,
			spacingAroundBinaryOperator = 'single',
			tabSize = 3,
			useTabs = false,
			wrappingKeepStatementsOnSingleLine = true,
			wrappingPreserveSingleLine = true,
		},

		roslynExtensionsOptions = {
			documentAnalysisTimeoutMs  = 10000,
			enableAnalyzersSupport     = true,
			enableDecompilationSupport = true,
			enableImportCompletion     = true,
		},
	}
end

--- Make the full environment to pass to OmniSharp.
---
--- @return table _ Flattened environment table for OmniSharp.
local function make_environment()
	local settings = flatten({}, '_', 'OMNISHARP', omnisharp_settings())
	local home_env = {
		OMNISHARPHOME = vim.fn.expand('$XDG_DATA_HOME') .. '/omnisharp'
	}

	return deep_extend('keep', settings, home_env)
end

return {
	filetypes = {
		'cs',
		'vb'
	},

	cmd_env = make_environment()
}
