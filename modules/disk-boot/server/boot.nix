{ lib, pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };

    supportedFilesystems = [ "zfs" ];
    kernelPackages = pkgs.linuxPackages_lts;
  };

  networking.hostId = lib.mkDefault "00000000";
}
