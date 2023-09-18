--- Neovim filetype plugin
--- Language: Git commit message

---@diagnostic disable: unknown-diag-code
---@diagnostic disable: global_usage

---@alias ResetFunction fun(self: user.git.CompletionSource)
---@alias ShouldCompleteFunction fun(self: user.git.CompletionSource, ctx: user.git.ContextualGitCompletion): (boolean,integer|nil)
---@alias GetCandidatesFunction fun(self: user.git.CompletionSource, ctx: user.git.ContextualGitCompletion): string[]|integer
---@alias user.git.CompletionSource { reset: ResetFunction, should_complete: ShouldCompleteFunction, get_candidates: GetCandidatesFunction }

if vim.b.did_after_ftplugin == 1 then
	return
end

local starts_with = require("stringx.startswith")

---Completion source for git trailers.
---@class user.git.TrailerCompletionSource
local TrailerCompletionSource = {}
TrailerCompletionSource.__index = TrailerCompletionSource

---Create a new `GitTrailerCompletion` instance.
---@return user.git.TrailerCompletionSource
function TrailerCompletionSource.new()
	return setmetatable({}, TrailerCompletionSource)
end

---Reset the current instance.
function TrailerCompletionSource.reset()
	-- Do nothing.
end

---Check whether the current state is suitable for git trailer completion.
---@param _ user.git.TrailerCompletionSource
---@param ctx user.git.ContextualGitCompletion
---@return boolean
---@return integer|nil
function TrailerCompletionSource.should_complete(_, ctx)
	return not (starts_with(ctx.line, " ") or string.find(ctx.line, ": ")), 0
end

---Retrieve the candidates for completion.
---@param _ user.git.TrailerCompletionSource
---@param ctx user.git.ContextualGitCompletion
---@return string[]
function TrailerCompletionSource.get_candidates(_, ctx)
	return vim.fn.matchfuzzy({
		--- @see https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/CommitMessageConventions.html
		"Bug",
		"Partial-Bug",
		"Related-Bug",
		"Cc",
		"Closes",
		"Fixes",
		"Implements",
		"References",
		"Acked-By",
		"Co-Authored-By",
		"Reported-By",
		"Reviewed-By",
		"Signed-Off-By",
		"Suggested-By",
		"Tested-By",
	}, ctx.base)
end

---Completion source for addresses.
---@class user.git.AddressCompletionSource
---@field handle user.libuv.UvHandle
---@field stdout user.libuv.UvStream
---@field new fun(): user.git.AddressCompletionSource
---@field reset fun(self: user.git.AddressCompletionSource)
---@field get_candidates GetCandidatesFunction
---@field should_complete ShouldCompleteFunction
---@field construct_query fun(self: user.git.AddressCompletionSource, ctx: user.git.ContextualGitCompletion): string
---@field on_quit fun(self: user.git.AddressCompletionSource): fun()
---@field on_read fun(self: user.git.AddressCompletionSource, ctx: user.git.ContextualGitCompletion): fun(err: any, data: string|nil)
local AddressCompletionSource = {
	pattern = vim.regex([[\v^(((\u\l+)-)+By|Cc): ]]),
}
AddressCompletionSource.__index = AddressCompletionSource

---@class user.libuv.UvHandle
---@field close fun()

---@class user.libuv.UvStream
---@field read_start fun()
---@field read_stop fun()
---@field close fun()

---Create a new `GitAddressCompletion` instance.
---@return user.git.AddressCompletionSource
function AddressCompletionSource.new()
	return setmetatable(
		{ handle = nil, stdout = nil },
		AddressCompletionSource
	)
end

---Reset the current instance.
function AddressCompletionSource:reset()
	if self.handle == nil then
		return
	end

	self.stdout:read_stop()
	self.stdout:close()
	self.handle:close()

	self.stdout = nil
	self.handle = nil
end

---Create a libuv quit callback.
---@return fun()
function AddressCompletionSource:on_quit()
	return function()
		return self:reset()
	end
end

