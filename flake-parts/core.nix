{ ... }:
{
  perSystem = { pkgs, config, ... }: {
    devShells = {
      default = import ../devshells/nixos.nix { inherit pkgs; nvim = config.packages.nvim or null; };
      nixos = import ../devshells/nixos.nix { inherit pkgs; nvim = config.packages.nvim or null; };
    };
  };
}
