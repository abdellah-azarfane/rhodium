{ inputs, ... }:
{
  flake.nixosModules.extra_impermanence =
    {
      lib,
      config,
      ...
    }:
    let
      inherit (lib)
        mkIf
        mkDefault
        mkAfter
        ;
      cfg = config.persistance;
    in
    {
      imports = [
        inputs.impermanence.nixosModules.impermanence
      ];

      config = mkIf cfg.enable {
        # This matches the @persist mountpoint in your disko.nix
        fileSystems."/persist".neededForBoot = true;

        programs.fuse.userAllowOther = true;

        boot.tmp.cleanOnBoot = mkDefault true;

        environment.persistence = {
          "/persist/userdata".users."${cfg.user}" = {
            directories = cfg.data.directories;
            files = cfg.data.files;
          };

          "/persist/usercache".users."${cfg.user}" = {
            directories = cfg.cache.directories;
            files = cfg.cache.files;
          };

          "/persist/system" = {
            hideMounts = true;
            directories = [
              "/etc/nixos"
              "/var/log"
              "/var/lib/bluetooth"
              "/var/lib/nixos"
              "/var/lib/systemd/coredump"
              "/etc/NetworkManager/system-connections"
              "/tmp"
              "/var/lib/zerotier-one"
            ]
            ++ cfg.directories;
            files = [
              "/etc/machine-id"
              # Removed /etc/lact/config.yaml because you use an Intel/Nvidia Asus laptop, not AMD!
              {
                file = "/var/keys/secret_file";
                parentDirectory = {
                  mode = "u=rwx,g=,o=";
                };
              }
            ]
            ++ cfg.files;
          };
        };

        # The BTRFS Rollback Script adapted for your @root subvolume
        boot.initrd.postDeviceCommands = mkIf cfg.nukeRoot.enable (mkAfter ''
          mkdir -p /btrfs_tmp

          # Mount the physical partition containing your BTRFS filesystem.
          # Since you use /dev/nvme0n1 and standard GPT partitioning in disko, 
          # your root partition is typically partition 3 (after esp and swap).
          mount /dev/nvme0n1p3 /btrfs_tmp

          # Target your specific '@root' subvolume
          if [[ -e /btrfs_tmp/@root ]]; then
              mkdir -p /btrfs_tmp/old_roots
              timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/@root)" "+%Y-%m-%-d_%H:%M:%S")
              mv /btrfs_tmp/@root "/btrfs_tmp/old_roots/$timestamp"
          fi

          delete_subvolume_recursively() {
              IFS=$'\n'
              for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                  delete_subvolume_recursively "/btrfs_tmp/$i"
              done
              btrfs subvolume delete "$1"
          }

          for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
              delete_subvolume_recursively "$i"
          done

          # Create a fresh '@root' subvolume for the new boot
          btrfs subvolume create /btrfs_tmp/@root
          umount /btrfs_tmp
        '');
      };
    };
}
