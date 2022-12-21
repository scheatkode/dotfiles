return {
	-- Thanks TJ !
	setup = function()
		local snippet = require('luasnip')

		local sn = snippet.sn
		local s  = snippet.s
		local i  = snippet.insert_node
		local t  = snippet.text_node
		local c  = snippet.choice_node
		local d  = snippet.dynamic_node

		local r = require('luasnip.extras').rep
		local f = require('luasnip.extras.fmt').fmta

		local transforms = {
			int = function(_, _)
				return t('0')
			end,

			bool = function(_, _)
				return t('false')
			end,

			string = function(_, _)
				return t('""')
			end,

			error = function(_, info)
				if info then
					info.index = info.index + 1

					return c(info.index, {
						t(info.err_name),
						-- TODO: Even better if instead of the function name, we had
						-- an input node.
						t(
							string.format(
								'fmt.Errorf("%s", %s)',
								info.func_name,
								info.err_name
							)
						),
					})
				end

				return t('err')
			end,

			-- Types with a '*' mean they are pointers, so return nil
			[function(text)
				return string.find(text, '*', 1, true) ~= nil
			end] = function(_, _)
				return t('nil')
			end,
		}

		local function transform(text, info)
			local condition_matches = function(condition, ...)
				if type(condition) == 'string' then
					return condition == text
				end

				return condition(...)
			end

			for condition, result in pairs(transforms) do
				if condition_matches(condition, text, info) then
					return result(text, info)
				end
			end

			return t(text)
		end

		local handlers = {
			parameter_list = function(node, info)
				local result = {}
				local count = node:named_child_count()

				for idx = 0, count - 1 do
					local matching = node:named_child(idx)
					local type_node = matching:field('type')[1]

					result[#result + 1] =
						transform(vim.treesitter.get_node_text(type_node, 0), info)

					if idx ~= count - 1 then
						result[#result + 1] = t({ ', ' })
					end
				end

				return result
			end,

			type_identifier = function(node, info)
				return { transform(vim.treesitter.get_node_text(node, 0), info) }
			end,
		}

		local function_node_types = {
			function_declaration = true,
			method_declaration = true,
			func_literal = true,
		}

		local function get_method(expression)
			if not expression then
				return nil
			end

			if function_node_types[expression:type()] then
				return expression
			end

			return get_method(expression:parent())
		end

		local function result_type(info)
			local ts_utils = require('nvim-treesitter.ts_utils')

			local cursor_node = ts_utils.get_node_at_cursor()
			local function_node = get_method(cursor_node)

			if not function_node then
				print('Not inside of a function')
				return t('')
			end

			local query = vim.treesitter.parse_query(
				'go',
				[[
				[
					(method_declaration   result: (_) @id)
					(function_declaration result: (_) @id)
					(func_literal         result: (_) @id)
				]
			]]
			)

			for _, node in query:iter_captures(function_node, 0) do
				if handlers[node:type()] then
					return handlers[node:type()](node, info)
				end
			end
		end

		local function return_values(args)
			return sn(
				nil,
				result_type({
					index = 0,
					err_name = args[1][1],
					func_name = args[2][1],
				})
			)
		end

		snippet.add_snippets('go', {
			s(
				'eif',
				f(
					[[
<val>, <err> := <f>(<args>)
if <err_var> != nil {
	return <result>
}
<finish>]],
					{
						val     = i(1),
						err     = i(2, 'err'),
						f       = i(3),
						args    = i(4),
						err_var = r(2),
						result  = d(5, return_values, { 2, 3 }),
						finish  = i(0),
					}
				)
			),
		})
	end,
}
