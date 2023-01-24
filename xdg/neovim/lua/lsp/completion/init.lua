local constant = require('f.function.constant')
local extend = require('tablex.deep_extend')

local protocol = require('vim.lsp.protocol')
local util = require('vim.lsp.util')

local type = type

local api = vim.api
local lsp = vim.lsp

---@class lsp.CompletionItemLabelDetails
---@field detail nil|string
---@field description nil|string

---@alias lsp.InsertTextMode 1|2

---@class lsp.TextEdit
---@field range lsp.Range
---@field newText string

---@class lsp.InsertReplaceEdit
---@field newText string
---@field insert lsp.Range
---@field replace lsp.Range

---@class lsp.Command
---@field title string
---@field command string
---@field arguments any|nil

---@class lsp.Position
---@field line number
---@field character number

---@class lsp.Range
---@field start lsp.Position
---@field end lsp.Position

---@class lsp.ItemDefaults
---@field editRange nil|lsp.Range|{insert: lsp.Range, replace: lsp.Range}
---@field insertTextFormat nil|number
---@field insertTextMode nil|lsp.InsertTextMode
---@field data any

---@class lsp.CompletionItem
---@field label string
---@field labelDetails nil|lsp.CompletionItemLabelDetails
---@field kind nil|number
---@field tags nil|number[]
---@field detail nil|string
---@field documentation nil|string|lsp.MarkupContent
---@field deprecated nil|boolean
---@field preselect nil|boolean
---@field sortText nil|string
---@field filterText nil|string
---@field insertText nil|string
---@field insertTextFormat nil|number
---@field insertTextMode nil|lsp.InsertTextMode
---@field textEdit nil|lsp.TextEdit|lsp.InsertReplaceEdit
---@field textEditText nil|string
---@field additionalTextEdits nil|lsp.TextEdit[]
---@field commitCharacters nil|string[]
---@field command nil|lsp.Command
---@field data nil|any

---@class lsp.CompletionList
---@field isIncomplete boolean
---@field itemDefaults lsp.ItemDefaults|nil
---@field items lsp.CompletionItem[]

--- Convert UTF index to `encoding` index.
--- Convenience wrapper around vim.str_byteindex
---Alternative to vim.str_byteindex that takes an encoding.
---@param line string line to be indexed
---@param index number UTF index
---@param encoding string utf-8|utf-16|utf-32|nil defaults to utf-16
---@return number byte (utf-8) index of `encoding` index `index` in `line`
local function byteindex_encoding(line, index, encoding)
	encoding = encoding or 'utf-16'

	if encoding == 'utf-8' then
		if index then
			return index
		end

		return #line
	elseif encoding == 'utf-16' then
		return vim.str_byteindex(line, index, true)
	elseif encoding == 'utf-32' then
		return vim.str_byteindex(line, index)
	end

	error('Invalid encoding: ' .. vim.inspect(encoding))
end

---Returns text that should be inserted when selecting completion item. The
---precedence is as follows: textEdit.newText > insertText > label
---@see https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_completion
local function get_completion_word(item)
	if
		item.textEdit ~= nil
		and item.textEdit.newText ~= nil
		and item.textEdit.newText ~= ''
	then
		local insert_text_format =
			protocol.InsertTextFormat[item.insertTextFormat]

		if insert_text_format == 'PlainText' or insert_text_format == nil then
			return item.textEdit.newText
		end

		return util.parse_snippet(item.textEdit.newText)
	end

	if item.insertText ~= nil and item.insertText ~= '' then
		local insert_text_format =
			protocol.InsertTextFormat[item.insertTextFormat]

		if insert_text_format == 'PlainText' or insert_text_format == nil then
			return item.insertText
		end

		return util.parse_snippet(item.insertText)
	end

	return item.label
end

