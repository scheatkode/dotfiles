cmake_minimum_required(VERSION 3.15)
project(usbreset)

set(CMAKE_C_STANDARD   99)
set(CMAKE_C_EXTENSIONS OFF)

add_executable(usbreset usbreset.c)

target_compile_options(usbreset PUBLIC
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
