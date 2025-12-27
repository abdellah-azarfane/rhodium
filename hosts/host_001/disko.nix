# disko/disk-config.nix
{
  disko.devices = {
    disk.main = {
      device = "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            size = "1024M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };

          swap = {
            size = "8G";
            content = {
              type = "swap";
              randomEncryption = true;
            };
          };

          root = {
            size = "100%";
            content = {
              type = "btrfs";
              mountpoint = "/";
              extraArgs = ["-f"]; # force format
              mountOptions = ["compress=zstd" "noatime" "ssd"];
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
}
