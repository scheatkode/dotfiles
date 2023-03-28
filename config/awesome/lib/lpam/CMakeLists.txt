cmake_minimum_required(VERSION 3.15)
project(lpam)

set(CMAKE_C_STANDARD   99)
set(CMAKE_C_EXTENSIONS OFF)
set(SOURCE_DIR         src)

find_package(Lua REQUIRED)

if(NOT LUA_FOUND)
   message(
      FATAL_ERROR
      "Could not find Lua.\n"
      "You might want to hint it using the LUA_DIR environment variable, "
      "or set the LUA_INCLUDE_DIR / LUA_LIBRARY CMake variables."
   )
endif()

include_directories(
   /usr/local/include
   ${LUA_INCLUDE_DIR}
)

add_library(lpam SHARED "${SOURCE_DIR}/main.c")

target_compile_options(lpam PUBLIC
   -Wall
   -Werror
   -Wextra
   -Wpedantic
   -fPIC
   -pipe
   -s
   -shared
   -D_FORTIFY_SOURCE=2
   -Os
)

target_link_libraries(lpam lua pam)
