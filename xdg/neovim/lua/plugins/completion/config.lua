-- localize globals {{{1

local fn = vim.fn
local t  = scheatkode.replace_termcodes

local log = require('log')

-- check for plugin existence {{{1

local has_completion, completion = pcall(require, 'cmp')
local has_snippets,   snippets   = pcall(require, 'luasnip')

if not has_completion and not has_snippets then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'nvim-completion')
   return has_completion
end

-- configure plugin {{{1

local check_backspace = function ()
   local column = vim.fn.col('.') - 1
   return column == 0 or vim.fn.getline('.'):sub(column, column):match('%s')
end

completion.setup {
   formatting = {
      format = function (_, item)
         item.kind = require('meta.icon.lsp').presets.default[item.kind]

         return item
      end,
   },

   snippet = {
      expand = function (arguments)
         require('luasnip').lsp_expand(arguments.body)
      end,
   },

   mapping = {
          ['<C-p>'] = completion.mapping.select_prev_item(),
          ['<C-n>'] = completion.mapping.select_next_item(),
          ['<C-d>'] = completion.mapping.scroll_docs(-4),
          ['<C-f>'] = completion.mapping.scroll_docs(4),
      ['<C-Space>'] = completion.mapping.complete(),
          ['<C-e>'] = completion.mapping.close(),

      ['<CR>'] = completion.mapping.confirm {
         behavior = completion.ConfirmBehavior.Replace,
           select = true,
      },

      ['<Tab>'] = function (fallback)
         if fn.pumvisible() == 1 then
            fn.feedkeys(t('<C-n>'), 'n')
         elseif snippets.expand_or_jumpable() then
            fn.feedkeys(t('<Plug>luasnip-expand-or-jump'), '')
         elseif check_backspace() then
            fn.feedkeys(t('<Tab>'), 'n')
         else
            fallback()
         end
      end,

      ['<S-Tab>'] = function (fallback)
         if fn.pumvisible() == 1 then
            fn.feedkeys(t('<C-p>'), 'n')
         elseif snippets.jumpable(-1) then
            fn.feedkeys(t('<Plug>luasnip-jump-prev'), '')
         else
            fallback()
         end
      end,
   },

   sources = {
      { name = 'luasnip'  },
      { name = 'nvim_lsp' },
      { name = 'path'     },
      { name = 'buffer'   },
   },
}

log.info('Plugin loaded', 'nvim-cmp')

return true

-- vim: set fdm=marker fdl=0:
