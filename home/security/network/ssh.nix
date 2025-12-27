{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.home-manager.users.zayron.programs.ssh;
in
{
  options.home-manager.users.zayron.programs.ssh.matchBlocks = mkOption {
    type = types.listOf (types.submodule {
      options = {
        host = mkOption {
          type = types.str;
          description = "Host patter for SSH";
        };
        addKeysToAgent = mkOption {
          type = types.bool;
          default = false;
          description = "Add keys to ssh-agent";
        };
        identityFile = mkOption {
          type = types.str;
          description = "Path to private key file";
        };
      };
    });
    default = [];
    description = "SSH match blocks";
  };
}
