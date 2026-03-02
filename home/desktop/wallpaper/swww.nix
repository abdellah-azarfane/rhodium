{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swww # Wallpaper daemon
  ];
}
