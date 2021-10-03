#!/bin/sh

if [ -z "${DISPLAY+x}" ] ; then
   echo "Something's wrong, check your X server."
   return 1
fi

# -- X server should be working
if ! command -v setxkbmap > /dev/null 2>&1 ; then
   echo "Something's wrong, I can't seem to find the 'setxkbmap' command."
   return 1
fi

# -- `setxkbmap` command is available
setxkbmap -option 'ctrl:nocaps' \
   && echo 'All good, your CapsLock should be mapped to the Ctrl key now'

