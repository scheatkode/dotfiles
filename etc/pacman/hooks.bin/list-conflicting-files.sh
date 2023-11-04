#!/bin/sh

# @brief Pacman hook for listing pacnew/pacsave files.

set -e
set -u

. /etc/pacman.d/hooks.bin/lib.sh

# @description
#   Check for pacnew/pacsave files and list them.
#
# @stdout The list of pacnew/pacsave files.
#
# @exitcode 0 Always.
main() {
	prereqs    \
		pacdiff \
		wc

	pacfiles="$(pacdiff -o)"

	if [ -z "${pacfiles}" ]; then
		return
	fi


	cat <<-EOS | fmt -"$(terminal_width)"
		Found $(printf "%s" "${pacfiles}" | wc -l) pacnew/pacsave files.

		The following files may have conflicts with newer versions, please check
		and merge with pacdiff.

	EOS

	for p in ${pacfiles}; do
		echo "- ${p}"
	done
}

main