local function adjust_start_col(lnum, line, items, encoding)
	-- vim.fn.complete takes a startbyte and selecting a completion entry will
	-- replace anything between the startbyte and the current cursor position
	-- with the completion item's word
	--
	-- `col` is derived using `vim.fn.match(line_to_cursor, '\\k*$') + 1` Which
	-- works for most cases to find the word boundary, but the language server
	-- may work with a different boundary.
	--
	-- Luckily, the LSP response contains an (optional) `textEdit` with range,
	-- which indicates which boundary the language server used.
	--
	-- Concrete example, in Lua where there is currently a known mismatch:
	--
	-- require('plenary.asy|
	--         ▲       ▲   ▲
	--         │       │   │
	--         │       │   └── cursor_pos: 20
	--         │       └────── col: 17
	--         └────────────── textEdit.range.start.character: 9
	--                                 .newText = 'plenary.async'
	--
	-- Caveat:
	--  - textEdit.range can (in theory) be different *per* item.
	--  - range.start.character is (usually) a UTF-16 offset
	--
	-- Approach:
	--  - Use textEdit.range.start.character *only* if *all* items contain the same value
	--    Otherwise we'd have to normalize the `word` value.
	--
	local min_start_char = nil

	for _, item in pairs(items) do
		if item.textEdit and item.textEdit.range.start.line == lnum - 1 then
			local range = item.textEdit.range

			if min_start_char and min_start_char ~= range.start.character then
				return nil
			end

			if range.start.character > range['end'].character then
				return nil
			end

			min_start_char = range.start.character
		end
	end

	if min_start_char then
		return byteindex_encoding(line, min_start_char, encoding)
	else
		return nil
	end
end

---Turns the result of a `textDocument/completion` request into
---vim-compatible |complete-items|.
---
---@param result lsp.CompletionItem[]|lsp.CompletionList|nil The result of a `textDocument/completion` call, e.g. from |vim.lsp.buf.completion()|.
---@param prefix (string) the prefix to filter the completion items
---@returns { matches = complete-items table, incomplete = bool }
---@see |complete-items|
---@see |vim.lsp.buf.completion()|
local function text_document_completion_list_to_complete_items(result, prefix)
	local items = util.extract_completion_items(result)

	if vim.tbl_isempty(items) then
		return {}
	end

	if prefix ~= '' then
		items =
			vim.fn.matchfuzzy(items, prefix, { text_cb = get_completion_word })
	end

	local matches = {}

	for _, completion_item in ipairs(items) do
		local info = ' '
		local documentation = completion_item.documentation

		if documentation then
			if type(documentation) == 'string' and documentation ~= '' then
				info = documentation
			elseif
				type(documentation) == 'table'
				and type(documentation.value) == 'string'
			then
				info = documentation.value
			end
		end

		local word = get_completion_word(completion_item)

		table.insert(matches, {
			word = word,
			abbr = completion_item.label,
			kind = lsp.protocol.CompletionItemKind[completion_item.kind] or '',
			menu = completion_item.detail or '',
			info = info,
			icase = 1,
			dup = 1,
			empty = 1,
			user_data = {
				nvim = {
					lsp = {
						completion_item = completion_item,
					},
				},
			},
		})
	end

	return matches
end

--- Implements 'omnifunc' compatible LSP completion.
---
---@see |:h complete-functions|
---@see |:h complete-items|
---@see |:h CompleteDone|
---
---@param findstart number 0 or 1, decides behavior
---@param _ number findstart=0, text to match against
---
---@returns (number) Decided by {findstart}:
--- - findstart=0: column where the completion starts, or -2 or -3
--- - findstart=1: list of matches (actually just calls |complete()|)
local function omnifunc(findstart, _)
	local bufnr = api.nvim_get_current_buf()
	local has_buffer_clients =
		not vim.tbl_isempty(lsp.get_active_clients({ bufnr = bufnr }))

	if not has_buffer_clients then
		if findstart == 1 then
			return -1
		else
			return {}
		end
	end

	-- Then, perform standard completion request
	local pos            = api.nvim_win_get_cursor(0)
	local line           = api.nvim_get_current_line()
	local line_to_cursor = line:sub(1, pos[2])

	-- Get the start position of the current keyword
	local text_match = vim.fn.match(line_to_cursor, '\\k*$')
	local params     = util.make_position_params()
	local items      = {}

	lsp.buf_request(
		bufnr,
		'textDocument/completion',
		params,
		function(err, result, context)
			if err or not result or vim.fn.mode() ~= 'i' then
				return
			end

			-- Completion response items may be relative to a position different
			-- than `textMatch`. Concrete example, with
			-- sumneko/lua-language-server:
			--
			-- require('plenary.asy|
			--         ▲       ▲   ▲
			--         │       │   └── cursor_pos: 20
			--         │       └────── textMatch: 17
			--         └────────────── textEdit.range.start.character: 9
			--                                 .newText = 'plenary.async'
			--                  ^^^
			--                  prefix (We'd remove everything not starting with
			--                  `asy`, so we'd eliminate the `plenary.async`
			--                  result
			--
			-- `adjust_start_col` is used to prefer the language server boundary.
			--
			local client     = lsp.get_client_by_id(context.client_id)
			local encoding   = client and client.offset_encoding or 'utf-16'
			local candidates = util.extract_completion_items(result)
			local startbyte  = adjust_start_col(
				pos[1],
				line,
				candidates,
				encoding
			) or text_match

			local prefix  = line:sub(startbyte + 1, pos[2])
			local matches =
				text_document_completion_list_to_complete_items(result, prefix)

			vim.list_extend(items, matches)
			vim.fn.complete(startbyte + 1, items)
		end
	)

	-- Return -2 to signal that we should continue completion so that we can
	-- async complete.
	return -2
end

local function apply_lsp_additional_text_edits(context)
	local completed_item = vim.v.completed_item

	if
		not (
			completed_item
			and completed_item.user_data
			and completed_item.user_data.nvim
			and completed_item.user_data.nvim.lsp
			and completed_item.user_data.nvim.lsp.completion_item
			and completed_item.user_data.nvim.lsp.completion_item.additionalTextEdits
		)
	then
		return
	end

	local pos  = api.nvim_win_get_cursor(0)
	local lnum = pos[1]
	local item = completed_item.user_data.nvim.lsp.completion_item

	-- text edit in the same line would mess with the cursor position
	local edits = vim.tbl_filter(function(x)
		return x.range.start.line ~= (lnum - 1)
	end, item.additionalTextEdits)

	lsp.util.apply_text_edits(
		edits,
		context.bufnr,
		context.client.offset_encoding
	)
end

local function on_complete_done(context)
	return function()
		apply_lsp_additional_text_edits(context)
	end
end

local function commit_completion(context)
	return function()
		if vim.fn.pumvisible() ~= 0 then
			if vim.fn.complete_info()['selected'] == -1 then
				-- gotta live without completeopt+='preview' because of this.
				-- @see https://github.com/neovim/neovim/pull/13854
				-- @see https://github.com/neovim/neovim/issues/16488
				api.nvim_select_popupmenu_item(0, true, true, {})
				return ''
			end

			return '<C-y>'
		end

		return context.newline()
	end
end

return {
	setup = function(client, bufnr, overrides)
		local defaults = {
			newline = constant('<CR>'),
		}

		local context = extend('force', defaults, overrides or {}, {
			bufnr  = bufnr,
			client = client,
		})

		-- Enter keys accepts current completion.
		vim.keymap.set('i', '<CR>', commit_completion(context), {
			buffer = bufnr,
			expr   = true,
		})

		local augroup =
			api.nvim_create_augroup(string.format('LspOmnifunc%d', bufnr), {
				clear = true,
			})

		api.nvim_create_autocmd('CompleteDone', {
			callback = on_complete_done(context),
			buffer   = bufnr,
			group    = augroup,
		})

		if _G.custom == nil then
			_G.custom = {}
		end

		_G.custom.omnifunc = omnifunc

		vim.bo[bufnr].omnifunc = 'v:lua.custom.omnifunc'
	end,
}
