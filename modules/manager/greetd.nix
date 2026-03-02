{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.manager.greetd;
  session = config.manager._effectiveSession or null;
  sessionCmd =
    if session == "hyprland" then "${pkgs.hyprland}/bin/Hyprland"
    else if session == "niri" then "${pkgs.niri}/bin/niri-session"
    else null;
in
{
  options.manager.greetd = {
    enable = mkEnableOption "greetd (tuigreet) display manager";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time" + optionalString (sessionCmd != null) " --cmd ${sessionCmd}";
          user = "greeter";
        };
      };
    };
  };
}
