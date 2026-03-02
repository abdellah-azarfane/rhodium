# Common configuration shared across all hosts
# Inspired by patterns from various NixOS configs
{ inputs
, outputs
, lib
, config
, pkgs
, userName
, ...
}:

let
  username = userName;
in
{


  # Import common system modules
  imports = [
    ../modules
  ];

  # Common Home Manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs outputs userName;
    };
    users.${username} = {
      imports = [
        ../user
      ];

      # Stylix HM targets: avoid evaluation warnings by specifying defaults.
      stylix.targets.firefox.profileNames = [ "default" ];
      stylix.targets.librewolf.profileNames = [ "default" ];
      stylix.targets.qt.platform = "qtct";

      # Note: nixpkgs options are disabled when useGlobalPkgs is enabled
      # The system nixpkgs config (from modules/utils/nix.nix) will be used automatically
    };
  };
}

