#!/bin/sh

# @brief A Pacman hook for listing setuid/getcap binaries.

set -e
set -u

. /etc/pacman.d/hooks.bin/lib.sh

# @description
#   Display the binaries list.
#
# @stdout The formatted list of binaries.
#
# @exitcode 0 Always.
display() {
	cat <<- EOS | fmt -"$(terminal_width)"
		Found $(printf "%s" "${2}" | wc -l) ${1} binaries. Please review
		and take appropriate action.

	EOS

	for b in ${2}; do
		echo "- ${b}"
	done
}

# @description
#   Check for setuid/getcap binaries and list them.
#
# @stdout The list of setuid/getcap binaries.
#
# @exitcode 0 If all went well.
# @exitcode 1 If something bad happened.
main() {
	prereqs getcap wc

	with_setuid=''
	with_getcap=''

	nl='
'

	while read -r file; do
		if ! [ -f "${file}" ] || ! [ -x "${file}" ]; then
			continue
		fi

		if [ -u "${file}" ]; then
			with_setuid="${with_setuid}${nl}${file}"
		elif [ -n "$(getcap "${file}" 2>/dev/null)" ]; then
			with_getcap="${with_getcap}${nl}${file}"
		fi
	done

	if [ -n "${with_setuid}" ]; then
		display setuid "${with_setuid}"

		if [ -n "${with_getcap}" ]; then
			echo
		fi
	fi

	if [ -n "${with_getcap}" ]; then
		display getcap "${with_getcap}"
	fi
}

main
