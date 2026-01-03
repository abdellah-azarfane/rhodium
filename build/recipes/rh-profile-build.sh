#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Profile build time for a given host.
#

APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-profile-build"

COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common"
source "$COMMON_DIR/bootstrap.sh"

usage() {
  echo "Usage: $0 <host>"
  echo "Build (no switch) the specified host and report elapsed time."
  exit 1
}

main() {
  if [ $# -ne 1 ]; then
    usage
  fi

  local host="$1"
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Profiling build for $host"
  print_header "PROFILE BUILD"

  if command -v /usr/bin/time >/dev/null 2>&1; then
    print_pending "Running nixos-rebuild build (timed)"
    sudo /usr/bin/time -f "\nElapsed: %E\nCPU: %P\nMaxRSS: %M KB\n" nixos-rebuild build --flake "${FLAKE_PATH}#${host}" -L
  else
    print_pending "Running nixos-rebuild build (time not available)"
    sudo nixos-rebuild build --flake "${FLAKE_PATH}#${host}" -L
  fi

  print_success "Build finished"
}

main "$@"
