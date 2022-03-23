local sf   = string.format
local vapi = vim.api

local TMUX      = os.getenv('TMUX')
local TMUX_PANE = os.getenv('TMUX_PANE')

local function tmux_socket ()
   return vim.split(TMUX, ',')[1]
end

local function tmux_jump (to)
   local directions = {
      h = 'L',
      k = 'U',
      l = 'R',
      j = 'D',
   }

   local command = sf(
      'tmux -S %s select-pane -t "%s" -%s',
      tmux_socket(),
      TMUX_PANE,
      directions[to]
   )

   local handle = assert(
      io.popen(command),
      sf('unable to execute tmux command "%s"', command)
   )

   local result = handle:read()
   handle:close()

   return result
end

local function jump(direction)
   return function ()
      -- window id before jump
      local current_window = vapi.nvim_get_current_win()

      vapi.nvim_command(sf('wincmd %s', direction))

      -- stop if we're not in a tmux instance
      if TMUX == nil then return end

      if vapi.nvim_get_current_win() == current_window then
         tmux_jump(direction)
      end
   end
end

return {
   jump = jump
}
