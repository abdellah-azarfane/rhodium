#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Find largest paths in the Nix store by closure size.
#

APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-largest-paths"

COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common"
source "$COMMON_DIR/bootstrap.sh"

usage() {
  echo "Usage: $0 [count] [target]"
  echo "Show the largest closure entries for target (default: /run/current-system)."
  echo "  count  Number of entries to show (default: 30)"
  echo "  target Closure root (default: /run/current-system)"
  exit 1
}

main() {
  if [ $# -gt 2 ]; then
    usage
  fi

  local count="${1:-30}"
  local target="${2:-/run/current-system}"

  if ! [[ "$count" =~ ^[0-9]+$ ]]; then
    print_error "count must be a number"
    usage
  fi

  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Finding largest paths for: $target"
  print_header "LARGEST PATHS"

  if ! command -v nix >/dev/null 2>&1; then
    print_error "nix command not found"
    exit 127
  fi

  print_pending "Top $count by closure size"
  set +o pipefail
  nix path-info --recursive --closure-size --human-readable "$target" 2>/dev/null | sort -hr -k2 | head -n "$count"
  local nix_status=${PIPESTATUS[0]}
  set -o pipefail
  if [ "$nix_status" -ne 0 ]; then
    print_error "Failed to query path info for: $target"
    exit 1
  fi
}

main "$@"
