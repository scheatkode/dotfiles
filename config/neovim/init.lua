vim.loader.enable()

-- Setup package path

-- To prevent code duplication, a library with utilities
-- commonly used in lua has been extracted to a different
-- location.

do
	local pack_path = (
		os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config"
	) .. "/lib/lua"

	package.path = string.format(
		"%s;%s/?.lua;%s/?/init.lua",
		package.path,
		pack_path,
		pack_path
	)
end

-- Leader key

-- It's generally a good idea  to set this early on and
-- before any  mapping. this  is to avoid  mapping with
-- the old leader.

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("", "<Space>", "<Nop>")

-- Configuration

require("user.builtins").setup()
require("user.settings").setup()
require("user.mappings").setup()
require("user.providers").setup()
require("user.autocmd").setup()
require("user.abbrevs").setup()
require("user.diagnostics").setup()
require("user.lsp").setup()

require("colors").load("gruvbox")

require("plugman").setup()

require("user.plugins.statusline").setup()
