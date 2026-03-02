{ lib, config, ... }:

let
  cfg = config.desktop.de.plasma6;
in
{
  config = lib.mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;
  };
}
