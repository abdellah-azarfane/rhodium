{ self, inputs, ... }:
let
  inherit (self) outputs;

  supportedSystems = [ "x86_64-linux" "aarch64-linux" ];

  mkHome = { system, userName }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs outputs userName;
        # Standalone HM has no NixOS `osConfig`; provide a minimal one so modules
        # that branch on `osConfig` (especially in `imports`) don't recurse.
        osConfig = {
          desktop = {
            wm.type = "none";
            de.type = "none";
          };
          stylix.enable = false;
        };
      };
      modules = [
        (
          if inputs.stylix ? homeModules then inputs.stylix.homeModules.stylix
          else if inputs.stylix ? homeManagerModules then inputs.stylix.homeManagerModules.stylix
          else throw "Stylix flake does not export a Home Manager module"
        )
        ../user
      ];
    };
in
{
  flake = {
    homeModules = {
      irix = import ../user;
    };

    # Back-compat alias (can be removed later)
    homeManagerModules = self.homeModules;
    # Fix ME
    homeConfigurations = builtins.listToAttrs (
      map
        (system: {
          name = "zayron@${system}";
          value = mkHome { inherit system; userName = "zayron"; };
        })
        supportedSystems
    );
  };
}
