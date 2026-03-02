{ pkgs, ... }:
{
  imports = [
  ];

  home.packages = with pkgs; [
    gping # Better ping (includes graph)
    doggo # Command line dns client
  ];
}
