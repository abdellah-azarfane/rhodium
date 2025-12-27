{ pkgs-unstable, ... }:
{
  # TODO: Fix this
  programs.man.generateCaches = false;

  imports = [
    #   ./fish
  ];

  programs.fish = {
    enable = false;
    package = pkgs-unstable.fish;
    #   plugins = fishPlugins;
  };
}
