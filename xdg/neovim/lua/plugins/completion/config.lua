-- localize globals {{{1

local vapi = vim.api
local vfn  = vim.fn
local ssub = string.sub
local t    = scheatkode.replace_termcodes

local log = require('log')

-- check for plugin existence {{{1

local has_completion, completion = pcall(require, 'cmp')
local has_snippets,   snippets   = pcall(require, 'luasnip')

if not has_completion or not has_snippets then
   log.error('Tried loading plugin ... unsuccessfully ‼', 'nvim-cmp')
   return has_completion
end

local has_words_before = function ()
   local line, column = unpack(vapi.nvim_win_get_cursor(0))

   return column ~= 0
      and vapi.nvim_buf_get_lines(0, line - 1, line, true)[1]
         :sub(column, column)
         :match("%s") == nil
end

-- configure plugin {{{1

local sources = {
    luasnip = '[snip]',
       calc = '[calc]',
    cmdline = '[cmd]',
   nvim_lsp = '[lsp]',
   nvim_lua = '[api]',
       path = '[path]',
}

local maxwidth = 50

local borders = {
    '╭',
    '─',
    '╮',
    '│',
    '╯',
    '─',
    '╰',
    '│',
}

completion.setup({
   window = {
      completion = {
         border    = borders,
      },

      documentation = {
         border    = borders,
      },
   },

   formatting = {
      format = function (entry, item)
         item.kind = require('meta.icon.lsp').presets.default[item.kind]
         item.menu = sources[entry.source.name]
         item.abbr = ssub(item.abbr, 1, maxwidth)

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
          ['<C-b>'] = completion.mapping(completion.mapping.scroll_docs(-4), {'i', 'c'}),
          ['<C-f>'] = completion.mapping(completion.mapping.scroll_docs(4),  {'i', 'c'}),

      ['<C-e>'] = completion.mapping({
         i = completion.mapping.abort(),
         c = completion.mapping.close(),
      }),

      ['<CR>'] = completion.mapping.confirm {
         behavior = completion.ConfirmBehavior.Replace,
           select = true,
      },

      ['<Tab>'] = completion.mapping(function (fallback)
         if completion.visible() then
            completion.select_next_item()
         elseif snippets.expand_or_jumpable() then
            vfn.feedkeys(t('<Plug>luasnip-expand-or-jump'), '')
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
            vfn.feedkeys(t('<Plug>luasnip-jump-prev'), '')
         else
            fallback()
         end
      end, {'i', 's'})
   },

   sources = completion.config.sources({
      { name = 'luasnip'  },
      { name = 'calc'     },
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'path'     },
   }),

   experimental = {
      ghost_text = true,
   }
})

-- TODO(scheatkode): Refactor this

local h = require('scheatkode.highlight')

h.set_hl('CmpItemMenu', {
   link = 'NonText',
   force = true,
})

h.set_hl('CmpItemKind', {
   link = 'Special',
   force = true,
})

h.set_hl('CmpItemAbbrDeprecated', {
   link = 'Error',
   force = true,
})

log.info('Plugin loaded', 'nvim-cmp')

return true

-- vim: set fdm=marker fdl=0:

