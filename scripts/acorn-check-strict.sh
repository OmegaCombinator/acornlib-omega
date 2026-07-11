#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
if repo_root="$(git -C "$script_dir" rev-parse --show-toplevel 2>/dev/null)"; then
    cd "$repo_root"
else
    cd "$script_dir/.."
fi

if [[ -n "${ACORN_BIN:-}" ]]; then
    acorn_bin="$ACORN_BIN"
elif [[ -x /mnt/bin/acorn-0.2.4-linux-x64 ]]; then
    acorn_bin=/mnt/bin/acorn-0.2.4-linux-x64
else
    acorn_bin=acorn
fi

printf 'Using Acorn: %s\n' "$acorn_bin"
"$acorn_bin" --version
"$acorn_bin" check --strict "$@"
