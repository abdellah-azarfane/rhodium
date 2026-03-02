{ config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.userExtraServices.astal;
  system = pkgs.stdenv.hostPlatform.system;
  astalPkg = inputs.self.packages.${system}.astal-widgets;
in
{
  options.userExtraServices.astal = {
    enable = lib.mkEnableOption "Enable Astal widgets";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ astalPkg ];

    systemd.user.services.rh-astal = {
      Unit = {
        Description = "Astal Widgets";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Environment = [ "PATH=${config.home.profileDirectory}/bin:/run/current-system/sw/bin" ];
        ExecStart = "${astalPkg}/bin/astal-widgets";
        Restart = "on-failure";
        RestartSec = 5;
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
