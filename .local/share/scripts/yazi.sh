#!/usr/bin/env sh

set -euo pipefail

export tmp="$(mktemp -t "yazi-pwd.XXXXXX")" pwd
yazi "$@" --cwd-file="$tmp"
if pwd="$(cat -- "$tmp")" && [ -n "$pwd" ] && [ "$pwd" != "$PWD" ]; then
    builtin cd -- "$pwd"
fi
rm -f -- "$tmp"
