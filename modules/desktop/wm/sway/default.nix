{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.desktop.wm.sway;
in
{
  config = mkIf cfg.enable {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    environment.systemPackages = with pkgs; [
      sway
      swaylock
      swayidle
      wl-clipboard
      wlr-randr
    ];

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
