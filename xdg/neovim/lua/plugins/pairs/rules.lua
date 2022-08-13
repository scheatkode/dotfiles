return {
	setup = function()
		local pairs = require('nvim-autopairs')
		local rule  = require('nvim-autopairs.rule')
		local cond  = require('nvim-autopairs.conds')

		local rules = {}

		-- additional `%` rule for tagged templates, i.e. `{%%}`
		table.insert(rules, rule('%', '%', {
			'jinja', 'sls', 'yaml', 'sls.yaml'
		}))

		-- additional automatic spacing between pairs
		table.insert(rules, rule(' ', ' ')
			:with_pair(function(options)
				local pair = options.line:sub(options.col - 1, options.col)
				return vim.tbl_contains({ '()', '[]', '{}', '%%' }, pair)
			end)
		)

		-- remove spaces between `%` pairs, useful for templates using `{%%}`
		table.insert(rules,
			rule('% ', ' %', { 'jinja', 'sls', 'yaml', 'sls.yaml' })
			:with_pair(cond.none())
			:with_move(function(options)
				return options.prev_char:match('.%%%') ~= nil
			end)
			:use_key('%')
		)

		-- remove spaces between parenthesis
		table.insert(rules, rule('( ', ' )')
			:with_pair(cond.none())
			:with_move(function(options)
				return options.prev_char:match('.%)') ~= nil
			end)
			:use_key(')')
		)

		-- remove spaces between curly brackets
		table.insert(rules, rule('{ ', ' }')
			:with_pair(cond.none())
			:with_move(function(options)
				return options.prev_char:match('.%}') ~= nil
			end)
			:use_key('}')
		)

		-- remove spaces between brackets
		table.insert(rules, rule('[ ', ' ]')
			:with_pair(cond.none())
			:with_move(function(options)
				return options.prev_char:match('.%]') ~= nil
			end)
			:use_key(']')
		)

		pairs.add_rules(rules)
	end
}
