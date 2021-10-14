local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then
   print('‼ Tried loading lspconfig for omnisharp ... unsuccessfully.')
   return has_lspconfig
end

-- TODO(scheatkode): DRY this

local has_whichkey, whichkey = pcall(require, 'which-key')
local register_keymap = require('util').register_single_keymap
local has_saga = false

local normalize_keymaps = function (mappings)
   for _, mapping in ipairs(mappings) do
      local mode         = mapping.mode
      local keys         = mapping.keys
      local description  = mapping.description
      local command      = mapping.command
      local command_saga = mapping.command_saga
      local condition    = mapping.condition
      local options      = mapping.options

      if
             has_saga
         and command_saga ~= nil
      then
         command = command_saga
      end

      if
             command   ~= nil
         and command   ~= ''
         and command   ~= false
         and condition ~= nil
         and condition ~= false
      then
         register_keymap {
            mode    = mode,
            keys    = keys,
            command = command,
            options = options,
         }

         if has_whichkey then
            whichkey.register({
               [keys] = description
            }, {
               mode   = mode,
               buffer = options.buffer
            })
         end
      end
   end
end


return {
   cmd = {
      vim.fn.expand('~/.local/share/nvim/lspinstall/csharp/omnisharp/run'),
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

   -- settings = {
   --    FormattingOptions = {
   --       EnableEditorConfigSupport = true,
   --       OrganizeImports = true,
   --       NewLine = '\n',
   --       UseTabs = false,
   --       TabSize = 3,
   --       IndentationSize = 3,
   --       SpacingAfterMethodDeclarationName = true,
   --       SpaceWithinMethodDeclarationParenthesis = false,
   --       SpaceBetweenEmptyMethodDeclarationParentheses = false,
   --       SpaceAfterMethodCallName = false,
   --       SpaceWithinMethodCallParentheses = false,
   --       SpaceBetweenEmptyMethodCallParentheses = false,
   --       SpaceAfterControlFlowStatementKeyword = true,
   --       SpaceWithinExpressionParentheses = false,
   --       SpaceWithinCastParentheses = false,
   --       SpaceWithinOtherParentheses = false,
   --       SpaceAfterCast = true,
   --       SpacesIgnoreAroundVariableDeclaration = false,
   --       SpaceBeforeOpenSquareBracket = false,
   --       SpaceBetweenEmptySquareBrackets = false,
   --       SpaceWithinSquareBrackets = true,
   --       SpaceAfterColonInBaseTypeDeclaration = true,
   --       SpaceAfterComma = true,
   --       SpaceAfterDot = false,
   --       SpaceAfterSemicolonsInForStatement = true,
   --       SpaceBeforeColonInBaseTypeDeclaration = true,
   --       SpaceBeforeComma = false,
   --       SpaceBeforeDot = false,
   --       SpaceBeforeSemicolonsInForStatement = false,
   --       SpacingAroundBinaryOperator = 'single',
   --       IndentBraces = false,
   --       IndentBlock = true,
   --       IndentSwitchSection = true,
   --       IndentSwitchCaseSection = true,
   --       IndentSwitchCaseSectionWhenBlock = true,
   --       LabelPositioning = 'oneLess',
   --       WrappingPreserveSingleLine = true,
   --       WrappingKeepStatementsOnSingleLine = true,
   --       NewLinesForBracesInTypes = true,
   --       NewLinesForBracesInMethods = true,
   --       NewLinesForBracesInProperties = true,
   --       NewLinesForBracesInAccessors = true,
   --       NewLinesForBracesInAnonymousMethods = true,
   --       NewLinesForBracesInControlBlocks = true,
   --       NewLinesForBracesInAnonymousTypes = true,
   --       NewLinesForBracesInObjectCollectionArrayInitializers = true,
   --       NewLinesForBracesInLambdaExpressionBody = true,
   --       NewLineForElse = true,
   --       NewLineForCatch = true,
   --       NewLineForFinally = true,
   --       NewLineForMembersInObjectInit = true,
   --       NewLineForMembersInAnonymousTypes = true,
   --       NewLineForClausesInQuery = true,
   --    }
   -- },

   root_dir = lspconfig.util.root_pattern('**/*.sln')
           or lspconfig.util.root_pattern('**/*.csproj')
           or lspconfig.util.root_pattern('.git'),

   post_attach = function (client, bufnr)
      vim.g.format_options_csharp = {
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
      }

      normalize_keymaps {
         {
            mode         = 'n',
            keys         = '<leader>cf',
            description  = 'Format code',
            -- command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_csharp)<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_uncrustify)<CR>',
            command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
            command_saga = nil,
            condition    = client.resolved_capabilities.document_formatting
               or client.resolved_capabilities.document_range_formatting,
            options      = { buffer = bufnr },
         },

         {
            mode         = 'n',
            keys         = '<leader>=',
            description  = 'Format code',
            -- command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_csharp)<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_uncrustify)<CR>',
            command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
            command_saga = nil,
            condition    = client.resolved_capabilities.document_formatting
               or client.resolved_capabilities.document_range_formatting,
            options      = { buffer = bufnr },
         },

         {
            mode         = 'x',
            keys         = '<leader>cf',
            description  = 'Format code',
            -- command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_csharp)<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_uncrustify)<CR>',
            command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
            command_saga = nil,
            condition    = client.resolved_capabilities.document_formatting
               or client.resolved_capabilities.document_range_formatting,
            options      = { buffer = bufnr },
         },

         {
            mode         = 'x',
            keys         = '<leader>=',
            description  = 'Format code',
            -- command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_csharp)<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.formatting(vim.g.format_options_uncrustify)<CR>',
            command      = '<cmd>lua vim.lsp.buf.formatting()<CR>',
            -- command      = '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
            command_saga = nil,
            condition    = client.resolved_capabilities.document_formatting
               or client.resolved_capabilities.document_range_formatting,
            options      = { buffer = bufnr },
         },
      }

   end,
}
