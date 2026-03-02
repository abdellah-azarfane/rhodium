{ pkgs, ... }:
{
  programs = {
    neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
    };

    vim = {
      enable = true;
    };
  };
}
