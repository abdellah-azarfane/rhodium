{ inputs, lib, rhodiumRoot, ... }:
let
  nixpkgsLib = inputs.nixpkgs.lib;

  mkOverlaysWithInputs = import (rhodiumRoot + "/overlays");

  mkPkgs =
    system:
    let
      overlaysWithInputs = mkOverlaysWithInputs { inherit inputs; };
    in
    import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        input-fonts.acceptLicense = true;
        permittedInsecurePackages = [
          "jitsi-meet-1.0.8043"
        ];
      };
      overlays = [
        inputs.nur.overlays.default
        overlaysWithInputs.fonts
      ];
    };

  mkPkgsUnstable =
    system:
    let
      overlaysWithInputs = mkOverlaysWithInputs { inherit inputs; };
    in
    import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        inputs.nur.overlays.default
        overlaysWithInputs.fonts
      ];
    };

  mkRhodiumLib = pkgs: import (rhodiumRoot + "/lib") { lib = nixpkgsLib; inherit pkgs; };

  mkContext =
    { pkgs
    , rhodiumLib
    }:
    let
      # Data paths
      dataPath = rhodiumRoot + "/data";
      dataPathUsers = dataPath + "/users/";
      dataPathUserExtras = dataPathUsers + "/extras/";
      dataPathUserPreferences = dataPathUsers + "/preferences/";
      dataPathHosts = dataPath + "/hosts/";

      # Import user data
      userData =
        if builtins.pathExists (dataPathUsers + "/users.nix") then
          (import (dataPathUsers + "/users.nix")).users
        else
          { };

      # Import user preferences
      userPreferences =
        if builtins.pathExists dataPathUserPreferences then (import dataPathUserPreferences) else { };

      # Import and pack all user extras data
      userExtras = {
        path = dataPathUserExtras;

        bookmarksData =
          if builtins.pathExists (dataPathUserExtras + "/bookmarks.nix") then
            import (dataPathUserExtras + "/bookmarks.nix")
          else
            { };

        profilesData =
          if builtins.pathExists (dataPathUserExtras + "/profiles.nix") then
            import (dataPathUserExtras + "/profiles.nix")
          else
            { };

        appsData =
          if builtins.pathExists (dataPathUserExtras + "/apps.nix") then
            import (dataPathUserExtras + "/apps.nix")
          else
            { };
      };

      # Import host data
      hostData =
        if builtins.pathExists (dataPathHosts + "/hosts.nix") then
          (import (dataPathHosts + "/hosts.nix")).hosts
        else
          { };

      # Theme selection
      getThemeConfig =
        themeName: variant:
        let
          themePath = rhodiumRoot + "/home/assets/themes/${themeName}.nix";
          themeConfig =
            if builtins.pathExists themePath then
              import themePath { inherit pkgs; }
            else
              import (rhodiumRoot + "/home/assets/themes/chiaroscuro.nix") { inherit pkgs; };
        in
        if variant == "light" && themeConfig.theme ? light then
          themeConfig.theme.light
        else
          themeConfig.theme.dark;

      # User's theme preferences with fallbacks
      userThemeName = userPreferences.theme.name or "chiaroscuro";
      userThemeVariant = userPreferences.theme.variant or "dark";
      selectedTheme = getThemeConfig userThemeName userThemeVariant;

      # TODO: Temporary theme imports
      # While we have the complete theme module set up
      targetTheme = import (rhodiumRoot + "/home/modules/themes.nix") { inherit pkgs inputs; };

      chiaroscuroTheme = inputs.chiaroscuro.themes.kanso-zen;
    in
    {
      inherit
        pkgs
        rhodiumLib
        userData
        userPreferences
        userExtras
        hostData
        selectedTheme
        targetTheme
        chiaroscuroTheme
        ;
    };
in
{
  config = {
    systems = [ "x86_64-linux" ];

    _module.args = {
      inherit mkPkgs mkPkgsUnstable mkRhodiumLib mkContext;
    };

    perSystem =
      { system, ... }:
      let
        pkgs = mkPkgs system;
      in
      {
        formatter = pkgs.nixfmt-rfc-style;
        devShells.default = import (rhodiumRoot + "/devshells/nixos.nix") { inherit pkgs inputs lib; };
      };

    flake = {
      # Standard flake output: attrset of overlays (final: prev: { ... }).
      overlays = (import (rhodiumRoot + "/overlays") { inherit inputs; });
    };
  };
}
