{ pkgs, ... }:
{
  imports = [
    ./vscodium
  ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };
}
