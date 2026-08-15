#!/usr/bin/env sh

set -eou pipefail

if command -v prime-run >/dev/null 2>&1; then
  prime-run "$@"
elif command -v nvidia-offload >/dev/null 2>&1; then
  nvidia-offload "$@"
else
  exec "$@"
fi
