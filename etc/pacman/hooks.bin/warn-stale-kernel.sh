#!/bin/sh

set -e
set -u

. /etc/pacman.d/hooks.bin/lib.sh

installed_kernel() {
	ver=0

	for field in $(file /boot/vmlinuz-linux*); do
		if [ "${ver}" -eq '1' ]; then
			echo "${field}"
			return
		elif [ "${field}" = 'version' ]; then
			# The next field contains the version
			ver=1
		fi
	done
}

main() {
	prereqs \
		file \
		fmt

	active="$(uname -r)"
	current="$(installed_kernel)"

	if [ "${active}" = "${current}" ]; then
		return
	fi

	cat <<-EOS | fmt -"$(terminal_width)"
		The kernel has been updated from ${active} to ${current}, which may
		cause some processes to malfunction. Consider rebooting the computer.
	EOS
}

main
