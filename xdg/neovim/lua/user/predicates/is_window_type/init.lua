---@param type 'autocmd'|'command'|'loclist'|'popup'|'preview'|'quickfix'|'unknown'
---@return fun(): boolean
return function(type)
	return function()
		return vim.fn.win_gettype() == type
	end
end
