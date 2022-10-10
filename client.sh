#!/bin/sh
set -e

um="$(umask)"
if [ "$um" = '0022' ]; then
	umask 0077
fi

./client -worker=10 -rps=5 -origin=http://origin:8000