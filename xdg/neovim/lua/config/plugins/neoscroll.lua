--- neoscroll setup

local ok, neoscroll = pcall(require, 'neoscroll')

if not ok then
   print('‼ Tried loading neoscroll plugin ... unsuccessfully.')
   return ok
end

-- default options

neoscroll.setup({
   no_mappings          = false, -- do not define mappings
   hide_cursor          = true,  -- hide cursor while scrolling
   stop_eof             = true,  -- stop at <eof> when scrolling downwards
   respect_scrolloff    = false, -- stop scrolling when the cursor reaches the scrolloff margin of the file
   cursor_scrolls_alone = true,  -- the cursor will keep on scrolling even if the window cannot scroll further
})
