{ pkgs, ... }:
{
  # TODO: Fix this
  programs.man.generateCaches = false;

  imports = [
    #   ./fish
  ];

  programs.fish = {
    enable = false;
    package = pkgs.fish;
    #   plugins = fishPlugins;
  };
}
