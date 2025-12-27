{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # alejandra # Opinionated formatter
    nil # Nix language server (original)
    nixd # Nix language server (newer)
    nixfmt-rfc-style # Official formatter
    # nixpkgs-fmt # Formatter
  ];
  nix.settings = {
   download-buffer-size = 33554432; # 32 MiB
 };
}
