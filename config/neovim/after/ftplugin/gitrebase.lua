--- Neovim filetype plugin
--- Language: Git rebase todo

if vim.b.did_after_ftplugin == 1 then
	return
end

local function with_count(command)
	return function()
		return string.format([[<cmd>.,.+%s%s<CR>]], vim.v.count1 - 1, command)
	end
end

local function with_range(command)
	return function()
		return string.format(
			[[<cmd>%s,%s%s<CR><Esc>]],
			vim.fn.getpos("v")[2],
			vim.fn.getcurpos(".")[2],
			command
		)
	end
end

vim.keymap.set("n", "<Tab>", "<cmd>Cycle<CR>", {
	desc = "Cycle commit action",
	buffer = 0,
})

for mode, map in pairs({
	n = {
		{ lhs = "ge", rhs = with_count("Edit"), desc = "Edit commit" },
		{ lhs = "gf", rhs = with_count("Fixup"), desc = "Fixup commit" },
		{ lhs = "gp", rhs = with_count("Pick"), desc = "Pick commit" },
		{ lhs = "gr", rhs = with_count("Reword"), desc = "Reword commit" },
		{ lhs = "gs", rhs = with_count("Squash"), desc = "Squash commit" },
		{ lhs = "gd", rhs = with_count("Drop"), desc = "Drop commit" },
	},
	x = {
		{
			lhs = "gf",
			rhs = with_range("Fixup"),
			desc = "Fixup selected commits",
		},
		{
			lhs = "gp",
			rhs = with_range("Pick"),
			desc = "Pick selected commits",
		},
		{
			lhs = "gr",
			rhs = with_range("Reword"),
			desc = "Reword selected commits",
		},
		{ lhs = "gs", rhs = with_range("Squash"), desc = "Squash commits" },
		{ lhs = "gd", rhs = with_range("Drop"), desc = "Drop commits" },
	},
}) do
	for _, m in ipairs(map) do
		vim.keymap.set(mode, m.lhs, m.rhs, {
			desc = m.desc,
			buffer = 0,
			expr = true,
		})
	end
end

vim.keymap.set("n", "<C-j>", function()
	vim.cmd.move({
		args = { ".+" .. vim.v.count1 },
		mods = { emsg_silent = true },
	})
end, { buffer = 0, desc = "Swap current line with the one below" })

vim.keymap.set("n", "<C-k>", function()
	vim.cmd.move({
		args = { ".-" .. vim.v.count1 + 1 },
		mods = { emsg_silent = true },
	})
end, { buffer = 0, desc = "Swap current line with the one above" })

vim.b.did_after_ftplugin = 1
