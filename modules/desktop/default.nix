{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./bar
    ./de
    ./files
    ./fonts
    ./games
    ./notifications
    ./wm
  ];
}
