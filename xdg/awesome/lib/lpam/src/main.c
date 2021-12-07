#include <pwd.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <security/pam_appl.h>

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

#define PAM_SERV_NAME "login"

#if LUA_VERSION_NUM == 501
#  define export_module(L, l) luaL_register(L, "lpam", l)
#elif LUA_VERSION_NUM == 502
#  define export_module(L, l) luaL_setfuncs(L, l, 0) // TODO(scheatkode): cleanup and and check metatable exists
#elif LUA_VERSION_NUM > 502
#  define export_module(L, l) luaL_newlib(L, l)
#endif

static struct pam_response * reply;

static char * strdup(const char * s)
{
   size_t size = strlen(s);
   char * new = (char *)malloc(size);

   if (new) {
      memcpy(new, s, size);
   }

   return new;
}

static int simple_authentication_conversation(
   int                         message_number,
   const struct pam_message ** messages,
   struct pam_response **      response,
   void *                      application_data
) {
   (void) message_number;
   (void) messages;
   (void) application_data;

   *response = reply;

   return PAM_SUCCESS;
}

static int authenticate_current_user(lua_State * L)
{
   int return_value;

   const char * password = luaL_checkstring(L, -1);

   struct passwd * passwd   = getpwuid(getuid());
   const char    * username   = passwd->pw_name;
   pam_handle_t  * pam_handle = NULL;

   struct pam_conv conversation = {
      simple_authentication_conversation, NULL
   };

   return_value = pam_start(PAM_SERV_NAME, username, &conversation, &pam_handle);
   reply        = (struct pam_response *) malloc(sizeof(struct pam_response));

   if (return_value == PAM_SUCCESS) {
      reply->resp = strdup(password);
      reply->resp_retcode = 0;

      return_value = pam_authenticate(pam_handle, 0);
      lua_pushboolean(L, 1);

      free(reply->resp);
   } else {
      lua_pushboolean(L, 0);
   }

   pam_end(pam_handle, return_value);
   free(reply);
   return 1;
}

static const struct luaL_Reg lpam[] = {
   {"authenticate_current_user", authenticate_current_user}, {NULL, NULL}
};

int luaopen_liblpam(lua_State * L)
{
   export_module(L, lpam);
   return 1;
}
