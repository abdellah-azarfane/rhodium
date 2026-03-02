{ lib, config, pkgs, ... }:

let
  cfg = config.desktop.wm.mangowc;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.mangowc ];

    xdg.portal.enable = lib.mkDefault true;
    xdg.portal.wlr.enable = lib.mkDefault true;
  };
}
