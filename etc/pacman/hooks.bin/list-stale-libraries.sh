#!/bin/sh

# @brief A Pacman hook for listing processes with stale libraries.

set -e
set -u

. /etc/pacman.d/hooks.bin/lib.sh

# @description
#   List the pids of processes with open handles to libraries that have
#   been removed or upgraded.
#
# @example
#   pids_with_open_lib_handles
#
# @stdout The list of pids.
#
# @exitcode 0 If all went well.
# @exitcode * If something bad happened.
pids_with_open_lib_handles() {
	lsof -d DEL 2>/dev/null                \
	| awk '$8 ~ /\/usr\/lib/ { print $2 }' \
	| uniq
}

# @description
#   Transform the given list of pids to process names.
#
# @example
#   pids_to_names 1 # Outputs init
#
# @arg $* (number) The pids to find the names for.
#
# @stdout The process names.
#
# @exitcode 0 If all went well.
# @exitcode * If something bad happened.
pids_to_names() {
	ps -o args= "${@}"          \
	| cut -d' ' -f 1            \
	| awk -F'/' '{ print $NF }' \
	| sort -u
}

# @description
#   Check for process with open handles to stale libraries and list
#   them.
#
# @stdout The list of processes that have open handles to stale
# libraries.
#
# @exitcode 0 If all went well.
# @exitcode * If something bad happened.
main() {
	prereqs \
		awk  \
		cut  \
		lsof \
		ps   \
		sort \
		uniq

	pids="$(pids_with_open_lib_handles)"

	if [ -z "${pids}" ]; then
		return
	fi

	# shellcheck disable=2086
	processes="$(pids_to_names ${pids})"

	if [ -z "${processes}" ]; then
		return
	fi

	cat <<- EOS | fmt -"$(terminal_width)"
		The following processes have stale file handles open to libraries that
		have been upgraded or deleted. Consider restarting them if they should
		reference updated libraries.

	EOS

	for p in ${processes}; do
		echo "- ${p}"
	done
}

main
