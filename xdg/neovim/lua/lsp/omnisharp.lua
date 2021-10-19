local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
   print('‼ Tried loading lspconfig for omnisharp ... unsuccessfully.')
   return has_lspconfig
end

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

   init_options = {
      FormattingOptions = {
         EnableEditorConfigSupport = true,
         OrganizeImports = true,
         NewLine = '\n',
         UseTabs = false,
         TabSize = 3,
         IndentationSize = 3,
         SpacingAfterMethodDeclarationName = true,
         SpaceWithinMethodDeclarationParenthesis = false,
         SpaceBetweenEmptyMethodDeclarationParentheses = false,
         SpaceAfterMethodCallName = false,
         SpaceWithinMethodCallParentheses = false,
         SpaceBetweenEmptyMethodCallParentheses = false,
         SpaceAfterControlFlowStatementKeyword = true,
         SpaceWithinExpressionParentheses = false,
         SpaceWithinCastParentheses = false,
         SpaceWithinOtherParentheses = false,
         SpaceAfterCast = true,
         SpacesIgnoreAroundVariableDeclaration = false,
         SpaceBeforeOpenSquareBracket = false,
         SpaceBetweenEmptySquareBrackets = false,
         SpaceWithinSquareBrackets = true,
         SpaceAfterColonInBaseTypeDeclaration = true,
         SpaceAfterComma = true,
         SpaceAfterDot = false,
         SpaceAfterSemicolonsInForStatement = true,
         SpaceBeforeColonInBaseTypeDeclaration = true,
         SpaceBeforeComma = false,
         SpaceBeforeDot = false,
         SpaceBeforeSemicolonsInForStatement = false,
         SpacingAroundBinaryOperator = 'single',
         IndentBraces = false,
         IndentBlock = true,
         IndentSwitchSection = true,
         IndentSwitchCaseSection = true,
         IndentSwitchCaseSectionWhenBlock = true,
         LabelPositioning = 'oneLess',
         WrappingPreserveSingleLine = true,
         WrappingKeepStatementsOnSingleLine = true,
         NewLinesForBracesInTypes = true,
         NewLinesForBracesInMethods = true,
         NewLinesForBracesInProperties = true,
         NewLinesForBracesInAccessors = true,
         NewLinesForBracesInAnonymousMethods = true,
         NewLinesForBracesInControlBlocks = true,
         NewLinesForBracesInAnonymousTypes = true,
         NewLinesForBracesInObjectCollectionArrayInitializers = true,
         NewLinesForBracesInLambdaExpressionBody = true,
         NewLineForElse = true,
         NewLineForCatch = true,
         NewLineForFinally = true,
         NewLineForMembersInObjectInit = true,
         NewLineForMembersInAnonymousTypes = true,
         NewLineForClausesInQuery = true,
      }
   },

   root_dir = lspconfig.util.root_pattern('**/*.sln')
           or lspconfig.util.root_pattern('**/*.csproj')
           or lspconfig.util.root_pattern('.git'),
}
