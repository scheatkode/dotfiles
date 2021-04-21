-- check if a  table is used as an  array; that is, the keys start  with 1 and
-- are sequential
--
-- @param  table   table
-- @return boolean if table is/isn't an array
--
-- NOTE: returns true for an empty table

local function is_array(table)
   -- error out early if the passed argument is not even a table.

   if type(table) ~= 'table' then
      return false
   end

   -- check if the table keys are numerical and count them.

   local count = 0

   for k,_ in pairs(table) do
      if type(k) ~= 'number' then
         return false
      else
         count = count + 1
      end
   end

   -- all keys are numerical so far, see if they're sequential and start with 1.

   for i = 1, count do
      -- hint : the value might be 'nil', in that case 'not table[i]' is not
      -- enough, hence the type check.

      if not table[i] and type(table[i]) ~= 'nil' then
         return false
      end
   end

   -- we made sure of the aforementioned conditions, return true

   return true
end


local function apply(autocmds)
   -- make sure we're dealing with an array and not something else

   if not is_array(autocmds) then
      error('expected array, got ' .. type())
   end

   -- iterate over the array and define the autocommands in neovim

   for _, cmd in ipairs(autocmds) do
      print(tostring(cmd))
      -- vim.api.nvim_exec(unpack(cmd))
   end
end


local autocommands = {

   -- show cursorline only in windows which have focus

   {{'WinEnter','FocusGained'}, {}, 'set cursorline'},
   {{'WinLeave','FocusLost'},   {}, 'set nocursorline'},

   -- update a buffer's contents on focus if it changed outside the editor

   {{'FocusGained','BufEnter'}, {}, 'checktime'},

   -- clear stale messages under the status line after the defined timeout

   {{'CursorHold'}, {}, 'echo'},

   -- unset paste mode when exiting insert mode

   {{'InsertLeave'}, {}, 'silent! set nopaste'},

   -- set crlf line endings for windows scripting languages

   {{'FileType'}, {'cmd', 'ps1'}, 'setlocal fileformat=dos'},

   -- remove all trailing whitespaces

   {{'BufWritePre'}, {}, '%s/\\s\\+$//'},
}

local test = table.concat({}, '|')

print(#test == 0)
apply(autocommands)

-- vim: set sw=3 ts=3 sts=3 et tw=80
