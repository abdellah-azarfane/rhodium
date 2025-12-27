{ pkgs, ... }:
{
   # Bootloader.
  boot = {
      loader = {
         systemd-boot.enable = true;
         efi.canTouchEfiVariables = true;
         timeout = 2;
         };
      kernelPackages =  pkgs.linuxPackages_zen;
       };
}
