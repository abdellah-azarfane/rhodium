{ lib, config, pkgs, ... }:

let
  cfg = config.desktop.wm.river;

  # In newer nixpkgs, `river` was renamed to `river-classic`.
  riverPkg = if pkgs ? "river-classic" then pkgs."river-classic" else pkgs.river;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ riverPkg ];

    xdg.portal.enable = lib.mkDefault true;
    xdg.portal.wlr.enable = lib.mkDefault true;
  };
}
