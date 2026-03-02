{ pkgs, ... }:
{
  imports = [
    ./blender.nix
  #  ./davinci.nix
    ./figma.nix
    ./gimp.nix
    ./inkscape.nix
  ];
}
