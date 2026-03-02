{ lib, config, options, ... }:

let
  cfg = config.desktop.de.cosmic;
  hasCosmic = lib.hasAttrByPath [ "services" "desktopManager" "cosmic" "enable" ] options;
in
{
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = hasCosmic;
        message = "desktop.de.cosmic.enable is set but this nixpkgs does not provide services.desktopManager.cosmic.enable.";
      }
    ];

    services.desktopManager.cosmic.enable = true;
  };
}
