---Return a formatted string from fetched diagnostics.
---@return string
local function diagnostic_status()
	local parts = {}
	local diagnostics = {
		{ severity = vim.diagnostic.severity.ERROR, format = "%%5* %d%%*" },
		{ severity = vim.diagnostic.severity.WARN, format = "%%3* %d%%*" },
		{ severity = vim.diagnostic.severity.INFO, format = "%%1* %d%%*" },
		{ severity = vim.diagnostic.severity.HINT, format = "%%2* %d%%*" },
	}

	for _, d in ipairs(diagnostics) do
		local diags = #vim.diagnostic.get(0, { severity = d.severity })
		if diags > 0 then
			parts[#parts + 1] = string.format(d.format, diags)
		end
	end

	return table.concat(parts, " ")
end

---@class NvimLspProgressMessage
---@field name string
---@field title string
---@field message string?
---@field percentage number?
---@field done boolean?
---@field progress boolean

---Format the given LSP progress messages.
---@param messages NvimLspProgressMessage[]
---@return string
local function format_lsp_progress(messages)
	local percentage
	local parts = {}

	for _, message in pairs(messages) do
		if message.message then
			parts[#parts + 1] =
				string.format("%s: %s", message.title, message.message)
		else
			parts[#parts + 1] = message.title
		end

		if message.percentage then
			if message.done then
				percentage = 100
			else
				percentage = math.max(percentage or 0, message.percentage)
			end
		end
	end

	if percentage then
		return string.format(
			"(%d%%%%) %s",
			percentage,
			table.concat(parts, ", ")
		)
	end

	return table.concat(parts, ", ")
end

---Return the current LSP's status if available, otherwise return the
---current filename.
---@return string
local function file_or_lsp_status()
	local mode = vim.api.nvim_get_mode().mode

	if vim.lsp.status then
		local lsp_status = vim.lsp.status()
		if mode ~= "n" or lsp_status == "" then
			return [[%{expand("%:.")}]]
		end

		return lsp_status
	end

	local messages = vim.lsp.util.get_progress_messages()
	if mode ~= "n" or vim.tbl_isempty(messages) then
		return [[%{expand("%:.")}]]
	end

	return format_lsp_progress(messages)
end

---Return the current dap session's status if available, otherwise
---return an empty string.
---@return string
local function dap_status()
	if not package.loaded["dap"] then
		return ""
	end

	return require("dap").status()
end

---Render the statusline.
---@return string
local function statusline()
	local part = {
		file_or_lsp_status(),
		[[ %m%r%* ]],

		[[%3*%{&ff!="unix"?"[".&ff."] ":""}%*]],
		dap_status(),
		diagnostic_status(),

		[[%*%= %-14.(%1*%l%0*:%2*%c%3*%V%) %4*%P]],
	}

	return table.concat(part)
end

---Setup the statusline.
local function setup()
	_G.user = _G.user or {}
	_G.user.statusline = statusline
	vim.opt.statusline = [[%!v:lua.user.statusline()]]

	vim.api.nvim_create_autocmd("User", {
		command = "redrawstatus",
		group = vim.api.nvim_create_augroup("UserStatusLine", { clear = true }),
		pattern = {
			"LspProgressUpdate",
			"LspRequest",
			"DapProgressUpdate",
		},
	})
end

return {
	setup = setup,
}
