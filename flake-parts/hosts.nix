{ self, inputs, ... }:
let
  inherit (self) outputs;
  mkHost = import ../lib/mkHost.nix;

  wmStyles = [ "hyprland" "niri" "sway" "i3" "river" "mangowc" "none" ];
  deStyles = [ "plasma6" "gnome" "xfce" "cosmic" "none" ];

  themeSchemeFor = system: themeStyle:
    let
      base16 = inputs.nixpkgs.legacyPackages.${system}.base16-schemes;
    in
    if themeStyle == "gruvbox" then "${base16}/share/themes/gruvbox-dark-hard.yaml"
    else if themeStyle == "gruvbox-material" then "${base16}/share/themes/gruvbox-material-dark-hard.yaml"
    else if themeStyle == "catppuccin" || themeStyle == "catppuccin-mocha" then "${base16}/share/themes/catppuccin-mocha.yaml"
    else if themeStyle == "rose-pine" || themeStyle == "rose-pine-moon" then "${base16}/share/themes/rose-pine-moon.yaml"
    else if themeStyle == "kanagawa" || themeStyle == "kanagawa-dragon" then "${base16}/share/themes/kanagawa-dragon.yaml"
    else if themeStyle == "oxocarbon" || themeStyle == "oxocarbon-dark" || themeStyle == "future" then "${base16}/share/themes/oxocarbon-dark.yaml"
    else if themeStyle == "outrun" || themeStyle == "outrun-dark" then "${base16}/share/themes/outrun-dark.yaml"
    else if themeStyle == "dracula" then "${base16}/share/themes/dracula.yaml"
    else if themeStyle == "nord" then "${base16}/share/themes/nord.yaml"
    else if themeStyle == "onedark" || themeStyle == "onedark-dark" then "${base16}/share/themes/onedark-dark.yaml"
    else null;

  # NOTE: Themes come from nixpkgs `base16-schemes`.
  # You can list them with:
  #   ls "${inputs.nixpkgs.legacyPackages.x86_64-linux.base16-schemes}/share/themes"
  hostDefaults = {
    laptop = {
      system = "x86_64-linux";
      userName = "zayron";
      desktopStyle = "hyprland";
      themeStyle = "oxocarbon";
      extraModules = [ ];
    };

    desktop = {
      system = "x86_64-linux";
      userName = "zayron";
      desktopStyle = "hyprland";
      themeStyle = "gruvbox";
      extraModules = [ ];
    };

    khadim = {
      system = "x86_64-linux";
      userName = "zayron";
      desktopStyle = "none";
      themeStyle = "gruvbox";
      extraModules = [ ];
    };
  };

  mkHostSettingsModule = { userName, desktopStyle, themeStyle, themeScheme ? null, ... }:
    { lib, ... }:
    let
      isWm = builtins.elem desktopStyle wmStyles;
      isDe = builtins.elem desktopStyle deStyles;
    in
    lib.mkMerge [
      {
        assertions = [
          {
            assertion = isWm || isDe;
            message = "flake host setting `desktopStyle` must be a supported WM or DE.";
          }
        ];

        users.users.${userName} = {
          isNormalUser = lib.mkDefault true;
          createHome = lib.mkDefault true;
          home = lib.mkDefault "/home/${userName}";
          extraGroups = lib.mkDefault [ "wheel" ];
        };
      }

      (lib.mkIf (isWm && desktopStyle != "none") {
        desktop.wm.type = lib.mkDefault desktopStyle;
      })

      (lib.mkIf (isDe && desktopStyle != "none") {
        desktop.de.type = lib.mkDefault desktopStyle;
      })

      (lib.mkIf (desktopStyle == "none") {
        desktop.wm.type = lib.mkDefault "none";
        desktop.de.type = lib.mkDefault "none";
      })

      (lib.mkIf (themeStyle != "none" && themeScheme != null) {
        stylix.enable = lib.mkDefault true;
        stylix.base16Scheme = lib.mkDefault themeScheme;
      })
    ];
in
{
  flake.nixosConfigurations = {
    # MY LAPTOP
    laptop = mkHost
      {
        hostName = "laptop";
        system = hostDefaults.laptop.system;
        modules =
          let
            extra = hostDefaults.laptop.extraModules or [ ];
          in
          [
            ../hosts/laptop
          ] ++ extra ++ [
            (mkHostSettingsModule (hostDefaults.laptop // {
              themeScheme = themeSchemeFor hostDefaults.laptop.system hostDefaults.laptop.themeStyle;
            }))
          ];
        specialArgs = hostDefaults.laptop;
      }
      { inherit inputs outputs; };

    # MY DESKTOP PC
    desktop = mkHost
      {
        hostName = "desktop";
        system = hostDefaults.desktop.system;
        modules =
          let
            extra = hostDefaults.desktop.extraModules or [ ];
          in
          [
            ../hosts/desktop
          ] ++ extra ++ [
            (mkHostSettingsModule (hostDefaults.desktop // {
              themeScheme = themeSchemeFor hostDefaults.desktop.system hostDefaults.desktop.themeStyle;
            }))
          ];
        specialArgs = hostDefaults.desktop;
      }
      { inherit inputs outputs; };

    # MY HOME SERVER
    khadim = mkHost
      {
        hostName = "khadim";
        system = hostDefaults.khadim.system;
        modules =
          let
            extra = hostDefaults.khadim.extraModules or [ ];
          in
          [
            ../hosts/khadim
          ] ++ extra ++ [
            (mkHostSettingsModule (hostDefaults.khadim // {
              themeScheme = themeSchemeFor hostDefaults.khadim.system hostDefaults.khadim.themeStyle;
            }))
          ];
        specialArgs = hostDefaults.khadim;
      }
      { inherit inputs outputs; };
  };
}
