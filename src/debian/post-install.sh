#!/bin/sh -e

ec() {
    echo "$@" >&2
    "$@"
}

case "$1" in
    configure)



        echo "This is a post install script, put whatever you want in here"


        ;;
esac
