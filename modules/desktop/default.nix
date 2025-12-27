{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./bar
    ./files
    ./fonts
    ./notifications
    #  ./wm/hyprland/intel.nix # TODO: This needs to be dealt with here as well declaratively based on hardware
  ];
}
