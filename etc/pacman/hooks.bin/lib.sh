#!/bin/false
# shellcheck shell=sh
#
# @brief Shared library for pacman hooks.

# @description
#   Test if a command exists. Usable in conditions.
#
# @example
#   if has some_command; then
#     echo "some_command exists"
#   fi
#
#   if ! has does_not_exist; then
#     echo "does_not_exist does not exist"
#   fi
#
# @arg $1 (string) The name of the command to test for.
#
# @exitcode 0 When the command exists.
# @exitcode 1 When the command does not exist.
has() {
	command -v "${1}" >/dev/null 2>&1
}

# @description
#   Assert the availability of the given commands.
#
# @example
#   prereqs ls cat # `ls` and `cat` must exist after this point.
#
# @arg $* (string) The names of commands for which to assert the availability.
#
# @exitcode 0 When all the prerequisites exist.
# @exitcode 1 When any of the prerequisites does not exist.
prereqs() {
	missing=''
	nl='
'

	set -- "${@}" fmt

	for cmd in "${@}"; do
		if ! has "${cmd}"; then
			missing="${missing}${nl}- ${cmd}"
		fi
	done

	if [ -z "${missing}" ]; then
		return 0
	fi

	cat <<- EOS | fmt -"$(terminal_width)"
		The following dependencies are necessary for the upgrade notifier hook
		but were not found:
		${missing}
	EOS

	exit 1
}

# @description
#   Returns the current terminal width.
#
# @example
#   terminal_width    # Outputs the current terminal width capped at 78.
#   terminal_width 50 # Outputs the current terminal width capped at 50.
#
# @arg $1 (number) The boundary of the terminal width.
#
# @stdout The terminal width.
#
# @exitcode 0 Always.
terminal_width() {
	max_width="${1-78}"

	if has tput; then
		cols="$(tput cols)"

		if [ "${cols}" -le "${max_width}" ]; then
			echo "${cols}"
			return
		fi
	fi

	echo "${max_width}"
}
