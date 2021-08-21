#!/bin/sh

if                                          \
      [ x"${DISPLAY}" != x"" ]              \
   && command -v setxkbmap > /dev/null 2>&1 \
; then # X server should be working
   setxkbmap -option 'keypad:pointerkeys'
   echo 'All good, press <S-NumPad> to activate.'
else
   echo 'Something went wrong, check your X server.'
fi
