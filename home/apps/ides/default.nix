{ pkgs, ... }:
{
  imports = [
     ./cursor.nix
     ./lapce.nix
    ./rstudio.nix
    ./texmaker.nix
    ./vscodium.nix
    ./zed.nix
  ];
}
