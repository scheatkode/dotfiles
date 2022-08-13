return {
	setup = function()
		local log = require('log')

		local has_pairs, pairs  = pcall(require, 'nvim-autopairs')
		local has_treesitter, _ = pcall(require, 'nvim-treesitter')

		if not has_pairs then
			log.error('Tried loading plugin ... unsuccessfully ‼', 'nvim-autopairs')
			return has_pairs
		end

		local rule = require('nvim-autopairs.rule')
		local cond = require('nvim-autopairs.conds')

		if has_treesitter then
			pairs.setup {
				disable_in_macro = true,
				check_ts         = true,
			}
		else
			pairs.setup {
				disable_in_macro = true,
			}

			log.warn(
				'Treesitter not found, autopairs will have limited functionality',
				'nvim-autopairs'
			)
		end

		pairs.add_rules({
			rule('%', '%', { 'jinja', 'sls', 'yaml', 'sls.yaml' }),
			rule(' ', ' ')
				 :with_pair(function( options)
				    local pair = options.line:sub(options.col - 1, options.col)
				    return vim.tbl_contains({ '()', '[]', '{}', '%%' }, pair)
				 end),
			rule('% ', ' %')
				 :with_pair(cond.none())
				 :with_move(function( options)
				    return options.prev_char:match('.%%%') ~= nil
				 end)
				 :use_key('%'),
			rule('( ', ' )')
				 :with_pair(cond.none())
				 :with_move(function( options)
				    return options.prev_char:match('.%)') ~= nil
				 end)
				 :use_key(')'),
			rule('{ ', ' }')
				 :with_pair(cond.none())
				 :with_move(function( options)
				    return options.prev_char:match('.%}') ~= nil
				 end)
				 :use_key('}'),
			rule('[ ', ' ]')
				 :with_pair(cond.none())
				 :with_move(function( options)
				    return options.prev_char:match('.%]') ~= nil
				 end)
				 :use_key(']'),
		})
	end
}
