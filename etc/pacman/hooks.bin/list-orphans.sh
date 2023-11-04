#!/bin/sh

# @brief A Pacman hook for listing orphan packages.

set -e
set -u

. /etc/pacman.d/hooks.bin/lib.sh

# @description
#   Check for orphan packages and list them.
#
# @stdout The list of orphan packages.
#
# @exitcode 0 If all went well.
# @exitcode 1 If something bad happened.
main() {
	prereqs wc

	orphans="$(pacman -Qtdq | sort -u)"

	if [ -z "${orphans}" ]; then
		return
	fi

	cat <<- EOS | fmt -"$(terminal_width)"
		Found $(echo "${orphans}" | wc -l) orphan packages.

		The following packages have been orphaned, please check and remove any
		that are no longer needed.

	EOS

	for p in ${orphans}; do
		echo "- ${p}"
	done
}

main
