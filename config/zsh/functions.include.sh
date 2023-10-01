#
#          ░█▀▀░█░█░█▀█░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀
#          ░█▀▀░█░█░█░█░█░░░░█░░░█░░█░█░█░█░▀▀█
#          ░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀
#
# shellcheck shell=sh

# Nullify a function's outputs.
_dot_void() {
	"${@}" >/dev/null 2>&1
}

# Nullify a function's error output.
_dot_void_err() {
	"${@}" 2>/dev/null
}

# Nullify a function's standard output.
_dot_void_out() {
	"${@}" >/dev/null
}

# Strip from the left of the given string.
#
# :param 1: The string to strip from.
# :param 2: The string to strip.
# :returns: The stripped string.
_dot_lstrip() {
	printf '%s\n' "${1##"${2}"}"
}

# Strip from the right of the given string.
#
# :param 1: The string to strip from.
# :param 2: The string to strip.
# :returns: The stripped string.
_dot_rstrip() {
	printf '%s\n' "${1%%"${2}"}"
}

# Split the given string.
#
# :param 1: The string to split.
# :param 2: The characters to split the string with.
# :returns: The split string.
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
