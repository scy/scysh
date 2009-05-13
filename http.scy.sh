#!/bin/sh

http_get() {
	if which curl 2>/dev/null; then
		curl -s "$@"
	elif which wget 2>/dev/null; then
		wget -q -O - "$@"
	else
		die 1 'cannot retrieve via HTTP: no tool'
	fi
}
