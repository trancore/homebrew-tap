#!/usr/bin/env bash
set -euo pipefail

report=$(HOMEBREW_NO_COLOR=1 brew install --dry-run --only-dependencies --build-from-source trancore/tap/figfig)
printf '%s\n' "$report"

if grep -Eq 'Would (install|upgrade) [0-9]+ dependenc' <<< "$report"; then
  echo '::error::Homebrew would install or upgrade dependencies before building figfig.'
  exit 1
fi
