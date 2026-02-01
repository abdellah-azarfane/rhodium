{ pkgs, ... }:
{
  imports = [
    # ./cursor.nix
    # ./lapce.nix
    ./antigravity.nix
    ./vscodium.nix
    ./rstudio.nix
    ./texmaker.nix
    ./zed.nix
  ];
}
