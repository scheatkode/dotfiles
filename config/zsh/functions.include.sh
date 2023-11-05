#
#          ░█▀▀░█░█░█▀█░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀
#          ░█▀▀░█░█░█░█░█░░░░█░░░█░░█░█░█░█░▀▀█
#          ░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀
#
# shellcheck shell=sh

# Nullify a command's outputs.
#
# @arg $* (anything) The command to run.
#
# @exitcode * The exitcode of the given command.
_dot_void() {
	"${@}" >/dev/null 2>&1
}

# Nullify a command's error output.
#
# @arg $* (anything) The command to run.
#
# @exitcode * The exitcode of the given command.
_dot_void_err() {
	"${@}" 2>/dev/null
}

# Nullify a command's standard output.
#
# @arg $* (anything) The command to run.
#
# @exitcode * The exitcode of the given command.
_dot_void_out() {
	"${@}" >/dev/null
}

# Strip from the left of the given string.
#
# @arg $1 (string) The string to strip from.
# @arg $2 (string) The string to strip.
#
# @stdout The stripped string.
#
# @exitcode 0 Always.
_dot_lstrip() {
	printf '%s\n' "${1##"${2}"}"
}

# Strip from the right of the given string.
#
# @arg $1 (string) The string to strip from.
# @arg $2 (string) The string to strip.
#
# @stdout The stripped string.
#
# @exitcode 0 Always.
_dot_rstrip() {
	printf '%s\n' "${1%%"${2}"}"
}

# Split the given string.
#
# @arg $1 (string) The string to split.
# @arg $2 (string) The characters to split the string with.
#
# @stdout The split string.
#
# @exitcode 0 Always.
_dot_split() {
	set -f
	__ye_olde_ifs=${IFS}
	IFS=${2}

	# shellcheck disable=2086
	set -- ${1}

	printf '%s\n' "${@}"

	IFS=${__ye_olde_ifs}
	set +f

	unset __ye_olde_ifs
}

# Check for the availability of a command/function.
#
# @arg $1 (string) The command/function name to check for.
#
# @exitcode 0 If the command/function exists.
# @exitcode 1 If the command/function does not exist.
_dot_has() {
	_dot_void command -v "${1}"
}
