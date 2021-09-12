
function get-uid () { echo "$(id -u)" ; }

function is-root() {
   if [ x"0" != x"$(get-uid)" ] ; then
      return 1
   fi

   return 0
}

function quit-if-not-root () {
   if ! is-root ; then
      echo 'Must be run as root.'
      kill -INT $$
   fi
}

function drop-caches () {
   if ! is-root ; then
      sudo sh -c 'swapoff -a && swapon -a && echo 3 > /proc/sys/vm/drop_caches'
      return 0
   fi

   swapoff -a && swapon -a && echo 3 > /proc/sys/vm/drop_caches
}

