{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.userExtraServices.hdmiAutoSwitch;
in
{
  options.userExtraServices.hdmiAutoSwitch.enable = mkEnableOption "HDMI auto-switch user service";

  config = mkIf cfg.enable {
    systemd.user.services.hdmi-hotplug = {
      Unit.Description = "HDMI/eDP auto‑switch";

      Service = {
        Type = "oneshot";
        ExecStart = "%h/.local/bin/utils/utils-switch-displays.sh";
      };
    };
  };
}
