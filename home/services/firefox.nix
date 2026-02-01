# Rhodium - Firefox Binary Preloader Service
#
# Uses vmtouch to lock Firefox binaries and shared libraries in RAM.
# This ensures instant startup by keeping all code in physical memory.
#
# How it works:
# - vmtouch memory-maps the Firefox installation directory
# - Uses mlock() to pin pages in physical RAM (prevents swapping)
# - Runs as daemon, keeping files locked until service stops
# - When you launch Firefox, binaries are already in RAM = instant startup
#
# Memory impact: ~150-300MB for Firefox libs (less than running Firefox)
# This is NOT the "hidden window" hack - no Firefox process runs
{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.userExtraServices.rh-firefox-preload;
in
{
  options.userExtraServices.rh-firefox-preload = {
    enable = mkEnableOption "Firefox binary preloader using vmtouch (instant startup)";
  };

  config = mkIf cfg.enable {
    # Ensure vmtouch is available
    home.packages = [ pkgs.vmtouch ];

    systemd.user.services.rh-firefox-preload = {
      Unit = {
        Description = "Firefox binary preloader (vmtouch memory lock)";
        Documentation = "https://hoytech.com/vmtouch/";
        # Start early, before graphical session fully loads
        After = [ "basic.target" ];
      };
      Service = {
        Type = "simple";
        # -t: touch (load into page cache)
        # -l: lock pages in physical memory (mlock)
        # -q: quiet mode
        # -f: follow symlinks
        # Target the entire Firefox package in nix store
        ExecStart = "${pkgs.vmtouch}/bin/vmtouch -tlqf ${pkgs.firefox}";
        # vmtouch with -l blocks indefinitely, keeping files locked
        # When service stops, memory is released
        Restart = "on-failure";
        RestartSec = 5;
        # Nice value - low priority for the daemon itself
        Nice = 19;
        IOSchedulingClass = "idle";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
