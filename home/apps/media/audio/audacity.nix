{ pkgs, ... }:
{
  home.packages = with pkgs; [
    audacity
    audacious
    audacious-plugins
  ];
}
