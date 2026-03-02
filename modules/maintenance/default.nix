{ config, pkgs, lib, ... }:
let
  cfg = config.maintenance.nhClean;
in
{
  options.maintenance.nhClean = {
    enable = lib.mkEnableOption "Automatic nh cleanup";

    schedule = lib.mkOption {
      type = lib.types.str;
      default = "weekly";
      description = "systemd OnCalendar schedule (e.g. daily, weekly)";
    };

    deleteOlderThan = lib.mkOption {
      type = lib.types.str;
      default = "7d";
      description = "Remove generations older than this (e.g. 7d, 30d)";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services."nh-clean" = {
      description = "nh cleanup service";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.nh}/bin/nh clean generations --older-than ${cfg.deleteOlderThan}";
        ExecStartPost = "${pkgs.nh}/bin/nh clean store --older-than ${cfg.deleteOlderThan}";
      };
    };

    systemd.timers."nh-clean" = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = cfg.schedule;
        Persistent = true;
      };
    };
  };
}
