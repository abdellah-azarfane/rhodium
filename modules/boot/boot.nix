{ pkgs, lib, ... }:
{
  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
    kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;
  };
}
