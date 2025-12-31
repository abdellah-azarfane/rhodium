{ config, lib, pkgs, ... }:
let
  fastfetchConfig = import ./fastfetch/config.nix { inherit lib config; };
in
{
  home.packages = [ pkgs.fastfetch ];

  xdg.dataFile."ascii/calvin-m.txt".source = ../../../assets/calvin-m.txt;
  xdg.dataFile."ascii/rhodium-neo.txt".source = ../../../assets/rhodium-neo.txt;

  xdg.configFile."fastfetch/config.jsonc" = {
    text = builtins.toJSON fastfetchConfig;
    force = true;
  };
}
