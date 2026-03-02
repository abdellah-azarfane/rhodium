{ lib, config, ... }:

let
  cfg = config.desktop.de.gnome;
in
{
  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  };
}
