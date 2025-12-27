{ fishPlugins, pkgs-unstable, ... }:
{
  # TODO: Fix this
  programs.man.generateCaches = false;

  imports = [
    ./fish
  ];

  programs.fish = {
    enable = true;
    package = pkgs-unstable.fish;
    plugins = fishPlugins;
  };
}
