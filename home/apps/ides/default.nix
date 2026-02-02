{ pkgs, ... }:
{
  imports = [
    # ./cursor.nix
    # ./lapce.nix
    ./antigravity
    ./vscodium.nix
    ./rstudio.nix
    ./texmaker.nix
    ./zed.nix
  ];
}
