{ lib, config, ... }:

let
  cfg = config.desktop.de.xfce;
in
{
  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.desktopManager.xfce.enable = true;
  };
}
