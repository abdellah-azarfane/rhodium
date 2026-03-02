{ inputs
, lib
, config
, pkgs
, ...
}:

let
  cfg = config.ix.desktop.widgets.ags;
  agsHmModule =
    if inputs.ags ? homeModules then inputs.ags.homeModules.default
    else inputs.ags.homeManagerModules.default;
  astalPkgs = with pkgs.astal; [
    astal4
    apps
    battery
    bluetooth
    mpris
    network
    notifd
    powerprofiles
    tray
    wireplumber
  ];
in
{
  options.ix.desktop.widgets.ags = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable AGS.";
    };

    manageConfig = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install and manage the Irix AGS config.";
    };
  };

  imports = [ agsHmModule ];

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.ags.enable = true;
    })

    (lib.mkIf (cfg.enable && cfg.manageConfig) {
      home.sessionVariables.GI_TYPELIB_PATH = lib.makeSearchPath "lib/girepository-1.0" astalPkgs;

      programs.ags = {
        configDir = ./ags;
        extraPackages = astalPkgs ++ (with pkgs; [
          jq
          curl
          fzf
        ]);
      };
    })
  ];
}
