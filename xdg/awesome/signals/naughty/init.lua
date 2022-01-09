local naughty = require('naughty')

return {
   ['request::display_error'] = function (message, startup)
      naughty.notification({
         urgency = 'critical',
         title   = 'Oops, an error happened'
            .. (startup and ' during startup ' or ' ')
            .. '!',
         message = message,
      })
   end,

   ['request::display'] = function (n)
      naughty.layout.box({
         notification = n,
      })
   end,

}
