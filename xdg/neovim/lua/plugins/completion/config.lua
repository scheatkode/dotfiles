-- localize globals {{{1

local api = vim.api
local fn  = vim.fn
local t   = scheatkode.replace_termcodes

local log = require('log')

-- check for plugin existence {{{1

local has_completion, completion = pcall(require, 'cmp')
local has_snippets,   snippets   = pcall(require, 'luasnip')

if not has_completion and not has_snippets then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'nvim-cmp')
   return has_completion
end

local has_words_before = function ()
   local line, column = unpack(api.nvim_win_get_cursor(0))

   return column ~= 0
      and api.nvim_buf_get_lines(0, line - 1, line, true)[1]
         :sub(column, column)
         :match("%s") == nil
end

-- configure plugin {{{1

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

      ['<Tab>'] = completion.mapping(function (fallback)
         if completion.visible() then
            completion.select_next_item()
         elseif snippets.expand_or_jumpable() then
            fn.feedkeys(t('<Plug>luasnip-expand-or-jump'), '')
         elseif has_words_before() then
            completion.complete()
         else
            fallback()
         end
      end, {'i', 's'}),

      ['<S-Tab>'] = completion.mapping(function (fallback)
         if completion.visible() then
            completion.select_prev_item()
         elseif snippets.jumpable(-1) then
            fn.feedkeys(t('<Plug>luasnip-jump-prev'), '')
         else
            fallback()
         end
      end, {'i', 's'})
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

