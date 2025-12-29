{ pkgs-unstable, ... }:
{
  imports = [
  ];

  programs.antigravity = {
    enable = true;
    package = pkgs-unstable.antigravity;
  };
}

