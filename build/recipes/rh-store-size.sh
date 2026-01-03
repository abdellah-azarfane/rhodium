#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Show store size by path for the current system closure (or a provided path).
#

APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-store-size"

COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common"
source "$COMMON_DIR/bootstrap.sh"

usage() {
  echo "Usage: $0 [storePath]"
  echo "Show closure sizes for paths in a closure (default: /run/current-system)."
  echo "Examples:"
  echo "  $0"
  echo "  $0 /run/current-system"
  echo "  $0 nixpkgs#hello"
  exit 1
}

main() {
  if [ $# -gt 1 ]; then
    usage
  fi

  local target="${1:-/run/current-system}"
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Computing closure sizes for: $target"
  print_header "STORE SIZE"

  if ! command -v nix >/dev/null 2>&1; then
    print_error "nix command not found"
    exit 127
  fi

  print_pending "Top closure entries (sorted)"
  set +o pipefail
  nix path-info --recursive --closure-size --human-readable "$target" 2>/dev/null | sort -hr -k2 | head -n 50
  local nix_status=${PIPESTATUS[0]}
  set -o pipefail
  if [ "$nix_status" -ne 0 ]; then
    print_error "Failed to query path info for: $target"
    exit 1
  fi

  echo
  print_pending "Total Nix store (approx)"
  du -sh /nix/store 2>/dev/null | sed 's/^/  /' || true
}

main "$@"
