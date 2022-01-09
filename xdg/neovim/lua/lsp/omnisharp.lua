local f = require('f')

local has_lspconfig, _ = pcall(require, 'lspconfig')

if not has_lspconfig then
   print('‼ Tried loading lspconfig for omnisharp ... unsuccessfully.')
   return has_lspconfig
end

local function omnisharp_options_to_env(t)
   local env = {}

   f.iterate(t):foreach(function (namespace, values)
      f.iterate(values):foreach(function (key, value)
         env[string.format('OMNISHARP_%s:%s', namespace, key)] = value
      end)
   end)

   return env
end

local omnisharp_env = {
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

return {
   cmd = {
      vim.fn.stdpath('data') .. '/lsp_servers/omnisharp/omnisharp/run',
      '--languageserver',
      '--hostPID', tostring(vim.fn.getpid())
   },

   filetypes = {
      'cs',
      'vb'
   },

   cmd_env = omnisharp_options_to_env(omnisharp_env),

   -- root_dir = lspconfig.util.root_pattern('**/*.sln')
   --         or lspconfig.util.root_pattern('**/*.csproj')
   --         or lspconfig.util.root_pattern('.git'),
}
