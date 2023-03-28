#include <errno.h>
#include <pwd.h>               //! `getpwuid()`
#include <stdlib.h>            //! `malloc()`
#include <string.h>            //! `strlen()` and `memcpy()`
#include <unistd.h>            //! `getuid()`

#include <security/pam_appl.h> //! `pam_*()` and `PAM_*`

#include <lua.h>
#include <lauxlib.h>

/*!
 * Different  Lua  versions  have  different  exporting
 * mechanisms.
 */
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

/*!
 * Helper function  to verify whether the  given string
 * `s` is null  or empty. Empty meaning  it contains no
 * characters.
 */
inline static int is_null_or_empty(const char * s) {
   return s == NULL || s[0] == '\0';
}

/*!
 * Dummy conversation function which  only sets the pam
 * response struct with the stored password.
 */
static int converse_for_authentication(
   int                         message_number,
   const struct pam_message ** messages,
   struct pam_response **      response,
   void *                      application_data
) {
   (void) messages;

   const char * password = (const char *) application_data;

   if (
         message_number != 1
      || is_null_or_empty(password)
   ) {
      return PAM_CONV_ERR;
   }

   struct pam_response * reply;

   if (NULL == (reply = malloc(sizeof(struct pam_response)))) {
      return PAM_BUF_ERR;
   }

   const size_t size = strlen(password) + 1;

   if (NULL == (reply->resp = malloc(size))) {
      free(reply);
      return PAM_BUF_ERR;
   }

   strncpy(reply->resp, password, size);

   reply->resp_retcode = 0;
   *response = reply;

   return PAM_SUCCESS;
}

/*!
 * This function  is exported  to the Lua  runtime and,
 * given  a password,  authenticates  the current  user
 * using the PAM builtin "login" service.
 */
int authenticate_current_user(lua_State * L)
{
   const char * password = luaL_checkstring(L, -1);

   if (is_null_or_empty(password)) {
      lua_pushboolean(L, 0);
      return 1;
   }

   struct pam_conv conversation = {
      .appdata_ptr = (void *) password,
      .conv        = converse_for_authentication,
   };

   struct passwd * passwd     = getpwuid(getuid());
   const  char   * username   = passwd->pw_name;
   pam_handle_t  * pam_handle = NULL;

   if (PAM_SUCCESS != pam_start("login", username, &conversation, &pam_handle)) {
      lua_pushboolean(L, 0);
      return 1;
   }

   int return_value = 1;

   if (
         PAM_SUCCESS != pam_authenticate(pam_handle, PAM_DISALLOW_NULL_AUTHTOK)
      || PAM_SUCCESS !=    pam_acct_mgmt(pam_handle, PAM_DISALLOW_NULL_AUTHTOK)
   ) {
      return_value = 0;
   }

   pam_end(pam_handle, PAM_SUCCESS);
   lua_pushboolean(L, return_value);

   return 1;
}

/*!
 * This object  stores the  functions available  to Lua
 * when exporting the module.
 */
static const struct luaL_Reg lpam[] = {
   { "authenticate_current_user", authenticate_current_user },
   { NULL,                        NULL                      },
};

/*!
 * This function  exports the  object defined  above to
 * the Lua runtime.
 */
int luaopen_liblpam(lua_State * L)
{
   export_module(L, lpam);
   return 1;
}
