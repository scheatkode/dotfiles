local has_protocol, protocol = pcall(require, 'vim.lsp.protocol')

if not has_protocol then
   return
end

local m = {}

local defaults = {
   '',  -- Text        = 1
   'ƒ',  -- Method      = 2
   -- '',  -- Function    = 3
   'ƒ',  -- Function    = 3
   '',  -- Constructor = 4
   '',  -- Variable    = 5
   -- '',  -- Class       = 6
   '',  -- Class       = 6
   'ﰮ',  -- Interface   = 7
   '',  -- Module      = 8
   '',  -- Property    = 9
   '',  -- Unit        = 10
   '',  -- Value       = 11
   '了', -- Enum        = 12
   '',  -- Keyword     = 13
   '﬌',  -- Snippet     = 14
   '',  -- Color       = 15
   '',  -- File        = 16
   '',  -- Folder      = 17
   '',  -- EnumMember  = 18
   '',  -- Constant    = 19
   ''   -- Struct      = 20
}

--- TODO(scheatkode): documentation
function m.setup(options)
   local kinds = defaults

   for i, v in ipairs(options or {}) do
      kinds[i] = v
   end

   protocol.CompletionItemKind = kinds
end

return m
