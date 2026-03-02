{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Calculators ---
    libqalculate # CLI Calculator
    qalculate-gtk # GUI Calculator
    element # CLI Periodic Table

    # --- Calendars ---
    # kdePackages.korganizer
    # evolution
    # calcurse # CLI calendar
    # calcure # Modern calcurse alternative
    # NOTE: commented because it pulls python `taskw` -> `taskwarrior` which currently fails to build (missing <cstdint> / uint64_t).
    # ulauncher # GUI-based launcher

    # --- Timers ---
    uair
    pom
    openpomodoro-cli
    yad # GUI dialogue for shell scripts
  ];
}
