---@type fun(_: number): fun(_: number): boolean
return function(size)
	local assertx = require("assertx")

	assertx(
		size ~= nil and size >= 0,
		string.format,
		"expected correct file size, got %s",
		size
	)

	---@type fun(_: number): boolean
	return function(bufnr)
		bufnr = type(bufnr) == "number" and bufnr or 0

		local ok, stat =
			pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))

		return ok and stat and stat.size >= size
	end
end
