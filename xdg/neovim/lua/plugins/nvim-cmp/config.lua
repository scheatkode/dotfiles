return {
	setup = function(overrides)
		local log      = require('log')
		local constant = require('f.function.constant')
		local extend   = require('tablex.deep_extend')
		local unpack   = require('compat.table.unpack')

		local defaults = {
			icons    = require('meta.icon.lsp').presets.default,
			maxwidth = 50,
			sources  = {
				nvim_lsp = '[lsp]',
				luasnip  = '[snip]',
				path     = '[path]',
			},
		}

		local options = extend('force', defaults, overrides or {})

		--- Localization and memoization

		-- These functions are spammed enough times already to
		-- warrant the small performance increase of localizing
		-- them.
		local nvim_win_get_cursor = vim.api.nvim_win_get_cursor
		local nvim_buf_get_lines  = vim.api.nvim_buf_get_lines

		-- Check for plugin existence
		local has_completion, completion = pcall(require, 'cmp')
		local has_snippets, snippets     = pcall(require, 'luasnip')

		if not has_completion or not has_snippets then
			log.error('Tried loading plugin ... unsuccessfully ‼', 'nvim-cmp')
			return has_completion
		end

		if not has_snippets then
			log.warn('Snippets plugin not found', 'luasnip')

			-- Coerce used snippets functions to keep using the completion
			-- engine yet avoid errors when snippets are not available.
			snippets = {
				expand_or_locally_jumpable = constant(false),
				expand_or_jumpable         = constant(false),
				jumpable                   = constant(false),
			}
		end

		local function has_words_before()
			local line, column = unpack(nvim_win_get_cursor(0))

			return column ~= 0
				 and nvim_buf_get_lines(0, line - 1, line, true)[1]
				 :sub(column, column)
				 :match('%s')
				 == nil
		end

		-- Not sure about other people, but autocompletion is broken in my
		-- case. Honestly too buggy to be usable.
		-- If it weren't for the nice windows, colocated multiple sources,
		-- and the quick doc, I'd have simply used the `omnifunc` provided
		-- by `vim.lsp`. I already use the builtin `ins-completion` for
		-- other stuff and avoid `cmp-buffer` as well as `cmp-cmdline`
		-- like the plague.
		completion.setup({
			completion = {
				autocomplete = false,
			},

			window = {
				completion = {
					border = options.borders,
				},

				documentation = {
					border = options.borders,
				},
			},

			formatting = {
				format = function(entry, item)
					item.kind = options.icons[item.kind]
					item.menu = options.sources[entry.source.name]
					item.abbr = item.abbr:sub(1, options.maxwidth)

					return item
				end,
			},

			snippet = {
				expand = function(arguments)
					snippets.lsp_expand(arguments.body)
				end,
			},

			mapping = {
				['<C-x><C-x>'] = completion.mapping.complete(),
				['<C-x><C-o>'] = completion.mapping.complete(),

				['<C-p>'] = completion.mapping.select_prev_item(),
				['<C-n>'] = completion.mapping.select_next_item(),
				['<C-b>'] = completion.mapping(completion.mapping.scroll_docs(-4), { 'i' }),
				['<C-f>'] = completion.mapping(completion.mapping.scroll_docs(4), { 'i' }),

				['<C-e>'] = completion.mapping({
					i = completion.mapping.abort(),
					c = completion.mapping.close(),
				}),

				['<CR>'] = completion.mapping.confirm({
					behavior = completion.ConfirmBehavior.Replace,
					select   = true,
				}),

				['<C-y>'] = completion.mapping.confirm({
					behavior = completion.ConfirmBehavior.Replace,
					select   = true,
				}),

				['<Tab>'] = completion.mapping(function(fallback)
					if completion.visible() then
						completion.select_next_item()
					elseif snippets.expand_or_locally_jumpable() then
						snippets.expand_or_jump()
					elseif has_words_before() then
						completion.complete()
					else
						fallback()
					end
				end, { 'i', 's' }),

				['<S-Tab>'] = completion.mapping(function(fallback)
					if completion.visible() then
						completion.select_prev_item()
						---This is intended for the above coercion.
						---@diagnostic disable-next-line: redundant-parameter
					elseif snippets.jumpable(-1) then
						---In case the snippets engine is not available, this block
						---is never evaluated due to the above coercion where
						---`jumpable` always returns `false`.
						snippets.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' })
			},

			sources = completion.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{ name = 'path' },
			}),

			sorting = {
				comparators = {
					completion.config.compare.offset,
					completion.config.compare.exact,
					completion.config.compare.score,

					completion.config.compare.kind,
					completion.config.compare.sort_text,
					completion.config.compare.length,
					completion.config.compare.order,
				},
			},
		})
	end
}
