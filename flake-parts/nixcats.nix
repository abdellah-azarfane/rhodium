{ inputs, ... }:
let
  nixpkgs = inputs.nixpkgs;
  inherit (inputs.nixCats) utils;

  nixcatsCfg = import ../home/apps/editors/nixcats/nixcats.nix {
    inherit inputs;
    nixCats = inputs.nixCats;
  };

  inherit (nixcatsCfg)
    luaPath
    extra_pkg_config
    dependencyOverlays
    categoryDefinitions
    packageDefinitions
    defaultPackageName
    ;

  nixosModule = utils.mkNixosModules {
    moduleNamespace = [ defaultPackageName ];
    inherit
      defaultPackageName
      dependencyOverlays
      luaPath
      categoryDefinitions
      packageDefinitions
      extra_pkg_config
      nixpkgs
      ;
  };

  homeModule = utils.mkHomeModules {
    moduleNamespace = [ defaultPackageName ];
    inherit
      defaultPackageName
      dependencyOverlays
      luaPath
      categoryDefinitions
      packageDefinitions
      extra_pkg_config
      nixpkgs
      ;
  };

  overlays = utils.makeOverlays luaPath {
    inherit nixpkgs dependencyOverlays extra_pkg_config;
  } categoryDefinitions packageDefinitions defaultPackageName;
in
{
  flake = {
    overlays = overlays;
    nixosModules.${defaultPackageName} = nixosModule;
    nixosModules.default = nixosModule;
    homeModules.${defaultPackageName} = homeModule;
    homeModules.default = homeModule;
  };

  perSystem = { system, pkgs, ... }:
    let
      nixCatsBuilder = utils.baseBuilder luaPath {
        inherit nixpkgs system dependencyOverlays extra_pkg_config;
      } categoryDefinitions packageDefinitions;
      nvimPkg = nixCatsBuilder defaultPackageName;
      allPackages = utils.mkAllWithDefault nvimPkg;
    in
    {
      packages = allPackages // { ${defaultPackageName} = nvimPkg; };
      devShells.${defaultPackageName} = pkgs.mkShell {
        name = defaultPackageName;
        packages = [ nvimPkg ];
        inputsFrom = [ ];
        shellHook = ''
        '';
      };
    };
}
