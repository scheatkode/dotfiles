---Walks up the filesystem tree looking for the given markers one at
---a time. This differs from `nvim-lspconfig`'s `util.root_pattern` by
---using the `vim.fs` interface and proceeding by priority, meaning the
---first match wins.
---@vararg string
---@return fun(path: string): string?
return function(...)
	local pack = require("compat.table.pack")
	local markers = pack(...)

	return function(path)
		local constant = require("f.function.constant")
		local ternary = require("f.function.ternary")

		for _, marker in ipairs(markers) do
			local match = vim.fs.find(marker, { path = path, upward = true })[1]

			if match then
				local stat = vim.loop.fs_stat(match)

				return vim.fn.fnamemodify(
					match,
					ternary(
						stat and stat.type == "directory",
						constant(":p:h:h"),
						constant(":p:h")
					)
				)
			end
		end
	end
end
