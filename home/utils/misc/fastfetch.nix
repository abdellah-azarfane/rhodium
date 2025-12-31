{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fastfetch # Faster disfetch
  ];

  xdg.dataFile."ascii/calvin-m.txt".source = ../../../assets/calvin-m.txt;

  xdg.configFile."fastfetch/config.jsonc" = {
    source = ./fastfetch/config.jsonc;
    force = true;
  };
}
