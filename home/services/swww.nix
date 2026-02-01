{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.userExtraServices.rh-swww;
in
{
  options.userExtraServices.rh-swww = {
    enable = mkEnableOption "swww wallpaper daemon";
  };

  config = mkIf cfg.enable {
    # Ensure the package is actually installed in the user profile
    home.packages = [ pkgs.swww ];

    systemd.user.services.rh-swww = {
      Unit = {
        Description = "Efficient animated wallpaper daemon for Wayland";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ]; # Ensure the compositor is fully up
      };

      Service = {
        Type = "simple";
        # Use swww-daemon
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "on-failure";
        RestartSec = 1;
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
