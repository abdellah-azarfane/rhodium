{ pkgs, ... }:
{
  imports = [
  ];

  home.packages = with pkgs; [
    doggo # Command line dns client
    gping # Better ping (includes graph)
    netscanner # TUI network scanner
  ];
}
