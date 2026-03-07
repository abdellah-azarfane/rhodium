{
  #flake.nixosModules.solace-disko = { ... }: {
  disko.devices = {

    # 1. Mount /tmp in RAM to save your SSD and speed up builds
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=4G" # Limit /tmp to 4GB of RAM
        "defaults"
        "mode=777"
      ];
    };

    disk.main = {
      device = "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {

          esp = {
            size = "1G"; # 1GB is perfect for NixOS multiple boot generations
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ]; # Security best practice for EFI
            };
          };

          swap = {
            size = "16G"; # Increased to 16G so your laptop can actually hibernate safely!
            content = {
              type = "swap";
              resumeDevice = true; # Allow the laptop to wake up from hibernation
            };
          };

          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ]; # Force format
              # Optimized Mount Options for your NVMe SSD
              mountOptions = [
                "compress=zstd:1" # Lightning fast compression
                "noatime" # Don't waste SSD writes recording file access times
                "discard=async" # Keep the NVMe blazing fast and healthy
                "space_cache=v2" # Modern BTRFS performance tweak
              ];

              # Your excellent subvolume layout stays the same
              subvolumes = {
                "@root" = {
                  mountpoint = "/";
                };
                "@home" = {
                  mountpoint = "/home";
                };
                "@nix" = {
                  mountpoint = "/nix";
                };
                "@log" = {
                  mountpoint = "/var/log";
                };
                "@persist" = {
                  mountpoint = "/persist";
                };
              };
            };
          };

        };
      };
    };
  };
  #  };
}
