# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ lib
, config
, osConfig ? { }
, userName ? null
, ...
}:
let
  stylixSync =
    {
      stylix.enable = lib.mkDefault (if osConfig ? stylix then (osConfig.stylix.enable or false) else false);
    }
    // lib.optionalAttrs (osConfig ? stylix && osConfig.stylix ? base16Scheme) {
      stylix.base16Scheme = lib.mkDefault osConfig.stylix.base16Scheme;
    }
    // lib.optionalAttrs (osConfig ? stylix && osConfig.stylix ? image) {
      stylix.image = lib.mkDefault osConfig.stylix.image;
    };
in
({
  # You can import other home-manager modules here
  imports = [
    ../home/apps
    #   ../assets
    ../home/desktop
    ../home/development
    ../home/environment
    ../home/modules
    ../home/overlays
    ../home/security
    ../home/services
    ../home/shells
    ../home/system
    ../home/utils
    ../home/virtualization
  ];
  # --- Ix Home Modules ---
  ix = {
    apps.media.audio = {
      spotify.enable = true;
      csound.enable = false;
      ncspot.enable = false;
      puredata.enable = false;
      rmpc.enable = false;
      sonicpi.enable = false;
      supercollider.enable = false;
      tidal.enable = false;
      tidalcycles.enable = false;
      vcv-rack.enable = false;
    };
    development.languages = {
      haskell.enable = true;
    };
  };
  # Custom services
  # NOTE: These are custom services located under home/services, and run as systemd daemons
  userExtraServices = {
    eww.enable = lib.mkDefault false;
    kmonad.enable = true;
    mako.enable = false;
    neovim-daemon.enable = false;
    swaybg.enable = false;
    system-keyring.enable = true;
    waybar.enable = lib.mkDefault false;
    wlsunset.enable = false;
    hdmiAutoSwitch.enable = true;
  };
  # Username is driven by the host (passed via `home-manager.extraSpecialArgs`).
  home.username = lib.mkDefault (if userName != null then userName else "zayron");
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  # Stylix targets: force defaults to avoid evaluation warnings.
  stylix.targets.firefox.profileNames = lib.mkForce [ "default" ];
  stylix.targets.librewolf.profileNames = lib.mkForce [ "default" ];
  stylix.targets.qt.platform = lib.mkForce "qtct";

  home.stateVersion = "26.05";
} // stylixSync)
