{
  inputs,
  self,
  config,
  lib,
  ...
}:
{
  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostMain
    ];
  };

  flake.nixosModules.hostMain =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.base
        self.nixosModules.nvidia
        self.nixosModules.general
        self.nixosModules.desktop

        #  self.nixosModules.impermanence

        self.nixosModules.discord
        self.nixosModules.gimp
        self.nixosModules.hyprland
        self.nixosModules.telegram
        self.nixosModules.youtube-music

        self.nixosModules.gaming
        self.nixosModules.vr
        self.nixosModules.powersave

        # disko
        inputs.disko.nixosModules.disko
        self.diskoConfigurations.hostMain
      ];
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      # Enable Asus control daemon for fan curves and power profiles
      services.asusd.enable = true;
      services.asusd.enableUserService = true;
      # Enable Supergfxctl for managing my Nvidia GPU
      services.supergfxd.enable = true;
      systemd.services.supergfxd.path = [
        pkgs.pciutils
        pkgs.kmod
      ];
      networking = {
        hostName = "main";
        networkmanager.enable = true;
      };

      virtualisation.libvirtd.enable = true;
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings = {
          dns_enabled = true;
        };
      };

      hardware.cpu.intel.updateMicrocode = true;
      hardware.enableRedistributableFirmware = true;
      services = {
        hardware.openrgb.enable = true;
        flatpak.enable = true;
        udisks2.enable = true;
        printing.enable = true;
      };

      programs.alvr.enable = true;
      programs.alvr.openFirewall = true;

      environment.systemPackages = with pkgs; [
        winetricks
        glib

        bs-manager

        zerotierone

        android-tools
      ];

      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      xdg.portal.enable = true;

      programs.niri.enable = true;
      networking.firewall.enable = false;
      programs.appimage.enable = true;
      programs.appimage.binfmt = true;

      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          obs-move-transition
        ];
      };
      /*
        persistance.cache.directories = [
          ".config/obs-studio"
        ];
      */
      boot.kernelPackages = pkgs.linuxPackages_zen;
      system.stateVersion = "26.05";
    };
}
