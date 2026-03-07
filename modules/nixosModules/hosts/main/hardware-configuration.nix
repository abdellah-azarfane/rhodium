{
  flake.nixosModules.hostMain =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];
      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "vmd"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
      boot.kernelParams = [
        "quiet"
        "splash"
        "intel_pstate=active" # Modern Intel scaling for Zen
      ];
      boot.kernelModules = [
        "binder_linux"
        "ashmem_linux"
        "kvm-intel"
        "asus-nb-wmi"
        "asus_armoury"
      ];
      boot.extraModprobeConfig = ''
        options binder_linux
        options ashmem_linux
      '';
      boot.extraModulePackages = [ ];
      networking.useDHCP = lib.mkDefault true;
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
