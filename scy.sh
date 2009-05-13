#!/bin/sh

if [ -n "$BASH_VERSION" ]; then
	export SCYSHDIR="$(dirname "${BASH_SOURCE[0]}")"
else
	export SCYSHDIR="$(dirname "$0")"
fi

die() {
	rc="$1"
	shift
	echo "$@" >&2
	exit "$rc"
}

include() {
	if [ "$#" -eq 1 ]; then
		module="$(echo "$1" | tr -cd 0-9a-z_-)"
		if [ -z "$module" ]; then
			echo 'include: no module name left after stripping invalid stuff' >&2
			return 1
		fi
		modpath="$SCYSHDIR/$module.scy.sh"
		if [ -r "$modpath" ]; then
			source "$modpath"
		else
			echo "include: no such module: $module" >&2
			return 1
		fi
	else
		for module in "$@"; do
			include "$module"
		done
	fi
}
