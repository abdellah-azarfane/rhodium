{ pkgs, ... }:
{
  environment.shells = with pkgs; [
    zsh
    bash
    fish
    nushell
    xonsh
  ];

  programs = {
    zsh.enable = true;
    bash.completion.enable = true; # Required for home setting
    fish.enable = true;
    command-not-found.enable = false; # Required for fish
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
}
