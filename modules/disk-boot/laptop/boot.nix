{ config, lib, pkgs, ... }:
let
   cfg = config.diskBoot;
in
lib.mkIf (cfg.enable && cfg.profile == "laptop") {
   # Bootloader.
   boot = {
      loader = {
         systemd-boot.enable = true;
         efi.canTouchEfiVariables = true;
         timeout = 2;
      };
      kernelPackages = pkgs.linuxPackages_zen;
   };
}
