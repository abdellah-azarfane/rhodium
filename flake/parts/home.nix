{ inputs, lib, rhodiumRoot, mkPkgs, mkPkgsUnstable, mkRhodiumLib, mkContext, ... }:
let
  nixpkgsLib = inputs.nixpkgs.lib;
  system = "x86_64-linux";

  pkgs = mkPkgs system;
  pkgs-unstable = mkPkgsUnstable system;
  rhodiumLib = mkRhodiumLib pkgs;
  ctx = mkContext { inherit pkgs pkgs-unstable rhodiumLib; };
in
{
  config.flake.homeConfigurations = {
    user_001 = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ (rhodiumRoot + "/users/user_001") ];
      extraSpecialArgs = {
        inherit
          pkgs-unstable
          inputs
          rhodiumLib
          ;
        userData = ctx.userData;
        user = ctx.userData.user_001 or { };
        host = { };
        theme = ctx.selectedTheme;
        targetTheme = ctx.targetTheme; # TODO: This is temporary
        inherit (ctx) userPreferences userExtras;
        fishPlugins = inputs.rhodium-alloys.fish;
        yaziPlugins = inputs.rhodium-alloys.yazi;
      };
    };
  };
}
