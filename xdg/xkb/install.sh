#!/bin/sh

set -e
set -u

LAYOUT="${LAYOUT:-kbd_hexpad}"

platform="$(uname)"
repository_root="$(git rev-parse --show-toplevel || echo .)"

if [ "${platform}" = 'Linux' ]; then
	prefix='/usr/share/X11/xkb'
elif [ "${platform}" = 'FreeBSD' ]; then
	prefix='/usr/local/share/X11/xkb'
else
	echo "Unsupported system '${platform}'"
	exit 1
fi

if [ ! -d "${prefix}" ]; then
	echo "X11 configuration not found at '${prefix}'"
	exit 1
fi

sudo cp -f "${repository_root}/xdg/xkb/symbols/xcustom" "${prefix}/symbols"

tempfile="$(mktemp)"

# shellcheck disable=2064
trap "rm -f ${tempfile}" EXIT

for rule_file in base evdev; do
	if ! grep -q "xcustom:${LAYOUT}" "${prefix}/rules/${rule_file}"; then
		# FreeBSD doesn't support the usual `sed -f - <<SCRIPT` hacks
		sed "/^!\s*option\s*=\s*symbols\$/,/^\$/ {
			/^\$/ i \ \ xcustom:${LAYOUT} = +xcustom(${LAYOUT})
		}" "${prefix}/rules/${rule_file}" > "${tempfile}"

		sudo cp -f "${tempfile}" "${prefix}/rules/${rule_file}"
	fi
done
