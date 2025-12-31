{ inputs, lib, rhodiumRoot, mkPkgs, mkPkgsUnstable, mkRhodiumLib, mkContext, ... }:
let
  nixpkgsLib = inputs.nixpkgs.lib;

  hosts = import (rhodiumRoot + "/flake/hosts.nix") { inherit rhodiumRoot; };

  mkNixosHost =
    hostName: hostDef:
    let
      system = hostDef.system or "x86_64-linux";
      pkgs = mkPkgs system;
      pkgs-unstable = mkPkgsUnstable system;
      rhodiumLib = mkRhodiumLib pkgs;
      ctx = mkContext { inherit pkgs pkgs-unstable rhodiumLib; };

      hmUserName = ctx.userData.user_001.username or "user_001";

      hmExtraSpecialArgsBase = {
        inherit (ctx)
          pkgs-unstable
          rhodiumLib
          userData
          userPreferences
          userExtras
          targetTheme
          ;
        inherit inputs;
        user = ctx.userData.user_001 or { };
        host = ctx.hostData.${hostName} or { };
        theme = ctx.selectedTheme;
        fishPlugins = inputs.rhodium-alloys.fish;
        yaziPlugins = inputs.rhodium-alloys.yazi;
      };

      includeChiaroscuroTheme = hostDef.home.includeChiaroscuroTheme or false;
      includeModuleGenerators = hostDef.home.includeModuleGenerators or false;

      hmExtraSpecialArgs =
        hmExtraSpecialArgsBase
        // nixpkgsLib.optionalAttrs includeChiaroscuroTheme { chiaroscuroTheme = ctx.chiaroscuroTheme; }
        // nixpkgsLib.optionalAttrs includeModuleGenerators {
          inherit (rhodiumLib.generators.moduleGenerators) mkModule mkPkgModule;
        };

      hostModule = hostDef.module or (rhodiumRoot + "/hosts/${hostName}");
      enableDisko = hostDef.disko or false;
    in
    nixpkgsLib.nixosSystem {
      inherit system pkgs;
      modules =
        [
          hostModule
          inputs.home-manager.nixosModules.home-manager
        ]
        ++ nixpkgsLib.optionals enableDisko [ inputs.disko.nixosModules.disko ]
        ++ [
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";

              users.${hmUserName} = import (rhodiumRoot + "/users/user_001");

              extraSpecialArgs = hmExtraSpecialArgs;
            };
          }
        ];

      specialArgs = {
        inherit pkgs-unstable inputs rhodiumLib;
        users = ctx.userData;
        host = ctx.hostData.${hostName} or { };
      };
    };
in
{
  config.flake.nixosConfigurations = nixpkgsLib.mapAttrs mkNixosHost hosts;
}
