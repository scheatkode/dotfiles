return {
	setup = function()
		local pairs = require('nvim-autopairs')
		local cond  = require('nvim-autopairs.conds')
		local rule  = require('nvim-autopairs.rule')

		local rules = {}

		-- additional `%` rule for tagged templates, i.e. `{%%}`
		rules[#rules + 1] = rule('%', '%', {
			'jinja',
			'sls',
			'sls.yaml',
			'yaml',
		})

		-- additional automatic spacing between pairs
		rules[#rules + 1] = rule(' ', ' '):with_pair(function(options)
			local pair = options.line:sub(options.col - 1, options.col)
			return vim.tbl_contains({
				'()',
				'[]',
				'{}',
				'%%',
			}, pair)
		end)

		-- remove spaces between `%` pairs, useful for templates using `{%%}`
		rules[#rules + 1] = rule('% ', ' %', {
				'jinja',
				'sls',
				'yaml',
				'sls.yaml',
			})
			:with_pair(cond.none())
			:with_move(function(options)
				return options.prev_char:match('.%%%') ~= nil
			end)
			:use_key('%')

		-- remove spaces between parenthesis
		rules[#rules + 1] = rule('( ', ' )')
			:with_pair(cond.none())
			:with_move(function(options)
				return options.prev_char:match('.%)') ~= nil
			end)
			:use_key(')')

		-- remove spaces between curly brackets
		rules[#rules + 1] = rule('{ ', ' }')
			:with_pair(cond.none())
			:with_move(function(options)
				return options.prev_char:match('.%}') ~= nil
			end)
			:use_key('}')

		-- remove spaces between brackets
		rules[#rules + 1] = rule('[ ', ' ]')
			:with_pair(cond.none())
			:with_move(function(options)
				return options.prev_char:match('.%]') ~= nil
			end)
			:use_key(']')

		pairs.add_rules(rules)
	end,
}
