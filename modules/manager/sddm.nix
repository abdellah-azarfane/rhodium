{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.manager.sddm;
  session = config.manager._effectiveSession or null;
in
{
  options.manager.sddm = {
    enable = mkEnableOption "SDDM display manager with custom configuration";
  };

  config = mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      settings = {
        General = {
          RememberLastUser = true;
          RememberLastSession = true;
          LoginTimeout = 120;
          SessionTimeout = 60;
        } // optionalAttrs (session != null) {
          DefaultSession = if session == "hyprland" then "hyprland" else "niri";
        };
    };
  };

    # Add optional tools
    environment.systemPackages = with pkgs; [
      kdePackages.sddm-kcm
    ];

    security.pam.services.sddm.enableGnomeKeyring = true;
    security.pam.services.sddm-greeter.enableGnomeKeyring = true;
    security.polkit.enable = true;
  };
}