---Create a libuv sub process read callback.
---@param _ user.git.AddressCompletionSource
---@param ctx user.git.ContextualGitCompletion
---@return fun(err: any, data: string|nil)
function AddressCompletionSource.on_read(_, ctx)
	return function(err, data)
		assert(not err, err)

		if not data then
			return
		end

		local matches = {} ---@type string[]

		for line in data:gmatch("([^\n]*)\n?") do
			matches[#matches + 1] = line
		end

		ctx:done(ctx.line:find(": ") + 2, matches)
	end
end

---Check whether the current state is suitable for git address completion.
---@param ctx user.git.ContextualGitCompletion
---@return boolean
---@return integer|nil
function AddressCompletionSource:should_complete(ctx)
	local trailer = ctx.line:find(": ")

	if not trailer or not self.pattern:match_str(ctx.line) then
		return false, nil
	end

	return true, trailer + 1
end

---Construct a notmuch query from the current context.
---@param _ user.git.AddressCompletionSource
---@param ctx user.git.ContextualGitCompletion
---@return string
function AddressCompletionSource.construct_query(_, ctx)
	if ctx.base:find(":") then
		return ctx.base
	end

	return string.format("from:%s*", ctx.base)
end

---Retrieve the candidates for completion.
---@param ctx user.git.ContextualGitCompletion
---@return integer
function AddressCompletionSource:get_candidates(ctx)
	self.stdout = vim.loop.new_pipe(false)
	self.handle = vim.loop.spawn("notmuch", {
		args = { "address", "--", self:construct_query(ctx) },
		stdio = { nil, self.stdout, nil },
	}, self:on_quit())

	vim.loop.read_start(self.stdout, self:on_read(ctx))

	return -2
end

---A container for handling multiple completion sources.
---@class user.git.ContextualGitCompletion
---@field sources user.git.CompletionSource[]
---@field volunteer integer
---@field base string
local ContextualGitCompletion = {}
ContextualGitCompletion.__index = ContextualGitCompletion

---Create a new `ContextualGitCompletion` instance.
---@return user.git.ContextualGitCompletion
function ContextualGitCompletion.new()
	return setmetatable({
		sources = {},
		volunteer = nil,
	}, ContextualGitCompletion)
end

---Register a completion source.
---@param source user.git.CompletionSource
function ContextualGitCompletion:use(source)
	self.sources[#self.sources + 1] = source
	return self
end

---Check whether the current state is suitable for completion. This iterates
---over the registered sources and stores a volunteer for handling completion.
---@return integer
function ContextualGitCompletion:should_complete()
	for i, source in ipairs(self.sources) do
		local ok, position = source:should_complete(self)

		if ok then
			self.volunteer = i
			return position --[[ @as integer ]]
		end
	end

	return -3
end

---Get completion candidates from the registered volunteer.
---@return integer|string[]
function ContextualGitCompletion:get_candidates()
	return self.sources[self.volunteer]:get_candidates(self)
end

---Reset all registered sources.
function ContextualGitCompletion:reset()
	for _, source in ipairs(self.sources) do
		source:reset()
	end
end

---Trigger the completion flow.
---@param findstart integer
---@param base string
---@return integer|string[]
function ContextualGitCompletion:complete(findstart, base)
	local current_line = vim.api.nvim_get_current_line() ---@type string

	self.base = base
	self.line = current_line

	if findstart ~= 0 then
		self:reset()
		return self:should_complete()
	end

	return self:get_candidates()
end

---Callback used to manually trigger completion. This is useful for
---triggering completion after an asynchronous operation.
---@param _ user.git.ContextualGitCompletion
---@param start integer
---@param matches string[]
ContextualGitCompletion.done = vim.schedule_wrap(function(_, start, matches)
	return vim.fn.complete(start, matches)
end)

---Transform the current completion handler instance into a function suitable
---for use with `:h completefunc`.
---@return fun(findstart: integer, base: string): integer|string[]
function ContextualGitCompletion:into_function()
	return function(findstart, base)
		return self:complete(findstart, base)
	end
end

---Construct the contextual completion engine and return a function suitable
---to handle completion requests.
---@return fun(findstart: integer, base: string):integer|string[]
local function setup()
	return ContextualGitCompletion.new()
		:use(TrailerCompletionSource.new())
		:use(AddressCompletionSource.new())
		:into_function()
end

_G.user = _G.user or {}
_G.user.complete_gitcommit = _G.user.complete_gitcommit or setup()

-- `:h omnifunc` is filetype-specific while `:h completefunc` is generic
vim.bo.completefunc = "v:lua.user.complete_gitcommit"

vim.opt_local.textwidth = 72
vim.opt_local.spell = true

vim.b.editorconfig = false
vim.b.did_after_ftplugin = 1
