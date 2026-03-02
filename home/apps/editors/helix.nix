{ pkgs, ... }:
{
  imports = [
    ./helix
  ];

  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
  };
}
