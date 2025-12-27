{ pkgs, ... }:
{
  imports = [
    ./cadapp.nix
    ./blender.nix
    ./figma.nix
    ./gimp.nix
    ./inkscape.nix
  ];
}
