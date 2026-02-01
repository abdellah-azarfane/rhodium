{ config, pkgs, ... }:

{
  ## VIRTUALIZATION STACK
  virtualisation = {
    ## PODMAN

    podman = {
      enable = true;

      # you can disable these when using real Docker:

      dockerCompat = false;
      dockerSocket.enable = false;
      defaultNetwork.settings.dns_enabled = true;
    };
    ## LIBVIRT + KVM
    libvirtd.enable = true;

    ## VirtualBox host (only if you need it)

    virtualbox.host.enable = false; # CHANGE TO true if needed
    ## OPTIONAL: Docker (disabled to avoid conflicts)
    docker = {
      enable = true; # set to true if you REALLY need docker
      enableOnBoot = true;
      # gpu support: automatic with nvidia-container-toolkit
      rootless.enable = false;
    };
  };
  ## USERS & GROUPS
  users.groups.libvirtd.members = [ "abosafiya" ];
  users.groups.kvm.members = [ "abosafiya" ];
  users.extraGroups.podman.members = [ "abosafiya" ];
  users.extraGroups.docker.members = [ "abosafiya" ];

  # Uncomment ONLY if you enable docker:
  # users.extraGroups.docker.members = [ "abosafiya" ];
  ## VIRT-MANAGER
  programs.virt-manager.enable = true;
  ## ENVIRONMENT
  environment.variables.DBX_CONTAINER_MANAGER = "podman";
  environment.systemPackages = with pkgs; [
    ## NVIDIA container toolkit
    nvidia-docker

    ## Container tool stack
    podman-compose
    podman-tui
    docker-compose
    lazydocker
    docker-credential-helpers
    nerdctl

    ## VM stack
    qemu
    lima
    virt-manager
    distrobox

    ## Apps
    postman
  ];
  nixpkgs.overlays = [
    (final: prev: {
      winboat = prev.winboat.override {
        makeCacheWritable = true;
        npmFlags = [ "--legacy-peer-deps" ];
      };
    })
  ];
}
