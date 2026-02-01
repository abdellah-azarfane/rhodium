{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.drivers.nvidiaLaptop;
in
{
  options.drivers.nvidiaLaptop = {
    enable = mkEnableOption "NVIDIA (laptop / PRIME) drivers";
  };

  config = mkIf cfg.enable {
    # Kernel modules
    boot.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
      "kvm-intel"
      "kvm"
    ];

    # NVIDIA drivers
    hardware.nvidia = {
      open = false; # Use proprietary drivers
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true; # Required for Wayland
      nvidiaSettings = true; # Enable NVIDIA X settings GUI
      powerManagement.enable = true; # Enable suspend/resume optimizations

      # PRIME offload (Intel + NVIDIA hybrid laptops)
      prime = {
        offload = {
          enable = true; # Enable PRIME offload
          enableOffloadCmd = true; # `prime-run <app>` works
        };
        nvidiaBusId = "PCI:1:0:0"; # Check with `lspci | grep -E "VGA|3D"`
        intelBusId = "PCI:0:2:0"; # Usually Intel iGPU
      };
    };

    # X11 / Wayland drivers
    services.xserver.videoDrivers = [ "nvidia" ];

    # System packages
    environment.systemPackages = with pkgs; [
      egl-wayland # Wayland EGL support
      nvidia-vaapi-driver # Hardware video acceleration (VAAPI)
      libvdpau-va-gl # VDPAU / OpenGL bridge
      cudaPackages.cudatoolkit
      cudaPackages.cudnn
      vulkan-tools-lunarg
      vulkan-tools
    ];

    # harware
    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      # 64-bit graphics and hardware acceleration packages
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        (intel-vaapi-driver.override { enableHybridCodec = true; })
        libva-vdpau-driver
        libvdpau-va-gl
        mesa
        nvidia-vaapi-driver
        nv-codec-headers-12
      ];

      # 32-bit graphics and hardware acceleration packages
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
        (intel-vaapi-driver.override { enableHybridCodec = true; })
        libva-vdpau-driver
        libvdpau-va-gl
        mesa
      ];
    };

    # Session / environment variables
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia"; # VAAPI backend
      __NV_PRIME_RENDER_OFFLOAD = "1";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __VK_LAYER_NV_optimus = "NVIDIA_only";
      NVD_BACKEND = "direct"; # Hardware video acceleration
      ELECTRON_OZONE_PLATFORM_HINT = "auto"; # Electron Wayland flickering fix
      NIXOS_OZONE_WL = "1"; # Electron auto Wayland detection
    };

    # Containers support (Docker, Podman)
    hardware.nvidia-container-toolkit.enable = true;
  };
}
