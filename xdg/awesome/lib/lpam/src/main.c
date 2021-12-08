#include <pwd.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <security/pam_appl.h>

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

#if LUA_VERSION_NUM == 501

#  define export_module(L, l) luaL_register(L, "lpam", l)

#elif LUA_VERSION_NUM == 502

#  define export_module(L, l) do { \
      lua_getglobal(L, "lpam");    \
      if (lua_isnil(L, -1)) {      \
         lua_pop(L, 1);            \
         lua_newtable(L);          \
      }                            \
      luaL_setfuncs(L, l, 0);      \
      lua_setglobal(L, "lpam");    \
   } while(0)

#elif LUA_VERSION_NUM > 502

#  define export_module(L, l) luaL_newlib(L, l)

#endif

static struct pam_response * reply;

static char * strdup(const char * source)
{
   size_t len = strlen(source) + 1;
   char * new = (char *) malloc(len);

   if (new == NULL) {
      return new;
   }

   memcpy(new, source, len);
   return new;
}

inline static int is_null_or_empty(const char * s) {
   return s == NULL || s[0] == '\0';
}

static int converse_for_authentication(
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

   if (is_null_or_empty(password)) {
      lua_pushboolean(L, 0);
      return 1;
   }

   struct passwd * passwd     = getpwuid(getuid());
   const char    * username   = passwd->pw_name;
   pam_handle_t  * pam_handle = NULL;

   struct pam_conv conversation = {
      converse_for_authentication, NULL
   };

   if (NULL == (reply = calloc(1, sizeof(struct pam_response)))) {
      lua_pushboolean(L, 0);
      return 1;
   }

   if (PAM_SUCCESS != pam_start("login", username, &conversation, &pam_handle)) {
      lua_pushboolean(L, 0);
      return 1;
   }

   reply->resp = strdup(password);
   reply->resp_retcode = 0;

   if (PAM_SUCCESS != (return_value = pam_authenticate(pam_handle, 0))) {
      lua_pushboolean(L, 0);
      return 1;
   }

   lua_pushboolean(L, 1);
   pam_end(pam_handle, return_value);

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
