{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.manager;

  effectiveSession =
    if (cfg.session or null) == null || cfg.session == "auto" then
      if (config.programs.hyprland.enable or false) then "hyprland"
      else if (config.programs.niri.enable or false) then "niri"
      else null
    else if cfg.session == "none" then null
    else cfg.session;

  enabledCount = length (filter (x: x) [
    (config.manager.gdm.enable or false)
    (config.manager.sddm.enable or false)
    (config.manager.lightdm.enable or false)
    (config.manager.greetd.enable or false)
    (config.manager.regreet.enable or false)
    (config.manager.tty.enable or false)
  ]);
in
{
  imports = [
    ./gdm.nix
    ./lightdm.nix
    ./greetd.nix
    ./regreet.nix
    ./sddm.nix
    ./tty.nix
  ];

  options.manager.type = mkOption {
    type = types.nullOr (types.enum [
      "sddm"
      "gdm"
      "lightdm"
      "greetd"
      "regreet"
      "tty"
      "none"
    ]);
    default = null;
    description = ''
      Select a single login/display manager.

      Setting this will auto-enable the matching `manager.<name>.enable` option.
      Use `"none"` to keep them all disabled.
    '';
    example = "sddm";
  };

  options.manager.session = mkOption {
    type = types.enum [ "auto" "hyprland" "niri" "none" ];
    default = "auto";
    description = ''
      Default session to launch from display managers.

      - `auto`: use Hyprland if `programs.hyprland.enable`, else Niri if `programs.niri.enable`.
      - `none`: don't force a default session.
    '';
    example = "hyprland";
  };

  options.manager._effectiveSession = mkOption {
    type = types.nullOr (types.enum [ "hyprland" "niri" ]);
    default = effectiveSession;
    internal = true;
    readOnly = true;
    description = "Computed session choice used by manager modules.";
  };

  config = mkMerge [
    (mkIf (cfg.type == "sddm") { manager.sddm.enable = mkDefault true; })
    (mkIf (cfg.type == "gdm") { manager.gdm.enable = mkDefault true; })
    (mkIf (cfg.type == "lightdm") { manager.lightdm.enable = mkDefault true; })
    (mkIf (cfg.type == "greetd") { manager.greetd.enable = mkDefault true; })
    (mkIf (cfg.type == "regreet") { manager.regreet.enable = mkDefault true; })
    (mkIf (cfg.type == "tty") { manager.tty.enable = mkDefault true; })
    (mkIf (cfg.type == "none") { })

    {
      assertions = [
        {
          assertion = enabledCount <= 1;
          message = "Only one manager may be enabled at a time. Use `manager.type = \"...\";` or enable exactly one of `manager.{sddm,gdm,lightdm,greetd,regreet,tty}.enable`.";
        }
      ];
    }
  ];
}
